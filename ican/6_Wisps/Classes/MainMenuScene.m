//
//  iCan iPhone4 Programming : Project 6 Wisps
//
//  MainMenuScene.m
//  Wisps
//
//  Created by DongyoonPark on 1/25/11.
//  Original Game Design by Jess Haskins
//  Copyright Jess Haskins and Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//


// Import the interfaces
#import "MainMenuScene.h"
#import "IntroductionScene.h"
#import "InstructionScene.h"
#import "GameScene.h"
#import "HighScoreScene.h"
#import "WispsAppDelegate.h"

@implementation MainMenuScene

+(id) scene
{
	CCScene *scene = [CCScene node];
	MainMenuScene *layer = [MainMenuScene node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self=[super init] )) {
		background = [CCSprite spriteWithFile:@"Default.png"];
		[background setPosition:ccp(160, 240)];
		
		CCMenuItem *item1 = [CCMenuItemImage itemFromNormalImage:@"menu1.png" selectedImage:@"menu1Pressed.png" target:self selector:@selector(menuCallback1:)];
		CCMenuItem *item2 = [CCMenuItemImage itemFromNormalImage:@"menu2.png" selectedImage:@"menu2Pressed.png" target:self selector:@selector(menuCallback2:)];
		CCMenuItem *item3 = [CCMenuItemImage itemFromNormalImage:@"menu3.png" selectedImage:@"menu3Pressed.png" target:self selector:@selector(menuCallback3:)];
		CCMenuItem *item4 = [CCMenuItemImage itemFromNormalImage:@"menu4.png" selectedImage:@"menu4Pressed.png" target:self selector:@selector(menuCallback4:)];
		
		CCMenu *menu = [CCMenu menuWithItems: item1, item2, item3, item4, nil];
		[menu alignItemsVertically];
		
		CGSize size = [[CCDirector sharedDirector] winSize];
		menu.position = ccp( size.width /2 , size.height/2 );
		
		[self addChild: menu z:100];	
		[self addChild:background z:5];
	}
	return self;
}
-(void) menuCallback1:(id) sender
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2.0 scene:[IntroductionScene scene]]];
}

-(void) menuCallback2:(id) sender
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2.0 scene:[InstructionScene scene]]];
}

-(void) menuCallback3:(id) sender
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2.0 scene:[GameScene scene]]];
}

-(void) menuCallback4:(id) sender
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2.0 scene:[HighScoreScene scene]]];
}


- (void) dealloc
{
	[super dealloc];
}
@end
