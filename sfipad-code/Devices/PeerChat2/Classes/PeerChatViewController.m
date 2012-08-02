#import "PeerChatViewController.h"

@implementation PeerChatViewController
@synthesize peerPC, userName, session;
//START:code.devices.session
-(GKSession *) session {
    if (!session) {
        self.session = [[GKSession alloc] initWithSessionID:@"example" 
                                                displayName:self.userName 
                                                sessionMode:GKSessionModePeer];
        self.session.delegate = self;
        [self.session setDataReceiveHandler:self withContext:nil];
    }
    return session;
}
//END:code.devices.session
-(void)createAndStartPeerPicker {
    self.peerPC =[[GKPeerPickerController alloc] init];
    self.peerPC.delegate = self;
    self.peerPC.connectionTypesMask =
    GKPeerPickerConnectionTypeNearby;
    [self.peerPC show];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (!self.userName) {
        self.userName = textField.text;
        [self createAndStartPeerPicker];
    }
    textField.text = @"";
    return YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark -
#pragma mark Peer Picker Delegate Methods
- (GKSession *)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type {
    return self.session;
}
//START:code.devices.connect
- (void)peerPickerController:(GKPeerPickerController *)picker 
              didConnectPeer:(NSString *)peerID 
                   toSession:(GKSession *)activeSession {
    self.session = activeSession;
    [picker dismiss];
    self.peerPC = nil;
}
//END:code.devices.connect
- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker {
    self.peerPC = nil;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
    [peerPC release], peerPC = nil;
    [userName release], userName = nil;
    [session release], session = nil;
    [super dealloc];
}

@end
