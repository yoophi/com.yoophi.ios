//
//  iCan iPhone4 Programming : Project 6 Wisps
//
//  IntroductionScene.m
//  Wisps
//
//  Created by DongyoonPark on 1/25/11.
//  Original Game Design by Jess Haskins
//  Copyright Jess Haskins and Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//


#import "IntroductionScene.h"
#import "MainMenuScene.h"


@implementation IntroductionScene

+(id) scene
{
	CCScene *scene = [CCScene node];
	IntroductionScene *layer = [IntroductionScene node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self=[super init] )) {
		self.isTouchEnabled = YES;

		background = [CCSprite spriteWithFile:@"Background_Blank.png"];
		[background setPosition:ccp(160, 240)];
		[self addChild:background z:5];
		
		introText = [CCSprite spriteWithFile:@"textIntroduction.png"];
		[introText setPosition:ccp(160, 240)];
		[self addChild:introText z:10];
		
	}
	return self;
}

-(void) ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainMenuScene scene]]];
}

@end