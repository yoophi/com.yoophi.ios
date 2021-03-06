#import "FeelingsAppDelegate.h"
#import "FeelingsViewController.h"

@implementation FeelingsAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];

	return YES;
}


- (void)dealloc {
    [viewController release], viewController = nil;
    [window release], window = nil;
    [super dealloc];
}


@end
