//
//  iCan iPhone4 Programming : Project 6 Wisps
//
//  WispsAppDelegate.h
//  Wisps
//
//  Created by DongyoonPark on 1/25/11.
//  Original Game Design by Jess Haskins
//  Copyright Jess Haskins and Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//


#import <UIKit/UIKit.h>

@class RootViewController;

@interface WispsAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
    int 			currentStage;			// 현재 스테이지 
    int 			currentScore;			// 현재 점수
    int 			numWispsOnThisStage;		// 현재 스테이지에서의 총 도깨비불의 개수
    int 			numCaughtWispsTotal;		// 잡은 도깨비불의 총 개수
    int 			numCaughtWispsOnThisStage;	// 현재 스테이지에서 잡은 도깨비불의 개수
    BOOL 			needInit;				// 초기화가 필요한지 여부
}
@property (nonatomic, retain) UIWindow *window;
@property int currentStage;
@property int currentScore;
@property int numWispsOnThisStage;
@property int numCaughtWispsTotal;
@property int numCaughtWispsOnThisStage;
@property BOOL needInit;
@end

