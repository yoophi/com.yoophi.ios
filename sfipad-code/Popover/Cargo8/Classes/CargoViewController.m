#import "CargoViewController.h"
#import "CargoColorChooser.h"

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
    [popover presentPopoverFromRect:cargoView.bounds 
                             inView:cargoView 
           permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];    
}
//END:code.gestures.color

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
