//
//  iCan iPhone4 Programming : Project 2 Beauty of Korea
//
//  BeautyOfKoreaAppDelegate.h
//  BeautyOfKorea
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeautyOfKoreaAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

