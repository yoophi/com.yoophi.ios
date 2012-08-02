#import "AssignmentViewController_Pad.h"

@implementation AssignmentViewController_Pad
@synthesize toolbar;

- (BOOL)shouldAutorotateToInterfaceOrientation:
             (UIInterfaceOrientation)interfaceOrientation {
    return YES;
}
- (void)dealloc {
    [toolbar release], toolbar = nil;
    [super dealloc];
}
@end
