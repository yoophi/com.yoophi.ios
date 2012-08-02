//
//  iCan iPhone4 Programming : Project 6 Wisps
//
//  GameScene.h
//  Wisps
//
//  Created by DongyoonPark on 1/25/11.
//  Original Game Design by Jess Haskins
//  Copyright Jess Haskins and Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Wisp.h"
#import "cocoslive.h"

@interface GameScene : CCLayer <UIAccelerometerDelegate, UIAlertViewDelegate>
{
	
	CCSprite		*bgForestLayer_Sky;		// 배경 하늘
	CCSprite		*bgForestLayer_Tree1;	// 배경 나무1
	CCSprite		*bgForestLayer_Tree2;	// 배경 나무2
	CCSprite		*bgForestLayer_Grass1;	// 배경 풀숲1
	CCSprite		*bgForestLayer_Grass2;	// 배경 풀숲2
	CCSprite		*jar;		// 유리병 이미지
	CCSprite		*catcher;	// 캐쳐 이미지
	CCLabelTTF			*lblScore;	// 스코어 표시를 위한 Label
	CCLabelTTF			*lblFreeWisps; // 남은 도깨비불 개수 표시를 위한 Label
	
	NSMutableArray	*wispsArray;	// 도깨비불들을 담는 Array
	Wisp			*wisp;
	CCParallaxNode	*paraNode;
	
	float			prevAccZ;
	float			xposOffset;
	int				numFreeWisps;
	int				currentAlertView;
	NSString		*postName; 
	int				timerCounter;
	int				timerSec;
}

+(id) scene;
-(void) postScore;
-(void) resetGame;

@end
