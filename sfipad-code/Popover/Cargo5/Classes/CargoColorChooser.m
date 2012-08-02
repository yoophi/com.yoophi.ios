#import "CargoColorChooser.h"


@implementation CargoColorChooser
//START:code.popover.dismiss
-(IBAction) dismiss {
    [self dismissModalViewControllerAnimated:YES];
}
//END:code.popover.dismiss
//START:code.popover.setcolor
-(IBAction) setCargoColor:(id)sender{
    cargoView.backgroundColor = ((UIView *) sender).backgroundColor;
}
//END:code.popover.setcolor

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end