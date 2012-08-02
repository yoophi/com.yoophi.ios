#import "MontyHallViewController.h"

@implementation MontyHallViewController
@synthesize session, statusField, door1, door2, door3, doors;

#pragma mark -
#pragma mark door utilities

-(void) setAllDoorsToHidden:(BOOL) shouldBeHidden {
    for (UIButton *door in self.doors) {
        door.hidden = shouldBeHidden;
    }
}
-(void) setDoorNumber:(NSUInteger) doorNumber toHidden:(BOOL) shouldBeHidden {
    ((UIButton *)[self.doors objectAtIndex:doorNumber -1]).hidden = shouldBeHidden;
}

-(void) setAllDoorsToEnabled:(BOOL) shouldBeEnabled {
    for (UIButton *door in self.doors) {
        door.userInteractionEnabled = shouldBeEnabled;
    }
}
-(void) setAllDoorsRedExcept:(UIButton *)door {
    for (UIButton *door in self.doors){
        door.titleLabel.textColor = [UIColor redColor];
    }
    [door setTitleColor:[UIColor greenColor] 
               forState: UIControlStateNormal];
}
#pragma mark -
#pragma mark archiving utilities
//START:code.devices.invoke
-(void) invokeMethodForKey:(NSString *) keyName 
                 ifFoundIn:(NSKeyedUnarchiver *)unarchiver {
    if ([unarchiver containsValueForKey:keyName]) {
        [self performSelector:NSSelectorFromString(keyName) 
                   withObject:[NSNumber numberWithInt:[unarchiver 
                                             decodeIntForKey:keyName]]];
    }
}
//END:code.devices.invoke
//START:code.devices.send
-(void) sendMessage:(NSString *)message 
            forDoor:(NSUInteger) doorNumber {
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = 
      [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeInt:doorNumber forKey:message];
    [archiver finishEncoding];
    NSError *error2;
    //START:code.devices.actualsend
    [self.session sendDataToAllPeers:data 
                        withDataMode:GKSendDataReliable 
                               error:&error2];
    //END:code.devices.actualsend
    [archiver release];
    [data release];
}
//END:code.devices.send

#pragma mark -
#pragma mark handle contestant messages
//START:code.devices.disconnect
-(void) finalDoorSelected:(NSNumber *)doorNumberObject {
    NSUInteger doorNumber = [doorNumberObject intValue];
    [self setAllDoorsToHidden:YES];
    [self setDoorNumber:doorNumber toHidden:NO];
    if (doorNumber == prizeDoor) {
        self.statusField.text = @"The contestant wins.";
    } else {
        self.statusField.text = @"The contestant loses.";
    }
    //START_HIGHLIGHT
    [self.session disconnectFromAllPeers];
    //END_HIGHLIGHT
}
//END:code.devices.disconnect
-(void)contestantDidChooseDoor:(NSNumber *)doorNumberObject {
    NSUInteger doorNumber = [doorNumberObject intValue];
    [self setDoorNumber:doorNumber toHidden:YES];
    [self setDoorNumber:prizeDoor toHidden:YES];
    [self setAllDoorsToEnabled:YES];
    self.statusField.text = @"Choose (one of) the visible red door(s).";
}
//START:code.devices.receive
- (void) receiveData: (NSData*) data 
            fromPeer: (NSString*) peerID
           inSession: (GKSession*) session 
             context: (void*) context {
    NSKeyedUnarchiver *unarchiver =
    [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [self invokeMethodForKey:@"contestantDidChooseDoor:" ifFoundIn:unarchiver];
    [self invokeMethodForKey:@"finalDoorSelected:" ifFoundIn:unarchiver];
}
//END:code.devices.receive
#pragma mark -
#pragma mark actions
-(void) revealDoor:(id)sender {
    [self setAllDoorsToHidden:NO];
    [self setAllDoorsToEnabled:NO];
    [self setDoorNumber:((UIButton *)sender).tag toHidden:YES];
    self.statusField.text = @"The contestant needs to switch or stay.";
    [self sendMessage:@"revealAnEmptyDoor:" forDoor:((UIButton *)sender).tag];
    isPrizeInPlace = YES;
}
//START:code.devices.placeprize
-(void) placePrizeBehindDoor:(id)sender {
    [self setAllDoorsToEnabled:NO];
    self.statusField.text = @"Wait while contestant makes their choice.";
    prizeDoor = ((UIButton *)sender).tag;
    [self setAllDoorsRedExcept:(UIButton *)sender];
    [self sendMessage:@"hideThePrize:" forDoor:prizeDoor];
    isPrizeInPlace = YES;
}
//END:code.devices.placeprize
//START:code.devices.action
-(IBAction) selectDoor:(id)sender {
    if (isPrizeInPlace) {
        [self revealDoor:sender];
    } else {
        [self placePrizeBehindDoor:sender];
    }
}
//END:code.devices.action
#pragma mark -
#pragma mark session lifecycle
-(void) launchClientSession {
    self.session = [[GKSession alloc] initWithSessionID:@"example" 
                                            displayName:@"Monty" 
                                            sessionMode:GKSessionModeClient];
    self.session.delegate = self;
    self.session.available = YES;
}
-(void) connectToAvailablePeer:(NSString *) peerID {
    self.statusField.text = [NSString stringWithFormat: @"Connecting to %@.", 
                             [self.session displayNameForPeer:peerID]];
    [self.session connectToPeer:peerID withTimeout:3000];
}
//START:code.devices.begin
-(void) beginSession {
    self.statusField.text = @"Pick a door to place the prize.";
    self.session.available = NO;
    //START_HIGHLIGHT
    self.doors = [NSArray arrayWithObjects:self.door1, self.door2, 
                                           self.door3, nil];
    [self setAllDoorsToHidden:NO];
    [self.session setDataReceiveHandler:self withContext:nil];
    [door1 release];
    [door2 release];
    [door3 release];
    //END_HIGHLIGHT
}
//END:code.devices.begin
- (void)session:(GKSession *)session 
           peer:(NSString *)peerID 
 didChangeState:(GKPeerConnectionState)state {
    switch (state) {
        case GKPeerStateAvailable:
            [self connectToAvailablePeer:peerID];
            break;
        case GKPeerStateConnected:
            [self beginSession];
            break;
        case GKPeerStateDisconnected:
            //handle services disconnecting
            break;
        default: 
            break;
    }    
}
#pragma mark standard vc methods
- (void)viewDidLoad {
    [super viewDidLoad]; 
    [self launchClientSession];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)dealloc {
    [session release], session = nil;
    [statusField release], statusField = nil;
    [doors release], doors = nil;
    [super dealloc];
}

@end
