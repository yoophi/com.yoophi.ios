//
//  iCan iPhone4 Programming : Project 2 Beauty of Korea
//
//  RootViewController.m
//  BeautyOfKorea
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import "RootViewController.h"
#import "ContentViewController.h"
#import "MapViewController.h"

@implementation RootViewController
@synthesize btnMenu1;
@synthesize btnMenu2;
@synthesize btnMenu3;
@synthesize btnMenu4;
@synthesize btnMenu5;
@synthesize btnMenu6;
@synthesize ivBackground;
@synthesize ivTitle;


-(IBAction)btnMenu1Touched
{
 	ContentViewController *contentViewController = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
	contentViewController.currentMenu = 1;
	[self.navigationController pushViewController:contentViewController animated:YES];
	[contentViewController release];
}

-(IBAction)btnMenu2Touched
{
 	ContentViewController *contentViewController = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
	contentViewController.currentMenu = 2;
	[self.navigationController pushViewController:contentViewController animated:YES];
	[contentViewController release];
}

-(IBAction)btnMenu3Touched
{
 	ContentViewController *contentViewController = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
	contentViewController.currentMenu = 3;
	[self.navigationController pushViewController:contentViewController animated:YES];
	[contentViewController release];
}

-(IBAction)btnMenu4Touched
{
 	ContentViewController *contentViewController = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
	contentViewController.currentMenu = 4;
	[self.navigationController pushViewController:contentViewController animated:YES];
	[contentViewController release];
}

-(IBAction)btnMenu5Touched
{
 	ContentViewController *contentViewController = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
	contentViewController.currentMenu = 5;
	[self.navigationController pushViewController:contentViewController animated:YES];
	[contentViewController release];
}

-(IBAction)btnMenu6Touched
{
	MapViewController *mapViewController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
	[self.navigationController pushViewController:mapViewController animated:YES];
	[mapViewController release];
	
}

#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

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


@end

