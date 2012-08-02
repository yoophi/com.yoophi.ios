#import "RootViewController.h"
#import "DetailViewController.h"
#import "Assignments.h"


@implementation RootViewController

@synthesize detailViewController, assignments;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Assignments";
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.assignments count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    // Dequeue or create a cell of the appropriate type.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell.
    cell.textLabel.text = 
        [[self.assignments assignmentAtIndex:indexPath.row] stringValue];
    return cell;
}

#pragma mark -
#pragma mark Table view delegate
//START:code.split.delegate
- (void)tableView:(UITableView *)aTableView 
        didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.detailViewController.detailItem = 
                        [self.assignments assignmentAtIndex:indexPath.row];
}
//END:code.split.delegate


- (void)dealloc {
    [detailViewController release];
    [super dealloc];
}


@end

