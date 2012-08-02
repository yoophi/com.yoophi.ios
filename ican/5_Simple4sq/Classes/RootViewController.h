//
//  iCan iPhone4 Programming : Project 5 Simple 4sq
//
//  RootViewController.h
//  Simple 4sq
//
//  Created by DeArto20 on 1/25/11.
//  Copyright DeArto20 All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface RootViewController : UITableViewController <CLLocationManagerDelegate> {
    NSMutableArray    *venueList;
    
    // Location manager
    CLLocationManager *locationManager;
    // Current location
    double             locationLat;
    double             locationLong;
}

@property (nonatomic, retain) NSMutableArray    *venueList;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, assign) double             locationLat;
@property (nonatomic, assign) double             locationLong;

// Fetch venues from Foursquare server and refresh table view.
- (void)updateVenues;

// Fetch nearby venues.
- (void)fetchNearbyVenues;

// Called when fetching venues has been finished.
- (void)didFinishFetchingVenues:(NSDictionary *)result;

// Refresh table view.
- (void)refreshTableView;

@end
