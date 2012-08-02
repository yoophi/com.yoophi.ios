//
//  iCan iPhone4 Programming : Project 4 Simple Twit
//
//  DetailViewController.h
//  Simple Twit
//
//  Created by DeArto20 on 1/25/11.
//  Copyright DeArto20 All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailViewController : UIViewController {
    NSDictionary            *tweet;
    
    IBOutlet    UIImageView *userImageView;
    IBOutlet    UILabel     *userScreenNameLabel;
    IBOutlet    UILabel     *userNameLabel;
    IBOutlet    UILabel     *userTextLabel;
    IBOutlet    UILabel     *userTimeLabel;
}

@property (nonatomic, retain) NSDictionary          *tweet;

@property (nonatomic, retain) IBOutlet  UIImageView *userImageView;
@property (nonatomic, retain) IBOutlet  UILabel     *userScreenNameLabel;
@property (nonatomic, retain) IBOutlet  UILabel     *userNameLabel;
@property (nonatomic, retain) IBOutlet  UILabel     *userTextLabel;
@property (nonatomic, retain) IBOutlet  UILabel     *userTimeLabel;

// Called when loading image has been finished.
- (void)didFinishLoadingImage;

@end
