//
//  iCan iPhone4 Programming : Project 5 Simple 4sq
//
//  MapViewController.m
//  Simple 4sq
//
//  Created by DeArto20 on 1/25/11.
//  Copyright DeArto20 All rights reserved.
//

#import "MapViewController.h"


@implementation MapViewController

@synthesize locationLat;
@synthesize locationLong;

// The designated initializer.  Override if you create the controller programmatically and 
// want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    MKCoordinateSpan       span;
    MKCoordinateRegion     region;
    CLLocationCoordinate2D location;
    
    mapView             = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.mapType     = MKMapTypeStandard;
    mapView.delegate    = self;
    
    location            = mapView.userLocation.coordinate;
    location.latitude   = self.locationLat;
    location.longitude  = self.locationLong;
    
    span.latitudeDelta  = 0.01;
    span.longitudeDelta = 0.01;
    region.span         = span;
    region.center       = location;
    
    geoCoder            = [[MKReverseGeocoder alloc] initWithCoordinate:location];
    geoCoder.delegate   = self;
    
    [mapView setRegion:region animated:TRUE];
    [mapView regionThatFits:region];
    
    [self.view insertSubview:mapView atIndex:0];
    
    [geoCoder start];
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

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
    
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark{
	[mapView addAnnotation:placemark];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
	MKPinAnnotationView *annotationView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation 
                                                                           reuseIdentifier:@"current"] autorelease];
	annotationView.animatesDrop = YES;
    
	return annotationView;
}


- (void)dealloc {
    if (geoCoder) {
        [geoCoder release];
    }
    
    if (mapView) {
        [mapView release];
    }
    
    [super dealloc];
}


@end
