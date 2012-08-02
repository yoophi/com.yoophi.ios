#import "FeelingsAppDelegate.h"
#import "FeelingsViewController.h"
#import "MyFileManager.h"

@implementation FeelingsAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize myFM;


- (BOOL)application:(UIApplication *)application 
        didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    [self.window addSubview:self.viewController.view];
    [self.window makeKeyAndVisible];
    [self.viewController setFileManager:self.myFM];
    [self.myFM applicationDidFinishLaunching:self.viewController.textView];
	return YES;
}

//START:code.file.terminate
-(void)applicationWillTerminate:(UIApplication *)application {
    [self.myFM applicationWillTerminate:self.viewController.textView];
    
}
//END:code.file.terminate


- (void)dealloc {
    [viewController release], viewController = nil;
    [myFM release], myFM = nil;
    [window release], window = nil;
    [super dealloc];
}


@end
