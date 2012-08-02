#import "ContestantViewController.h"

@implementation ContestantViewController

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

#pragma mark -
#pragma mark archiver utilities

-(void) sendMessage:(NSString *)message forDoor:(NSUInteger) doorNumber {
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeInt:doorNumber forKey:message];
    [archiver finishEncoding];
    NSError *error2;
    [self.session sendDataToAllPeers:data withDataMode:GKSendDataReliable error:&error2];
    [archiver release];
    [data release];
}

#pragma mark -
#pragma mark actions

-(void) makeFinalChoice:(id)sender {
    NSUInteger finalDoorNumber = ((UIButton *) sender).tag;
    [self setAllDoorsToHidden:YES];
    [self setDoorNumber:finalDoorNumber toHidden:NO];
    if (finalDoorNumber == prizeDoorNumber) {
        self.statusField.text = @"You win.";
    } else {
        self.statusField.text = @"You lose.";
    }
    [self sendMessage:@"finalDoorSelected:" forDoor:((UIButton *)sender).tag];
}

-(void) choose:(id)sender {
    [((UIButton *)sender) setTitleColor:[UIColor orangeColor]  forState:UIControlStateNormal];
    [self setAllDoorsToEnabled:NO];
    selectedDoorNumber = ((UIButton *) sender).tag;
    [self sendMessage:@"contestantDidChooseDoor:" forDoor:((UIButton *) sender).tag];
    hasMadeInitialChoice = YES;
}
-(IBAction)selectDoor:(id)sender {
    if (hasMadeInitialChoice) {
        [self makeFinalChoice:sender];
    } else {
        [self choose:sender];
    }
}
#pragma mark -
#pragma mark handle game host messages
-(void)hideThePrize:(NSUInteger) doorNumber {
    self.doors = [NSArray arrayWithObjects:self.door1, self.door2, 
                                           self.door3, nil];
    [self setAllDoorsToHidden:NO];
    self.statusField.text = @"Which door do you choose?";
    prizeDoorNumber = doorNumber;
    [door1 release];
    [door2 release];
    [door3 release];
    
}
-(void) revealAnEmptyDoor: (NSUInteger) doorNumber {
    ((UIButton *)[self.doors objectAtIndex:doorNumber - 1]).hidden = YES;
    self.statusField.text = [NSString stringWithFormat:@"Nothing behind door %d. Switch or stay with %d?", doorNumber, selectedDoorNumber ];
    [self setAllDoorsToEnabled:YES];
}
//START:code.devices.receive
- (void) receiveData: (NSData*) data 
            fromPeer: (NSString*) peerID
		   inSession: (GKSession*) session 
             context: (void*) context {
    NSKeyedUnarchiver *unarchiver =
    [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    if ([unarchiver containsValueForKey:@"hideThePrize:"]) {
        [self hideThePrize: [unarchiver decodeIntForKey:@"hideThePrize:"]];
    } else if ([unarchiver containsValueForKey:@"revealAnEmptyDoor:"]) {
        [self revealAnEmptyDoor: 
                       [unarchiver decodeIntForKey:@"revealAnEmptyDoor:"]];
    }
}
//END:code.devices.receive
-(void)connectToPeer:(NSString *) peerID{
    self.statusField.text = [NSString stringWithFormat: @"%@ is our host.", 
                             [self.session displayNameForPeer:peerID]];
    self.session.available = NO;
    //START:code.devices.reg
    [self.session setDataReceiveHandler:self withContext:nil];
    //END:code.devices.reg
}
#pragma mark -
#pragma mark session delegate methods
- (void)session:(GKSession *)session 
           peer:(NSString *)peerID 
 didChangeState:(GKPeerConnectionState)state {
    switch (state) {
        case GKPeerStateConnected:
            [self connectToPeer:peerID];
            break;
        case GKPeerStateDisconnected:
            self.statusField.text = @"The host has disconnected.";
            //put actual handling code here
            break;
        default:
            break;
    }
}
- (void)session:(GKSession *)session 
didReceiveConnectionRequestFromPeer:(NSString *)peerID {
    self.statusField.text = [NSString stringWithFormat:@"%@ has asked to be our host.", 
                             [self.session displayNameForPeer:peerID]];
    NSError *error1;
    [self.session acceptConnectionFromPeer:peerID error:&error1];
}
#pragma mark -
#pragma mark setup
-(void)launchServerSession {
    self.session = [[GKSession alloc] initWithSessionID:@"example" 
                                            displayName:@"Contestant"
                                            sessionMode:GKSessionModeServer];
    self.session.delegate = self;   
    self.session.available = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self launchServerSession];
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
