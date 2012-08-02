#import "ContestantAppDelegate.h"
#import "ContestantViewController.h"

@implementation ContestantAppDelegate

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
