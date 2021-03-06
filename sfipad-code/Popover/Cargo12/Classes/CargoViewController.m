#import "CargoViewController.h"
#import "CargoColorChooser.h"
#import "CarDriver.h"

@implementation CargoViewController


//START:code.gestures.load
- (void)viewDidLoad {
    [super viewDidLoad];
    //START_HIGHLIGHT
    [cargoView addGestureRecognizer:
               [[[UITapGestureRecognizer alloc] 
                    initWithTarget:self 
                            action:@selector(cargoContainerDidGetTapped)]
                                                            autorelease]];
    //END_HIGHLIGHT
}
//END:code.gestures.load

//START:code.gestures.color
-(void) cargoContainerDidGetTapped {
    UIPopoverController *popover = [[UIPopoverController alloc] 
                        initWithContentViewController:cargoColorChooser];
    popover.popoverContentSize = cargoColorChooser.view.frame.size;
    cargoColorChooser.popoverController = popover;
    [popover presentPopoverFromRect:cargoView.bounds 
                             inView:cargoView 
           permittedArrowDirections:UIPopoverArrowDirectionLeft + 
     UIPopoverArrowDirectionRight 
                           animated:YES];   
}
//END:code.gestures.color
//START:code.popover.drive
-(IBAction)showDriveControls:(id)sender {
    UIPopoverController *controls = [[UIPopoverController alloc] 
                                initWithContentViewController:carDriver];
    controls.popoverContentSize = carDriver.view.frame.size;
    [controls presentPopoverFromBarButtonItem:sender 
                     permittedArrowDirections:UIPopoverArrowDirectionAny 
                                     animated:YES];
}
//END:code.popover.drive

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
    [super dealloc];
}

@end
