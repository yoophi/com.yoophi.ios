#import <UIKit/UIKit.h>

@class BezierViewController;

@interface BezierAppDelegate : NSObject <UIApplicationDelegate> {
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet BezierViewController *viewController;

@end

