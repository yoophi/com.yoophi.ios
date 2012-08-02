//
//  iCan iPhone4 Programming : Project 5 Simple 4sq
//
//  MapViewController.h
//  Simple 4sq
//
//  Created by DeArto20 on 1/25/11.
//  Copyright DeArto20 All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate,
MKReverseGeocoderDelegate> {
    MKMapView         *mapView;
    MKReverseGeocoder *geoCoder;
    double             locationLat;
    double             locationLong;
}

@property (nonatomic, assign) double locationLat;
@property (nonatomic, assign) double locationLong;

@end
