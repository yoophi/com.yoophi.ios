#import "SingleFileAppDelegate.h"
#import "SingleFileViewController.h"

@implementation SingleFileAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    [self.window addSubview:self.viewController.view];
    [self.window makeKeyAndVisible];
    [self.viewController applicationDidFinishLaunching];
	return YES;
}


- (void)dealloc {
    [viewController release], viewController = nil;
    [window release], window = nil;
    [super dealloc];
}


@end
