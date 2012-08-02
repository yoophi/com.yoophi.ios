    //
//  CargoColorChooser.m
//  Cargo
//
//  Created by Daniel Steinberg on 4/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CargoColorChooser.h"


@implementation CargoColorChooser
@synthesize popoverController;
//START:code.popover.setcolor
-(IBAction) setCargoColor:(id)sender{
    cargoView.backgroundColor = ((UIView *) sender).backgroundColor;
    [popoverController dismissPopoverAnimated:YES];
}
//END:code.popover.setcolor

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end