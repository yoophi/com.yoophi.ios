#import <UIKit/UIKit.h>

@class SingleFileViewController;

@interface SingleFileAppDelegate : NSObject <UIApplicationDelegate> {
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SingleFileViewController *viewController;

@end

