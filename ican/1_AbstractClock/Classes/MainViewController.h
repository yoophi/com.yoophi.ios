//
//  iCan iPhone4 Programming : Project 1 Abstract Clock
//
//  MainViewController.h
//  AbstractClock
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
    NSMutableArray *arraySquareImages;
    NSMutableArray *arrayCircleImages;
    NSTimer *timer;
    UILabel *lblTimeDigit;
    UILabel *lblAMPM;
    UILabel *lblDateInfo;
}

@property(retain, nonatomic) NSMutableArray *arraySquareImages;
@property(retain, nonatomic) NSMutableArray *arrayCircleImages;
@property(retain, nonatomic) NSTimer *timer;
@property(retain, nonatomic) UILabel *lblTimeDigit;
@property(retain, nonatomic) UILabel *lblAMPM;
@property(retain, nonatomic) UILabel *lblDateInfo;

- (IBAction)showInfo:(id)sender;
- (void)clearScreen;
-(NSString *) dateInFormat:(NSString*) stringFormat;


@end