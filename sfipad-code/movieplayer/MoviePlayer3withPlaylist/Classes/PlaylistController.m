//
//  PlaylistController.m
//  MoviePlayer
//
//  Created by Eric Freeman on 4/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlaylistController.h"
#import "MoviePlayerViewController.h"

@implementation PlaylistController

// START:init
-(id)initWithPlayer:(MoviePlayerViewController *)thePlayer {
	self = [super init];
	if (self) {
		playerController = thePlayer;
	}
	return self;
}
// END:init

// START:viewdidload
- (void)viewDidLoad {
	[super viewDidLoad];

	items = [[NSArray arrayWithObjects:
		[NSDictionary dictionaryWithObjectsAndKeys:
		 @"Introduction", @"title",
		 [playerController 
		  movieURL:@"elephantsdream-720-h264-st-aac-1" 
		  withFiletype:@"mov"], @"URL",
		 nil],
		[NSDictionary dictionaryWithObjectsAndKeys:
		 @"Watch out!", @"title",
		 [playerController 
		  movieURL:@"elephantsdream-720-h264-st-aac-2" 
		  withFiletype:@"mov"], @"URL",
		 nil],
		[NSDictionary dictionaryWithObjectsAndKeys:
		 @"Follow me!", @"title",
		 [playerController 
		  movieURL:@"elephantsdream-720-h264-st-aac-3" 
		  withFiletype:@"mov"], @"URL",
		 nil],
		nil] retain];
// END:viewdidload
	// START:viewdidload2
	UITableView *table = self.tableView;
	[table setOpaque:NO];
	[table setRowHeight:30];
	[table setBackgroundColor:[UIColor clearColor]];
	[table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[table setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
	// END:viewdidload2
	// START:viewdidload3
	[[NSNotificationCenter defaultCenter] 
	 addObserver:self 
	 selector:@selector(playerPlaybackDidFinish:)
	 name:MPMoviePlayerPlaybackDidFinishNotification
	 object:nil];
		// END:viewdidload3
// START:viewdidload
}
// END:viewdidload


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
//	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
//	[self.tableView selectRowAtIndexPath:path animated:YES scrollPosition:YES];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}


#pragma mark -
#pragma mark Table view data source
// START:datasource1

- (NSInteger)numberOfSectionsInTableView:
	(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView 
	numberOfRowsInSection:(NSInteger)section {
    return [items count];
}
// END:datasource1


// Customize the appearance of table view cells.
// START:datasource2
- (UITableViewCell *)tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = 
		[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] 
				 initWithStyle:UITableViewCellStyleDefault 
				 reuseIdentifier:CellIdentifier] autorelease];
    }
	[[cell textLabel] setTextColor:[UIColor whiteColor]];
    [cell textLabel].text = [[items objectAtIndex:indexPath.row] 
							 objectForKey:@"title"];
	[[cell textLabel] setFont:[UIFont systemFontOfSize:14.0]];  
	cell.selectedBackgroundView = [[UIImageView alloc] 
								   initWithImage:[UIImage imageNamed:@"background.png"]];
    
    return cell;
}
// END:datasource2





#pragma mark -
#pragma mark Table view delegate
// START:datasource3
- (void)tableView:(UITableView *)tableView 
	didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSURL *url = [[items objectAtIndex:indexPath.row] 
				  objectForKey:@"URL"];
	playerController.player.contentURL = url;
		
	[playerController.player play];
}
// END:datasource3

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

// START:notify
- (void) playerPlaybackDidFinish:(NSNotification*)notification {
	UITableViewController *tv = self;
	int rows = [tv.tableView numberOfRowsInSection:0];
	int selectedRow = [self.tableView indexPathForSelectedRow].row;
	
	if ((selectedRow + 1) < rows) {
		NSIndexPath *path = 
		[NSIndexPath indexPathForRow:selectedRow+1 
						   inSection:0];
		[self.tableView selectRowAtIndexPath:path 
			animated:YES 
			scrollPosition:YES];
		
		playerController.player.contentURL = 
			[[items objectAtIndex:selectedRow+1] 
			 objectForKey:@"URL"];
		[playerController.player play];
	}
}
// END:notify
			 
			 


@end

