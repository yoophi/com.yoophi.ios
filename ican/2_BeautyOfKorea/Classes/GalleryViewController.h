//
//  iCan iPhone4 Programming : Project 2 Beauty of Korea
//
//  GalleryViewController.h
//  BeautyOfKorea
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GalleryViewController : UIViewController {
	IBOutlet UIButton *btnBack;
	IBOutlet UIScrollView *svContent;
	int currentMenu;
}

@property(nonatomic,retain) IBOutlet UIButton *btnBack;
@property(nonatomic,retain) IBOutlet UIScrollView *svContent;
@property(assign) int currentMenu;

-(IBAction)btnBackTouched;

@end
