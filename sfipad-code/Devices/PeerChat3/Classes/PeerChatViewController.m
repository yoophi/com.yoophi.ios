#import "PeerChatViewController.h"

@implementation PeerChatViewController
@synthesize peerPC, userName, session, chatView;

-(void) addMessage:(NSString *) message forParticipant:(NSString *) participant {
    self.chatView.text = [NSString stringWithFormat:@"- %@: %@\n%@",
                          participant, message, self.chatView.text];
}
//START:code.devices.all
-(void) sendAllPeersMessage:(NSString *) message {
    [self.session sendDataToAllPeers:
                      [message dataUsingEncoding:NSUTF8StringEncoding]
                        withDataMode:GKSendDataReliable 
                               error:nil];
}
//END:code.devices.all
-(GKSession *) session {
    if (!session) {
        self.session = [[GKSession alloc] initWithSessionID:@"example" displayName:self.userName sessionMode:GKSessionModePeer];
        self.session.delegate = self;
        [self.session setDataReceiveHandler:self withContext:nil];
    }
    return session;
}


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
        textField.placeholder = @"Enter Message";
    } else {
        [self addMessage:textField.text forParticipant:self.userName];
        [self sendAllPeersMessage:textField.text];
    }
    textField.text = @"";
    return YES;
    
}
//START:code.devices.receive
- (void) receiveData: (NSData*) data 
            fromPeer: (NSString*) peerID
           inSession: (GKSession*) session 
             context: (void*) context {
    [self addMessage:[[[NSString alloc] initWithData:data 
                                            encoding:NSUTF8StringEncoding] 
                      autorelease] 
      forParticipant:[self.session displayNameForPeer:peerID]];
}
//END:code.devices.receive

- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark -
#pragma mark Peer Picker Delegate Methods
- (GKSession *)peerPickerController:(GKPeerPickerController *)picker 
           sessionForConnectionType:(GKPeerPickerConnectionType)type {
    return self.session;
}
- (void)peerPickerController:(GKPeerPickerController *)picker 
              didConnectPeer:(NSString *)peerID 
                   toSession:(GKSession *)activeSession {
    self.session = activeSession;
    [picker dismiss];
    self.peerPC = nil;
}
- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker {
    self.peerPC = nil;
}

#pragma mark -
#pragma mark Session Delegate Methods
//START:code.devices.disconnect
- (void)session:(GKSession *)session 
           peer:(NSString *)peerID 
 didChangeState:(GKPeerConnectionState)state {    
    switch (state) {
        case GKPeerStateDisconnected:
            [self addMessage:@"*** has disconnected"
              forParticipant:[self.session displayNameForPeer:peerID]];
            //handle services disconnecting
            break;
        default: 
            break;
    }    
}
//END:code.devices.disconnect

- (void)dealloc {
    [peerPC release], peerPC = nil;
    [userName release], userName = nil;
    [session release], session = nil;
    [chatView release], chatView = nil;
    [super dealloc];
}

@end
