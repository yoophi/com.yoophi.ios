#import "CargoViewController.h"

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
    cargoView.backgroundColor = [UIColor colorWithRed:(random()%3)/3.0 
                                                green:(random()%3)/3.0 
                                                 blue:(random()%3)/3.0 
                                                alpha:1]; 
}
//END:code.gestures.color
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end