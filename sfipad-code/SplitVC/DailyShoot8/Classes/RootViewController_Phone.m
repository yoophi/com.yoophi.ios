#import "RootViewController_Phone.h"
#import "Assignments.h"
#import "AssignmentViewController.h"

@implementation RootViewController_Phone

- (void)tableView:(UITableView *)tableView 
             didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AssignmentViewController *detailViewController = 
    [[AssignmentViewController alloc] 
     initWithNibName:@"AssignmentViewController" bundle:nil];
    detailViewController.assignmentNumber = 
    [self.assignments assignmentAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailViewController 
                                         animated:YES];
    [detailViewController release];
}
@end