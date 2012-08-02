#import <UIKit/UIKit.h>

@class FeelingsViewController;
@class MyFileManager;

@interface FeelingsAppDelegate : NSObject <UIApplicationDelegate> {
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet FeelingsViewController *viewController;
@property (nonatomic, retain) IBOutlet MyFileManager *myFM;
@end

