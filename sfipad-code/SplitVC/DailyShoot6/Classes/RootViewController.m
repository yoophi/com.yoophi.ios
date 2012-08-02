#import "RootViewController.h"
#import "Assignments.h"
#import "AssignmentViewController.h"

@implementation RootViewController
@synthesize assignments, assignmentVC;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Assignments";
}
- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    return [self.assignments count];
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = 
         [[self.assignments assignmentAtIndex:indexPath.row] stringValue];    
    return cell;
}

- (void)dealloc {
    [assignments release], assignments = nil;
    [assignmentVC release], assignmentVC = nil;
    [super dealloc];
}
@end