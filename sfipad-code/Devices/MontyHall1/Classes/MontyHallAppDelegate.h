#import <UIKit/UIKit.h>

@class MontyHallViewController;

@interface MontyHallAppDelegate : NSObject <UIApplicationDelegate> {
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MontyHallViewController *viewController;

@end

