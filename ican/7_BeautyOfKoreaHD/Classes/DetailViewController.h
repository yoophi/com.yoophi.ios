//
//  iCan iPhone4 Programming : Project 7 Beauty of Korea HD
//
//  DetailViewController.h
//  BeautyOfKoreaHD
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import "LocationAnnotation.h"

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, MKMapViewDelegate> {
    
    UIPopoverController *popoverController;
    UIToolbar *toolbar;
	UIScrollView *svContent;
	UIScrollView *svGallery;
	int currentMenu;
	
	MKMapView *mapView;
	LocationAnnotation *locationAnnotation;
	
}
@property(nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property(nonatomic, retain) UIScrollView *svContent;
@property(nonatomic, retain) UIScrollView *svGallery;
@property(nonatomic, assign) int currentMenu;
@property (nonatomic, retain) UIPopoverController *popoverController;

@property(nonatomic,retain) MKMapView *mapView;
@property(nonatomic,retain) LocationAnnotation *locationAnnotation;

- (void)initPhotoGallery;
- (void)initMapView;
- (void)adjustInterfaceWithOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end
