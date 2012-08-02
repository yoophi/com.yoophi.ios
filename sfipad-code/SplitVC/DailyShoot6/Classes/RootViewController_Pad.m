#import "RootViewController_Pad.h"
#import "Assignments.h"
#import "AssignmentViewController.h"

@implementation RootViewController_Pad

- (void)tableView:(UITableView *)tableView 
         didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.assignmentVC.assignmentNumber = 
    [self.assignments assignmentAtIndex:indexPath.row];
    [self.assignmentVC loadSelectedPage];
}
@end