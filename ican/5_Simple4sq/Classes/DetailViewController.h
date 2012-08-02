//
//  iCan iPhone4 Programming : Project 5 Simple 4sq
//
//  DetailViewController.h
//  Simple 4sq
//
//  Created by DeArto20 on 1/25/11.
//  Copyright DeArto20 All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailViewController : UIViewController {
    NSDictionary         *venue;
    NSDictionary         *user;
    
    IBOutlet UIImageView *venueImageView;
    IBOutlet UILabel     *venueNameLabel;
    IBOutlet UILabel     *venueTypeLabel;
    IBOutlet UIImageView *mayorImageView;
    IBOutlet UILabel     *mayorFirstNameLabel;
    IBOutlet UILabel     *mayorLastNameLabel;
}

@property (nonatomic, retain) NSDictionary         *venue;
@property (nonatomic, retain) NSDictionary         *user;
@property (nonatomic, retain) IBOutlet UIImageView *venueImageView;
@property (nonatomic, retain) IBOutlet UILabel     *venueNameLabel;
@property (nonatomic, retain) IBOutlet UILabel     *venueTypeLabel;
@property (nonatomic, retain) IBOutlet UIImageView *mayorImageView;
@property (nonatomic, retain) IBOutlet UILabel     *mayorFirstNameLabel;
@property (nonatomic, retain) IBOutlet UILabel     *mayorLastNameLabel;

// Called when loading image has been finished.
- (void)    didFinishLoadingVenueImage;
- (void)    didFinishLoadingMayorImage;
- (void)    getUserInfo;
- (void)    fetchVenue;
- (void)    didFinishFetchingVenue:(NSMutableDictionary *)result;

- (IBAction)showMap;

@end
