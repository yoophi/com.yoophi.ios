#import "DailyShootAppDelegate_Pad.h"

@implementation DailyShootAppDelegate_Pad

@synthesize splitVC;

- (BOOL)application:(UIApplication *)application 
        didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {   
    [self.window addSubview:self.splitVC.view];
    return [super application:application
didFinishLaunchingWithOptions:launchOptions];
}
- (void)dealloc {
    [splitVC release], splitVC = nil;
	[super dealloc];
}
@end