#import "MontyHallViewController.h"

@implementation MontyHallViewController
@synthesize session, statusField;

//START:code.devices.launch
-(void) launchClientSession {
    self.session = [[GKSession alloc] initWithSessionID:@"example" 
                                            displayName:@"Monty" 
                    //START_HIGHLIGHT
                                            sessionMode:GKSessionModeClient];
    //END_HIGHLIGHT
    self.session.delegate = self;
    self.session.available = YES;
}
//END:code.devices.launch
//START:code.devices.connect
-(void) connectToAvailablePeer:(NSString *) peerID {
    self.statusField.text = [NSString stringWithFormat: @"Connecting to %@.", 
                             [self.session displayNameForPeer:peerID]];
    [self.session connectToPeer:peerID withTimeout:3000];
}
//END:code.devices.connect
//START:code.devices.begin
-(void) beginSession {
    self.statusField.text = @"Pick a door to place the prize.";
    self.session.available = NO;
}
//END:code.devices.begin
- (void)viewDidLoad {
    [super viewDidLoad]; 
    [self launchClientSession];
}
//START:code.devices.change
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
//END:code.devices.change
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [session release], session = nil;
    [statusField release], statusField = nil;
    [super dealloc];
}

@end
