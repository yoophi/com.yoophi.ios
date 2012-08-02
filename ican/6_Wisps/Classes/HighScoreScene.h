//
//  iCan iPhone4 Programming : Project 6 Wisps
//
//  HighScoreScene.h
//  Wisps
//
//  Created by DongyoonPark on 1/25/11.
//  Original Game Design by Jess Haskins
//  Copyright Jess Haskins and Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocoslive.h"

@interface HighScoreScene : CCLayer
{
	
	CCSprite		*background;
	CCSprite		*spText;
	CCSprite		*spTitle;
	NSMutableArray	*globalScores;
	
}

@property (nonatomic, retain) NSMutableArray *globalScores;

+(id) scene;
-(void) requestScore;

@end
