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
    [self presentModalViewController:cargoColorChooser animated:YES];
}
//END:code.gestures.color

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
