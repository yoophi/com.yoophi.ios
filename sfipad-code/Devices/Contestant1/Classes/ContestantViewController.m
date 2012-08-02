#import "ContestantViewController.h"

@implementation ContestantViewController

@synthesize session, statusField;


//START:code.devices.launch
-(void)launchServerSession {
    self.session = [[GKSession alloc] initWithSessionID:@"example" 
                                            displayName:@"Contestant"
                                            sessionMode:GKSessionModeServer];
    self.session.delegate = self;   
    self.session.available = YES;
}
//END:code.devices.launch
- (void)viewDidLoad {
    [super viewDidLoad];
    [self launchServerSession];
}
//START:code.devices.request
- (void)session:(GKSession *)session 
didReceiveConnectionRequestFromPeer:(NSString *)peerID {
    self.statusField.text = 
         [NSString stringWithFormat:@"%@ has asked to be our host.", 
                             [self.session displayNameForPeer:peerID]];
    NSError *error1;
    [self.session acceptConnectionFromPeer:peerID error:&error1];
}
//END:code.devices.request
//START:code.devices.connect
-(void)connectToPeer:(NSString *) peerID{
    self.statusField.text = [NSString stringWithFormat: @"%@ is our host.", 
                             [self.session displayNameForPeer:peerID]];
    self.session.available = NO;
    [self.session setDataReceiveHandler:self withContext:nil];
}
//END:code.devices.connect
//START:code.devices.change
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
//END:code.devices.change
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}
- (void)dealloc {
    [session release], session = nil;
    [statusField release], statusField = nil;
    [super dealloc];
}

@end
