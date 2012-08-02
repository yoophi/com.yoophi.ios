//
//  PlaylistController.m
//  MoviePlayer
//
//  Created by Eric Freeman on 4/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlaylistController.h"


@implementation PlaylistController


#pragma mark -
#pragma mark View lifecycle

-(id)initWithPlayer:(MPMoviePlayerController *)thePlayer {
	self = [super init];
	if (self) {
		player = thePlayer;
		
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

	items = [[NSArray arrayWithObjects:
			  [NSDictionary dictionaryWithObjectsAndKeys:
			   @"Introduction", @"title",
			   [self movieURL:@"elephantsdream-720-h264-st-aac-1" withFiletype:@"mov"], @"URL",
			   nil],
			   [NSDictionary dictionaryWithObjectsAndKeys:
				@"Room of wires", @"title",
				[self movieURL:@"elephantsdream-720-h264-st-aac-2" withFiletype:@"mov"], @"URL",
				nil],

			  [NSDictionary dictionaryWithObjectsAndKeys:
			   @"Introduction", @"title",
			   [self movieURL:@"elephantsdream-720-h264-st-aac-1" withFiletype:@"mov"], @"URL",
			   nil],
			  [NSDictionary dictionaryWithObjectsAndKeys:
			   @"Room of wires", @"title",
			   [self movieURL:@"elephantsdream-720-h264-st-aac-2" withFiletype:@"mov"], @"URL",
			   nil],

			  [NSDictionary dictionaryWithObjectsAndKeys:
			   @"Introduction", @"title",
			   [self movieURL:@"elephantsdream-720-h264-st-aac-1" withFiletype:@"mov"], @"URL",
			   nil],
			  [NSDictionary dictionaryWithObjectsAndKeys:
			   @"Room of wires", @"title",
			   [self movieURL:@"elephantsdream-720-h264-st-aac-2" withFiletype:@"mov"], @"URL",
			   nil],

			  [NSDictionary dictionaryWithObjectsAndKeys:
			   @"Introduction", @"title",
			   [self movieURL:@"elephantsdream-720-h264-st-aac-1" withFiletype:@"mov"], @"URL",
			   nil],
			  [NSDictionary dictionaryWithObjectsAndKeys:
			   @"Room of wires", @"title",
			   [self movieURL:@"elephantsdream-720-h264-st-aac-2" withFiletype:@"mov"], @"URL",
			   nil],

			  [NSDictionary dictionaryWithObjectsAndKeys:
			   @"Introduction", @"title",
			   [self movieURL:@"elephantsdream-720-h264-st-aac-1" withFiletype:@"mov"], @"URL",
			   nil],
			  [NSDictionary dictionaryWithObjectsAndKeys:
			   @"Room of wires", @"title",
			   [self movieURL:@"elephantsdream-720-h264-st-aac-2" withFiletype:@"mov"], @"URL",
			   nil],

			  [NSDictionary dictionaryWithObjectsAndKeys:
			   @"Introduction", @"title",
			   [self movieURL:@"elephantsdream-720-h264-st-aac-1" withFiletype:@"mov"], @"URL",
			   nil],
			  [NSDictionary dictionaryWithObjectsAndKeys:
			   @"Room of wires", @"title",
			   [self movieURL:@"elephantsdream-720-h264-st-aac-2" withFiletype:@"mov"], @"URL",
			   nil],

			  [NSDictionary dictionaryWithObjectsAndKeys:
			   @"Introduction", @"title",
			   [self movieURL:@"elephantsdream-720-h264-st-aac-1" withFiletype:@"mov"], @"URL",
			   nil],
			  [NSDictionary dictionaryWithObjectsAndKeys:
			   @"Room of wires", @"title",
			   [self movieURL:@"elephantsdream-720-h264-st-aac-2" withFiletype:@"mov"], @"URL",
			   nil],
			  

	
			  nil] retain];

	UITableView *table = self.tableView;
	
	[table setOpaque:NO];
	[table setRowHeight:30];
	[table setBackgroundColor:[UIColor clearColor]];
    [table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [table setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
	
	
		
	[[NSNotificationCenter defaultCenter] 
	 addObserver:self 
	 selector:@selector(playerPlaybackDidFinish:)
	 name:MPMoviePlayerPlaybackDidFinishNotification
	 object:nil];



}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
	[self.tableView selectRowAtIndexPath:path animated:YES scrollPosition:YES];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [items count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	[[cell textLabel] setTextColor:[UIColor whiteColor]];
    [cell textLabel].text = [[items objectAtIndex:indexPath.row] objectForKey:@"title"];
	[[cell textLabel] setFont:[UIFont systemFontOfSize:14.0]];  
	cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    
    return cell;
}





#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSLog(@"did select");
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
	player.contentURL = [[items objectAtIndex:indexPath.row] objectForKey:@"URL"];
	[player play];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (void) playerPlaybackDidFinish:(NSNotification*)notification
{
	NSLog(@"DID FINISH");
	UITableViewController *tv = self;
	int rows = [tv.tableView numberOfRowsInSection:0];
	int selectedRow = [self.tableView indexPathForSelectedRow].row;
	
	if ((selectedRow + 1) < rows) {
		NSIndexPath *path = [NSIndexPath indexPathForRow:selectedRow+1 inSection:0];
		[self.tableView selectRowAtIndexPath:path animated: YES scrollPosition:YES];
		player.contentURL = [[items objectAtIndex:selectedRow+1] objectForKey:@"URL"];

		[player play];
	}
	//player.contentURL = [ movieURL];	

	//[player play];
	//NSLog(@"playing");
}
			 
			 
-(NSURL *)movieURL:(NSString *)filename withFiletype:(NSString *)type
{
	NSBundle *bundle = [NSBundle mainBundle];

	NSString *moviePath = 
	[bundle 
	 pathForResource:filename
	 ofType:type];
	
	
	
	if (moviePath) {
		return [NSURL fileURLWithPath:moviePath];
	} else {
		return nil;
	}
}

@end

