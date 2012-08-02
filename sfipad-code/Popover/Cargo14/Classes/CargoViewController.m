#import "CargoViewController.h"
#import "CargoColorChooser.h"
#import "CarDriver.h"

@implementation CargoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [cargoView addGestureRecognizer:
               [[[UITapGestureRecognizer alloc] 
                    initWithTarget:self 
                            action:@selector(cargoContainerDidGetTapped)]
                                                            autorelease]];
    //START:code.gestures.load
    [self.view bringSubviewToFront:cargoView];
    //END:code.gestures.load
}

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
-(IBAction)showOrHideDriveControls:(id)sender {
    if (driveControls) {
        [driveControls dismissPopoverAnimated:YES];
        driveControls = nil;
    } else {
        driveControls = [[UIPopoverController alloc] 
                         initWithContentViewController:carDriver];
        driveControls.popoverContentSize = carDriver.view.frame.size;
        [driveControls presentPopoverFromBarButtonItem:sender 
                              permittedArrowDirections:UIPopoverArrowDirectionAny 
                                              animated:YES];
        driveControls.delegate = self;
    }
}
- (void)popoverControllerDidDismissPopover:
(UIPopoverController *)popoverController {
    driveControls = nil;
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}
//START:code.popover.rotate
- (void)willAnimateRotationToInterfaceOrientation:
                              (UIInterfaceOrientation)interfaceOrientation 
                                         duration:(NSTimeInterval)duration {
    if (interfaceOrientation == UIInterfaceOrientationPortrait || 
        interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        corner1.frame = CGRectMake(0, 44, 100, 100);
        corner2.frame = CGRectMake(668, 44, 100, 100);
        corner3.frame = CGRectMake(0, 904, 100, 100);
        corner4.frame = CGRectMake(668, 904, 100, 100);
    } else {
        corner4.frame = CGRectMake(0, 44, 100, 100);
        corner3.frame = CGRectMake(924, 44, 100, 100);
        corner2.frame = CGRectMake(0, 648, 100, 100);
        corner1.frame = CGRectMake(924, 648, 100, 100);
    }
}
//END:code.popover.rotate
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
    [driveControls release];
    [super dealloc];
}

@end
