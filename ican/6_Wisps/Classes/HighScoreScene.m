//
//  iCan iPhone4 Programming : Project 6 Wisps
//
//  HighScoreScene.m
//  Wisps
//
//  Created by DongyoonPark on 1/25/11.
//  Original Game Design by Jess Haskins
//  Copyright Jess Haskins and Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import "HighScoreScene.h"
#import "MainMenuScene.h"
#define kCellHeight  23
#define kCellBegin 400

@implementation HighScoreScene
@synthesize globalScores;
+(id) scene
{
	CCScene *scene = [CCScene node];
	HighScoreScene *layer = [HighScoreScene node];	
	[scene addChild: layer z:0];
	return scene;
}

-(id) init
{
	if( (self=[super init] )) { 
		
		self.isTouchEnabled = YES;		
		
		// Background
		background = [CCSprite spriteWithFile:@"Background_Blank.png"];
		[background setPosition:ccp(160, 240)];
		
		// Tap to continue
		spText = [CCSprite spriteWithFile:@"menuPressTouch.png"];
		[spText setPosition:ccp(160, 40)];
		
		// Title
		spTitle = [CCSprite spriteWithFile:@"titleWorldRank.png"];
		[spTitle setPosition:ccp(160, 450)];
		
		[self addChild:background z:5];
		[self addChild:spTitle z:10];
		[self addChild:spText z:10];
	}
	return self;
}

-(void) onEnter
{
	[super onEnter];
	[self requestScore];
	
}

-(void) requestScore
{
	CLScoreServerRequest *request = [[CLScoreServerRequest alloc] initWithGameName:@"Wisps" delegate:self];
	
	NSString *cat = @"Classic";
	tQueryFlags flags = kQueryFlagIgnore;
	[request requestScores:kQueryAllTime limit:15 offset:0 flags:flags category:cat];
	[request release];
}

-(void) scoreRequestOk: (id) sender
{
	NSArray *scores = [sender parseScores];	
	NSMutableArray *mutable = [NSMutableArray arrayWithArray:scores];
	self.globalScores = mutable;
	
	CCLabelTTF *desc = [CCLabelTTF labelWithString:@"Rank             Name                              Score         Country" fontName:@"Arial" fontSize:12];
	[self addChild:desc z:19];
	desc.position = ccp(160, kCellBegin+kCellHeight);
	
	for(int i=0 ; i<15 ; i++)
	{
		NSDictionary	*s = [globalScores objectAtIndex:i];
		
		// Rank
		CCLabelTTF *idx = [CCLabelTTF labelWithString:@"00" fontName:@"Arial" fontSize:12];
		idx.position = ccp(30, kCellBegin-i*kCellHeight);
		[self addChild:idx z:20+i];
		
		// Name
		CCLabelTTF *name = [CCLabelTTF labelWithString:@"-" fontName:@"Arial" fontSize:12];
		name.position = ccp(100,kCellBegin-i*kCellHeight);
		[self addChild:name z:20+i];
		
		// Score
		CCLabelTTF *score = [CCLabelTTF labelWithString:@"1234567890" fontName:@"Arial" fontSize:12];
		score.position = ccp(220,kCellBegin-i*kCellHeight);
		[self addChild:score z:20+i];
		
		// Country
		CCLabelTTF *country = [CCLabelTTF labelWithString:@"Korea" fontName:@"Arial" fontSize:12];
		country.position = ccp(290,kCellBegin-i*kCellHeight);
		[self addChild:country z:20+i];
		
		[idx setString:[[s objectForKey:@"position"] stringValue]];
		[name setString:[s objectForKey:@"cc_playername"]];
		[score setString:[[s objectForKey:@"cc_score"] stringValue]];
		[country setString:[s objectForKey:@"cc_country"]];
	}
}

-(void) scoreRequestFail: (id) sender
{
	NSLog(@"score request fail");
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Score Request Failed" message:@"Internet connection not available, cannot view world scores" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];	
	alert.tag = 0;
	[alert show];
	[alert release];	
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainMenuScene scene]]];
}

- (void) dealloc
{
	[super dealloc];
}


