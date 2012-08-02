#import "DailyShootAppDelegate_Phone.h"

@implementation DailyShootAppDelegate_Phone

- (BOOL)application:(UIApplication *)application 
        didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {   
    [self.window addSubview:self.navigationController.view];
    return [super application:application
didFinishLaunchingWithOptions:launchOptions];
}

@end