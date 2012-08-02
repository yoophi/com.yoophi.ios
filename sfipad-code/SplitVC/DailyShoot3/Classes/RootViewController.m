#import "RootViewController.h"
#import "Assignments.h"
#import "AssignmentViewController.h"

@implementation RootViewController
@synthesize assignments;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Assignments";
}
- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}
//START:code.nav.dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    //START_HIGHLIGHT
    return [self.assignments count];
    //END_HIGHLIGHT
}
- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = 
    [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleDefault 
                 reuseIdentifier:CellIdentifier] autorelease];
        //START_HIGHLIGHT
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //END_HIGHLIGHT
    }
    //START_HIGHLIGHT    
    cell.textLabel.text = 
        [[self.assignments assignmentAtIndex:indexPath.row] stringValue];
    //END_HIGHLIGHT
    
    return cell;
}
//END:code.nav.dataSource
//START:code.nav.delegate
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
//END:code.nav.delegate

- (void)dealloc {
    [assignments release], assignments = nil;
    [super dealloc];
}
@end