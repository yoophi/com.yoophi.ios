//
//  iCan iPhone4 Programming : Project 1 Abstract Clock
//
//  AbstractClockAppDelegate.h
//  AbstractClock
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface AbstractClockAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MainViewController *mainViewController;
	
	int optionClockMode; // 0:Square, 1:Circle
    BOOL option24Hour;
    BOOL optionDateInfo;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainViewController *mainViewController;

@property (nonatomic, assign) int optionClockMode;
@property (nonatomic, assign) BOOL option24Hour;
@property (nonatomic, assign) BOOL optionDateInfo;


@end

