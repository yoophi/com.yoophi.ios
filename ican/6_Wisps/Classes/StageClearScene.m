//
//  iCan iPhone4 Programming : Project 6 Wisps
//
//  StageClearScene.m
//  Wisps
//
//  Created by DongyoonPark on 1/25/11.
//  Original Game Design by Jess Haskins
//  Copyright Jess Haskins and Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//


#import "StageClearScene.h"
#import "WispsAppDelegate.h"
#import "GameScene.h"
#import "AlertInputView.h"
#import "MainMenuScene.h"

@implementation StageClearScene

+(id) scene
{
	CCScene *scene = [CCScene node];
	StageClearScene *layer = [StageClearScene node];	
	[scene addChild: layer z:0];
	return scene;
}

-(id) init
{
	if( (self=[super init] )) { 
		
		self.isTouchEnabled = YES;
		
		// Background
		background = [CCSprite spriteWithFile:@"Background_StageClearScene.png"];
		[background setPosition:ccp(160, 240)];
		
		// Label
		lblNumber = [CCLabelTTF labelWithString:@"0" fontName:@"Helvetica" fontSize:24];
		lblNumber.position =  ccp(158, 133);
		[self addChild:lblNumber z:50];
		
		lblNumberTotal = [CCLabelTTF labelWithString:@"0" fontName:@"Helvetica" fontSize:24];
		lblNumberTotal.position =  ccp(204, 133);
		[self addChild:lblNumberTotal z:50];
		[self addChild:background z:5];
		
	}
	return self;
}

-(void) onEnter
{
	[super onEnter];
	
	WispsAppDelegate *appDelegate = (WispsAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	NSString *string = [NSString stringWithFormat:@"%d", [appDelegate numCaughtWispsOnThisStage]];
	[lblNumber setString:string];
	
	NSString *stringTotal = [NSString stringWithFormat:@"%d", [appDelegate numWispsOnThisStage]];
	[lblNumberTotal setString:stringTotal];
	
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:3.0 scene:[GameScene scene]]];
}

- (void) dealloc
{
	[super dealloc];
}

@end

