#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface PeerChatViewController : UIViewController<UITextFieldDelegate,GKPeerPickerControllerDelegate, GKSessionDelegate> {
}
@property(nonatomic, retain) GKPeerPickerController *peerPC;
@property(nonatomic, copy) NSString *userName;
@property(nonatomic, retain) GKSession *session;

@end

