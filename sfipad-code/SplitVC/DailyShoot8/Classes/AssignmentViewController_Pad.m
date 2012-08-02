#import "AssignmentViewController_Pad.h"

@implementation AssignmentViewController_Pad
@synthesize toolbar, popoverController;

- (BOOL)shouldAutorotateToInterfaceOrientation:
             (UIInterfaceOrientation)interfaceOrientation {
    return YES;
}
//START:code.split.portrait
- (void)splitViewController:(UISplitViewController*)svc 
     willHideViewController:(UIViewController *)aViewController 
          withBarButtonItem:(UIBarButtonItem*)barButtonItem 
       forPopoverController:(UIPopoverController*)pc {
    barButtonItem.title = aViewController.title;
    [self.toolbar setItems:[NSArray arrayWithObject:barButtonItem] 
                  animated:YES]; 
    self.popoverController = pc;
}
//END:code.split.portrait
//START:code.split.landscape
- (void)splitViewController: (UISplitViewController*)svc 
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem { 
    [self.toolbar setItems:[NSArray array] animated:YES]; 
    self.popoverController = nil;
}
//END:code.split.landscape
//START:code.fromto.load
- (void) loadSelectedPage {
    [super loadSelectedPage];
    if (self.popoverController) {
        [self.popoverController dismissPopoverAnimated:YES];
    }
}
//END:code.fromto.load
- (void)dealloc {
    [popoverController release], popoverController = nil;
    [toolbar release], toolbar = nil;
    [super dealloc];
}
@end
