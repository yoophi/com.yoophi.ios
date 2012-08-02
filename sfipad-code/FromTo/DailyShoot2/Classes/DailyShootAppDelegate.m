#import "DailyShootAppDelegate.h"
#import "RootViewController.h"


@implementation DailyShootAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after app launch    
	
	[self.window addSubview:self.navigationController.view];
    [self.window makeKeyAndVisible];
	return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release], navigationController = nil;
	[window release], window = nil;
	[super dealloc];
}


@end

