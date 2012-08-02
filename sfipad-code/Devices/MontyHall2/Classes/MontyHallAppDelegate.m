#import "MontyHallAppDelegate.h"
#import "MontyHallViewController.h"

@implementation MontyHallAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {        
    [self.window addSubview:self.viewController.view];
    [self.window makeKeyAndVisible];
	return YES;
}


- (void)dealloc {
    [viewController release],viewController = nil;
    [window release], window = nil;
    [super dealloc];
}


@end
