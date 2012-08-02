//
//  iCan iPhone4 Programming : Project 2 Beauty of Korea
//
//  RootViewController.h
//  BeautyOfKorea
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController {
	
	IBOutlet UIButton *btnMenu1;
	IBOutlet UIButton *btnMenu2;
	IBOutlet UIButton *btnMenu3;
	IBOutlet UIButton *btnMenu4;
	IBOutlet UIButton *btnMenu5;
	IBOutlet UIButton *btnMenu6;
	
	IBOutlet UIImageView *ivBackground;
	IBOutlet UIImageView *ivTitle;
}

@property (nonatomic,retain) IBOutlet UIButton *btnMenu1; 
@property (nonatomic,retain) IBOutlet UIButton *btnMenu2; 
@property (nonatomic,retain) IBOutlet UIButton *btnMenu3; 
@property (nonatomic,retain) IBOutlet UIButton *btnMenu4; 
@property (nonatomic,retain) IBOutlet UIButton *btnMenu5; 
@property (nonatomic,retain) IBOutlet UIButton *btnMenu6; 
@property (nonatomic,retain) IBOutlet UIImageView *ivBackground;
@property (nonatomic,retain) IBOutlet UIImageView *ivTitle;


-(IBAction)btnMenu1Touched;
-(IBAction)btnMenu2Touched;
-(IBAction)btnMenu3Touched;
-(IBAction)btnMenu4Touched;
-(IBAction)btnMenu5Touched;
-(IBAction)btnMenu6Touched;

@end
