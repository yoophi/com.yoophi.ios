//
//  iCan iPhone4 Programming : Project 4 Simple Twit
//
//  RootViewController.m
//  Simple Twit
//
//  Created by DeArto20 on 1/25/11.
//  Copyright DeArto20 All rights reserved.
//

#import "RootViewController.h"
#import "TwitterClientModel.h"
#import "JSON.h"
#import "CustomCell.h"
#import "DetailViewController.h"


@implementation RootViewController

@synthesize tweetList;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tweetList = [NSMutableArray arrayWithCapacity:0];
    
    self.title     = @"Simple Twitt";
	
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0549 
                                                                 green:0.4117
                                                                 blue:0.6039
                                                                 alpha:1];
	
	UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]
								   initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
								   target:self
								   action:@selector(updateTimeLine)];
	self.navigationItem.leftBarButtonItem = leftButton;
	[leftButton release];

    [self updateTimeLine];
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
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tweetList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *tweet      = [self.tweetList objectAtIndex:indexPath.row];
    NSString     *text       = [NSString stringWithString:[tweet objectForKey:@"text"]];
    
    CGSize        withinSize = CGSizeMake(225, CGFLOAT_MAX);
    CGSize        size       = [text sizeWithFont:[UIFont systemFontOfSize:12]
                                constrainedToSize:withinSize
                                    lineBreakMode:UILineBreakModeCharacterWrap];
    
    return size.height + 50.0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    CustomCell *cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:nil options:nil];
        cell           = [array objectAtIndex:0];
    }
    
	// Configure the cell.
    NSDictionary    *tweet = nil,
                    *user  = nil;
    
    tweet = [self.tweetList objectAtIndex:indexPath.row];
    user  = [tweet objectForKey:@"user"];
    
    UIImage         *image = nil;
    
    image = [[TwitterClientModel sharedInstance] cachedImageForURL:[user objectForKey:@"profile_image_url"]
                                                 withTarget:self.tableView
                                                 withAction:@selector(reloadData)];
    
    [[cell userImageView] setImage:image];
    [[cell userNameLabel] setText:[user  objectForKey:@"screen_name"]];
    [[cell userTextLabel] setText:[tweet objectForKey:@"text"]];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];

    [detailViewController setTweet:[self.tweetList objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
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

- (void)updateTimeLine {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self 
                                                                      selector:@selector(fetchPublicTimeLine) 
                                                                      object:nil];
    
    [[[TwitterClientModel sharedInstance] operationQueue] addOperation:operation];
    [operation release];
}

- (void)fetchPublicTimeLine {
    NSMutableArray  *result     = nil;
    NSString        *urlString  = [NSString stringWithFormat:@"http://api.twitter.com/1/statuses/public_timeline.json"];
    NSURL           *url        = [NSURL    URLWithString:urlString];
    NSString        *jsonString = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    result = [jsonString JSONValue];

    [jsonString release];
    
    [self performSelectorOnMainThread:@selector(didFinishFetchingPublicTimeLine:)
          withObject:result
          waitUntilDone:NO];
}

- (void)didFinishFetchingPublicTimeLine:(NSArray *)result {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (result == nil) {
        return;
    }
    
    NSMutableArray *newList = [NSMutableArray arrayWithCapacity:0];
    
    [newList addObjectsFromArray:result];
    [newList addObjectsFromArray:self.tweetList];
    
    [self.tweetList removeAllObjects];
    [self.tweetList addObjectsFromArray:newList];
    
    [self.tableView reloadData];
}

- (void)dealloc {
    if (tweetList) {
        [tweetList release];
    }
    
    [super dealloc];
}


@end

