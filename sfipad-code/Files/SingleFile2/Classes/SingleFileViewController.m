#import "SingleFileViewController.h"

@implementation SingleFileViewController
@synthesize controller;

-(UIDocumentInteractionController *) controller {
    if (controller == nil) {
        NSString *applicationDocumentsDirectory = 
                 [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                      NSUserDomainMask, 
                                                      YES)     lastObject];
        NSString *fileLocation = 
        [applicationDocumentsDirectory stringByAppendingPathComponent:@"ipadBook.pdf"];
        NSURL *fileURL = [NSURL fileURLWithPath:fileLocation];
        self.controller = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    }
    return controller;
}

//START:code.documents.launch
-(void)applicationDidFinishLaunching {
    self.controller.delegate = self;
    [self.controller presentPreviewAnimated:YES];
}
//END:code.documents.launch
//START:code.documents.preview
- (UIViewController *)documentInteractionControllerViewControllerForPreview:
                                (UIDocumentInteractionController *)controller
{    
    return self;
}
//END:code.documents.preview

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [controller release], controller = nil;
    [super dealloc];
}

@end
