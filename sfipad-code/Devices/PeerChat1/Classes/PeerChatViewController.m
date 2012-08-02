#import "PeerChatViewController.h"

@implementation PeerChatViewController
@synthesize peerPC, userName;
//START:code.devices.peer
-(void)createAndStartPeerPicker {
    self.peerPC =[[GKPeerPickerController alloc] init];
    self.peerPC.delegate = self;
    self.peerPC.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
    [self.peerPC show];
}
//END:code.devices.peer
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (!self.userName) {
        self.userName = textField.text;
        [self createAndStartPeerPicker];
    }
    textField.text = @"";
    return YES;    
}
- (void)dealloc {
    [userName release], userName = nil;
    [peerPC release], peerPC = nil;
    [super dealloc];
}
@end
