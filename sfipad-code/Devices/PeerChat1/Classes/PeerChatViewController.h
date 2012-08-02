#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface PeerChatViewController : UIViewController 
                  <UITextFieldDelegate,GKPeerPickerControllerDelegate> {
}
@property(nonatomic, retain) GKPeerPickerController *peerPC;
@property(nonatomic, copy) NSString *userName;

@end

