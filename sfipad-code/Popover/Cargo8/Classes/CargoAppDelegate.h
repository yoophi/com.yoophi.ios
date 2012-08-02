#import <UIKit/UIKit.h>

@class CargoViewController;

@interface CargoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CargoViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CargoViewController *viewController;

@end

