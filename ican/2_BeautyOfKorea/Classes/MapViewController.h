//
//  iCan iPhone4 Programming : Project 2 Beauty of Korea
//
//  MapViewController.h
//  BeautyOfKorea
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import "LocationAnnotation.h"

@interface MapViewController : UIViewController <MKMapViewDelegate> {
	IBOutlet UIButton *btnBack;
    IBOutlet MKMapView *mapView;
    IBOutlet UISegmentedControl *mapType;
	
	LocationAnnotation *locationAnnotation;
	
}
@property(nonatomic,retain) IBOutlet UIButton *btnBack;	
@property(nonatomic,retain) IBOutlet MKMapView *mapView;
@property(nonatomic,retain) IBOutlet UISegmentedControl *mapType;	
@property(nonatomic,retain) LocationAnnotation *locationAnnotation;

-(IBAction)btnBackTouched;
-(IBAction)mapTypeChanged;

@end
