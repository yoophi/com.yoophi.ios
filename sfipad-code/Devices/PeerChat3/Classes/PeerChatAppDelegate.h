#import <UIKit/UIKit.h>

@class PeerChatViewController;

@interface PeerChatAppDelegate : NSObject <UIApplicationDelegate> {
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PeerChatViewController *viewController;

@end

