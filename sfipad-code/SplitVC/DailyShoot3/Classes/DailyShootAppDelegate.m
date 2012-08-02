#import "DailyShootAppDelegate.h"
#import "RootViewController.h"


@implementation DailyShootAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle
//START:code.split.launch
- (BOOL)application:(UIApplication *)application 
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window addSubview:self.navigationController.view];
    [self.window makeKeyAndVisible];
    return YES;
}
//END:code.split.launch

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

