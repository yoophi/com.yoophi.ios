#import "DailyShootAppDelegate.h"

@implementation DailyShootAppDelegate

@synthesize window, navigationController;

- (BOOL)application:(UIApplication *)application 
           didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {   
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc {
	[navigationController release], navigationController = nil ;
	[window release], window = nil ;
	[super dealloc];
}

@end

