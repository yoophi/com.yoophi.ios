#import "DailyShootAppDelegate.h"
#import "RootViewController.h"


@implementation DailyShootAppDelegate

@synthesize window;
@synthesize navigationController, splitVC;


#pragma mark -
#pragma mark Application lifecycle
//START:code.split.launch
- (BOOL)application:(UIApplication *)application 
           didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {   
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self.window addSubview:self.splitVC.view];
    } else {
        [self.window addSubview:self.navigationController.view];
    }
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
	[navigationController release], navigationController = nil ;
	[window release], window = nil ;
    [splitVC release], splitVC = nil;
	[super dealloc];
}


@end

