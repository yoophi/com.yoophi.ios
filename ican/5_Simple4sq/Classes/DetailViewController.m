//
//  iCan iPhone4 Programming : Project 5 Simple 4sq
//
//  DetailViewController.m
//  Simple 4sq
//
//  Created by DeArto20 on 1/25/11.
//  Copyright DeArto20 All rights reserved.
//

#import "DetailViewController.h"
#import "FoursquareClientModel.h"
#import "MapViewController.h"
#import "JSON.h"


@implementation DetailViewController

@synthesize venue;
@synthesize user;
@synthesize venueImageView;
@synthesize venueNameLabel;
@synthesize venueTypeLabel;
@synthesize mayorImageView;
@synthesize mayorFirstNameLabel;
@synthesize mayorLastNameLabel;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *category   = nil;
    NSMutableArray      *categories = nil;
    UIImage             *image      = nil;
    
    categories  = [self.venue objectForKey:@"categories"];
    
    if ([categories count] > 0) {
        category   = [categories objectAtIndex:0];
    } else {
        return;
    }
    
    image = [[FoursquareClientModel sharedInstance] cachedImageForURL:[category objectForKey:@"icon"]
                                                    withTarget:self
                                                    withAction:@selector(didFinishLoadingVenueImage)];
    
    [self.venueImageView setImage:image];
    [self.venueNameLabel setText:[self.venue objectForKey:@"name"]];
    [self.venueTypeLabel setText:[category   objectForKey:@"name"]];
    
    // Get user info.
    [self getUserInfo];
}

- (void)didFinishLoadingVenueImage {
    NSMutableDictionary *category   = nil;
    NSMutableArray      *categories = nil;
    UIImage             *image      = nil;
    
    
    categories  = [self.venue objectForKey:@"categories"];
    
    if ([categories count] > 0) {
        category   = [categories objectAtIndex:0];
    } else {
        return;
    }
    
    image = [[FoursquareClientModel sharedInstance] cachedImageForURL:[category objectForKey:@"icon"]
                                                    withTarget:self
                                                    withAction:@selector(didFinishLoadingVenueImage)];
    
    [self.venueImageView setImage:image];
}

- (void)getUserInfo {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSInvocationOperation *operation  = [[NSInvocationOperation alloc] initWithTarget:self
                                                                       selector:@selector(fetchVenue)
                                                                       object:nil];
    [[[FoursquareClientModel sharedInstance] operationQueue] addOperation:operation];
    [operation release];
}

- (void)fetchVenue {
    NSMutableDictionary *result     = nil;
    NSString            *urlString  = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@.json?client_id=MOJPIRICOT0FAI0T2MTCPVN5KNIJZG0F4VPLVZHNOP5QXHER&client_secret=LUTJSKG1X2YB24JDE05RAF03PRXAD5OMUUVHESR021FYBN34", [self.venue objectForKey:@"id"]];
	NSURL               *url        = [NSURL URLWithString:urlString];
    NSString            *jsonString = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    result = [jsonString JSONValue];
    
	[jsonString release];
    
    [self performSelectorOnMainThread:@selector(didFinishFetchingVenue:) withObject:result waitUntilDone:NO];
}

- (void)didFinishFetchingVenue:(NSMutableDictionary *)result {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (result == nil) {
        return;
    }
    
    NSMutableDictionary *response = [result   objectForKey:@"response"],
                        *info     = [response objectForKey:@"venue"],
                        *stats    = nil,
                        *mayor    = nil;
    UIImage             *image    = nil;

    
    stats     = [info  objectForKey:@"stats"];
    mayor     = [info  objectForKey:@"mayor"];
    self.user = [mayor objectForKey:@"user"];
    image     = [[FoursquareClientModel sharedInstance] cachedImageForURL:[self.user objectForKey:@"photo"]
                                                        withTarget:self
                                                        withAction:@selector(didFinishLoadingMayorImage)];
    
    [self.mayorImageView      setImage:image];
    [self.mayorFirstNameLabel setText:[self.user objectForKey:@"firstName"]];
    [self.mayorLastNameLabel  setText:[self.user objectForKey:@"lastName"]];
}

- (void)didFinishLoadingMayorImage {
    NSString *url   = [self.user objectForKey:@"photo"];
    UIImage  *image = [[FoursquareClientModel sharedInstance] cachedImageForURL:url
                                                              withTarget:self
                                                              withAction:@selector(didFinishLoadingMayorImage)];
    
    [self.mayorImageView setImage:image];
}

- (IBAction)showMap {
    NSMutableDictionary *location = [self.venue objectForKey:@"location"];
    
    
    MapViewController *viewController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    [viewController setLocationLat: [[location objectForKey:@"lat"] doubleValue]];
    [viewController setLocationLong:[[location objectForKey:@"lng"] doubleValue]];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    if (mayorLastNameLabel) {
        [mayorLastNameLabel release];
    }
    
    if (mayorFirstNameLabel) {
        [mayorFirstNameLabel release];
    }
    
    if (mayorImageView) {
        [mayorImageView release];
    }
    
    if (venueNameLabel) {
        [venueNameLabel release];
    }
    
    if (venueImageView) {
        [venueImageView release];
    }
    
    if (user) {
        [user release];
    }
    
    if (venue) {
        [venue release];
    }
    
    [super dealloc];
}


@end
