//
//  iCan iPhone4 Programming : Project 6 Wisps
//
//  InstructionScene.h
//  Wisps
//
//  Created by DongyoonPark on 1/25/11.
//  Original Game Design by Jess Haskins
//  Copyright Jess Haskins and Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface InstructionScene : CCLayer {
	
	CCSprite			*background;
	CCSprite			*introText;
}

+(id) scene;

@end
