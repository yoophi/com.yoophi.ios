#import "FeelingsAppDelegate.h"
#import "FeelingsViewController.h"
#import "MyFileManager.h"

@implementation FeelingsAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize myFM;

//START:code.documents.app
- (BOOL)application:(UIApplication *)application 
        didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {        
    [self.window addSubview:self.viewController.view];
    [self.window makeKeyAndVisible];
    //START_HIGHLIGHT
    [self.myFM applicationDidFinishLaunchingWithFileURL:
            [launchOptions valueForKey:UIApplicationLaunchOptionsURLKey] 
          inTextView:self.viewController.textView];
    //END_HIGHLIGHT
	return YES;
}
//END:code.documents.app
- (void)dealloc {
    [viewController release],  viewController = nil;
    [myFM release], myFM = nil;
    [window release], window = nil;
    [super dealloc];
}


@end
