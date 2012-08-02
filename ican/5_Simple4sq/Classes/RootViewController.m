//
//  iCan iPhone4 Programming : Project 5 Simple 4sq
//
//  RootViewController.m
//  Simple 4sq
//
//  Created by DeArto20 on 1/25/11.
//  Copyright DeArto20 All rights reserved.
//

#import "RootViewController.h"
#import "FoursquareClientModel.h"
#import "JSON.h"
#import "DetailViewController.h"

@implementation RootViewController

@synthesize venueList;
@synthesize locationManager;
@synthesize locationLat;
@synthesize locationLong;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.venueList = [NSMutableArray arrayWithCapacity:0];
    
    self.title     = @"Simple 4sq";
	
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.90
                                                                 green:0.59
                                                                 blue:0.12
                                                                 alpha:1];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Start location update service.
    [self.locationManager startUpdatingLocation];
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

- (void)locationManager:(CLLocationManager*)manager didUpdateToLocation:(CLLocation*)newLocation fromLocation:(CLLocation*)oldLocation {
    if ((self.locationLat  == newLocation.coordinate.latitude) &&
        (self.locationLong == newLocation.coordinate.longitude)) {
        return;
    }
    
    // Use the coordinate data.
    self.locationLat  = newLocation.coordinate.latitude;
    self.locationLong = newLocation.coordinate.longitude;
    
    [self updateVenues];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
}

- (void)updateVenues {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSInvocationOperation *operation  = [[NSInvocationOperation alloc] initWithTarget:self
                                                                       selector:@selector(fetchNearbyVenues)
                                                                       object:nil];
    [[[FoursquareClientModel sharedInstance] operationQueue] addOperation:operation];
    [operation release];
}

- (void)fetchNearbyVenues {
    NSMutableArray *result     = nil;
    NSString       *urlString  = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search.json?ll=%f,%f&client_id=MOJPIRICOT0FAI0T2MTCPVN5KNIJZG0F4VPLVZHNOP5QXHER&client_secret=LUTJSKG1X2YB24JDE05RAF03PRXAD5OMUUVHESR021FYBN34", 
                                           self.locationLat, 
                                           self.locationLong];
	NSURL          *url        = [NSURL URLWithString:urlString];
    NSString       *jsonString = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    result = [jsonString JSONValue];
    
	[jsonString release];
    
    [self performSelectorOnMainThread:@selector(didFinishFetchingVenues:) withObject:result waitUntilDone:NO];
}

- (void)didFinishFetchingVenues:(NSDictionary *)result {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (result == nil) {
        return;
    }
    
    NSMutableDictionary *response = [result   objectForKey:@"response"];
    NSMutableArray      *groups   = [response objectForKey:@"groups"];
    NSMutableDictionary *contents = [groups objectAtIndex:0];
    NSMutableArray      *items    = [contents objectForKey:@"items"];
    
    
    [self.venueList removeAllObjects];
    [self.venueList addObjectsFromArray:items];
    
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) {
        [self.tableView reloadData];
    }
}

- (void)refreshTableView {
    if (self.venueList && ([self.venueList count] > 0)) {
        [self.tableView reloadData];
    }
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.venueList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
    NSMutableDictionary *venue      = nil,
                        *category   = nil;
    NSMutableArray      *categories = nil;
    UIImage             *image      = nil;
    
    venue = [self.venueList objectAtIndex:indexPath.row];
    
    categories = [venue objectForKey:@"categories"];
    
    if ([categories count] > 0) {
        category   = [categories objectAtIndex:0];
    }
    
    image = [[FoursquareClientModel sharedInstance] cachedImageForURL:[category objectForKey:@"icon"]
                                                    withTarget:self.tableView
                                                    withAction:@selector(reloadData)];
    
    [[cell textLabel] setText:[venue objectForKey:@"name"]];
    [[cell imageView] setImage:image];
    
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

    [detailViewController setVenue:[self.venueList objectAtIndex:indexPath.row]];
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
    // Stop location update service.
    [self.locationManager stopUpdatingLocation];
}


- (void)dealloc {
    if (locationManager) {
        [locationManager release];
    }
    
    if (venueList) {
        [venueList release];
    }
    
    [super dealloc];
}


@end

