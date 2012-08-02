//
//  iCan iPhone4 Programming : Project 6 Wisps
//
//  GameScene.m
//  Wisps
//
//  Created by DongyoonPark on 1/25/11.
//  Original Game Design by Jess Haskins
//  Copyright Jess Haskins and Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//


#import "GameScene.h"
#import "WispsAppDelegate.h"
#import "MainMenuScene.h"
#import "AlertInputView.h"
#import "StageClearScene.h"

#define kWispDetectionBoundary 20
#define kWispDodgeBoundary 50
#define kAccelerometerTiltThreshold 0.1
#define kCatcherMovePixel 2

enum {
	kTagLayeredBackgrounds,
	kTagCatcher,
	kTagDummy,
};

@implementation GameScene

+(id) scene
{
	
	CCScene *scene = [CCScene node];	
	GameScene *layer = [GameScene node];	
	[scene addChild: layer z:0];
	
	return scene;
}

-(id) init
{
	if( (self=[super init] )) { 
		
		timerSec = 30;
		
		// Get Touch events!
		self.isTouchEnabled = YES;
		self.isAccelerometerEnabled = YES;
		[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60)];
		
		xposOffset = 0;
		postName = @"Noname";
		currentAlertView = 0; 
		
		WispsAppDelegate *appDelegate = (WispsAppDelegate *)[[UIApplication sharedApplication] delegate];
		
		// Background sprite images
		bgForestLayer_Sky = [CCSprite spriteWithFile:@"ForestLayered_Sky.png"];	
		bgForestLayer_Tree1 = [CCSprite spriteWithFile:@"ForestLayered_Trees1.png"];
		bgForestLayer_Tree2 = [CCSprite spriteWithFile:@"ForestLayered_Trees2.png"];
		bgForestLayer_Grass1 = [CCSprite spriteWithFile:@"Grass1.png"];
		bgForestLayer_Grass2 = [CCSprite spriteWithFile:@"Grass2.png"];
		jar = [CCSprite spriteWithFile:@"Jar.png"];
		catcher = [CCSprite spriteWithFile:@"Catcher.png"];
		[bgForestLayer_Sky setPosition:ccp(160, 300)];
		[jar setPosition:ccp(160, 40)];
		[catcher setPosition:ccp(160, 240)];
		
		// Parallax node
		paraNode = [CCParallaxNode node];
		
		[paraNode addChild:bgForestLayer_Tree1 z:-1 
			 parallaxRatio:ccp(0.3f,0.0f) positionOffset:ccp(160,250)]; 
		[paraNode addChild:bgForestLayer_Tree2 z:1 
			 parallaxRatio:ccp(0.7f,0.0f) positionOffset:ccp(160,150)];
		[paraNode addChild:bgForestLayer_Grass2 z:2 
			 parallaxRatio:ccp(1.0f,0.0f) positionOffset:ccp(160,50)];
		[paraNode addChild:jar z:3 
			 parallaxRatio:ccp(1.0f,0.0f) positionOffset:ccp(160,40)];
		[paraNode addChild:bgForestLayer_Grass1 z:4 
			 parallaxRatio:ccp(1.2f,0.0f) positionOffset:ccp(160,5)];
		
		[self addChild:bgForestLayer_Sky z:5];
		[self addChild:paraNode z:6 tag:kTagLayeredBackgrounds];		
		[self addChild:catcher z:50 tag:kTagCatcher];

		// Text labels
		lblScore = [CCLabelTTF labelWithString:@"0" fontName:@"Helvetica" fontSize:10];
		lblScore.position =  ccp( 80 , 460);		
		lblFreeWisps = [CCLabelTTF labelWithString:@"0" fontName:@"Helvetica" fontSize:10];
		lblFreeWisps.position =  ccp( 200 , 460);
		
		[self addChild: lblScore z:50];
		[self addChild: lblFreeWisps z:50];
		
		NSString *string 
		= [NSString stringWithFormat:@"Score %d", [appDelegate currentScore]];
		[lblScore setString:string];		
		NSString *stringFW 
		= [NSString stringWithFormat:@"Wisps left %d", numFreeWisps];
		[lblFreeWisps setString:stringFW];
		
		// Close menu
		CCMenuItem *item = [CCMenuItemImage 
							itemFromNormalImage:@"btnCloseGame.png" 
							selectedImage:@"btnCloseGamePressed.png" 
							target:self 
							selector:@selector(menuCallbackMainmenu:)];		
		CCMenu *menuClose = [CCMenu menuWithItems: item, nil];
		[menuClose alignItemsVertically];		
		menuClose.position = ccp( 20 , 460 );
		[self addChild: menuClose z:60];
		
		// step method
		[self schedule:@selector(step:)];
		
	}
	return self;
}


-(void) step:(ccTime) dt
{
	WispsAppDelegate *appDelegate 
	= (WispsAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	for (int i=0; i<[appDelegate numWispsOnThisStage]; i++) {
		Wisp *targetWisp = [wispsArray objectAtIndex:i];
		[targetWisp step:dt];
	}

	timerCounter++;
	
	if(timerCounter >=30)
	{
		timerSec--;
		
		if (timerSec == 0) {
			[self unschedule:@selector(step:)];
			NSString *stringFW = [NSString stringWithFormat:@"TIME OVER"];
			[lblFreeWisps setString:stringFW];
			[appDelegate setCurrentStage:[appDelegate currentStage]+1];				
			[[CCDirector sharedDirector] replaceScene:
			 [CCTransitionFade transitionWithDuration:2.0 
												scene:[StageClearScene scene]]];
		}
		else {
			NSString *stringFW = [NSString stringWithFormat:@"Stage %d/Wisps Left %d/Timer %d", [appDelegate currentStage], numFreeWisps, timerSec];
			[lblFreeWisps setString:stringFW];
		}
		
		timerCounter = 0;
	}
}

-(void) onEnter
{
	[super onEnter];
	
	WispsAppDelegate *appDelegate 
	= (WispsAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	int currentStage = [appDelegate currentStage];
	numFreeWisps = currentStage * 5; 
	[appDelegate setNumWispsOnThisStage:numFreeWisps];
	[appDelegate setNumCaughtWispsOnThisStage:0];
	
	
	NSString *stringFW = [NSString stringWithFormat:@"Wisps Left %d, Timer %d", numFreeWisps, timerSec];
	[lblFreeWisps setString:stringFW];
	
	wispsArray = [[NSMutableArray alloc] initWithCapacity:numFreeWisps];
	
	for (int i=0; i<numFreeWisps; i++) {
		
		Wisp *wisps = [[Wisp alloc] init];
		
		[paraNode addChild:[wisps wispImage] z:30 parallaxRatio:ccp(1.0f,0.0f) positionOffset:ccp(160,0)];
		
		[wispsArray addObject:wisps];
		
	}
	
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	if( touch ) {
		CGPoint location = [touch locationInView: [touch view]];
		location.y = 480-location.y;
		
		for (int i=0; i<[wispsArray count] ; i++) {
			
			Wisp *targetWisp = [wispsArray objectAtIndex:i];	// For Wisp position
			CCNode *node = [self getChildByTag:kTagCatcher]; // For Catcher position
			CGPoint currentPos = [node position];
			
			// This logic should be only applied to free Wisps.
			if([targetWisp isCaptured] == FALSE)
			{
				if (([targetWisp pos].x > currentPos.x - xposOffset - kWispDetectionBoundary) 
					&& ([targetWisp pos].x < currentPos.x - xposOffset + kWispDetectionBoundary)
					&& ([targetWisp pos].y > currentPos.y - kWispDetectionBoundary)
					&& ([targetWisp pos].y < currentPos.y + kWispDetectionBoundary)) 
				{
					//NSLog(@"Captured!");
					WispsAppDelegate *appDelegate = (WispsAppDelegate *)[[UIApplication sharedApplication] delegate];
					[appDelegate setNumCaughtWispsOnThisStage:[appDelegate numCaughtWispsOnThisStage]+1];
					
					numFreeWisps--;
					NSString *stringFW = [NSString stringWithFormat:@"Excellent!", numFreeWisps];
					[lblFreeWisps setString:stringFW];
					
					[appDelegate setCurrentScore:[appDelegate currentScore]+100];
					[targetWisp setIsCaptured:TRUE];
					
					NSString *string = [NSString stringWithFormat:@"Score %d", [appDelegate currentScore]];
					[lblScore setString:string];
					
					
					// Stage Clear!!!
					if(numFreeWisps <= 0)
					{
						
						[self unschedule:@selector(step:)];
						
						[appDelegate setCurrentStage:[appDelegate currentStage]+1];					
						[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2.0 scene:[StageClearScene scene]]];
						
					}
				}
			}
		}
	}
}


- (void) accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{
	
	CCNode *nodeBG = [self getChildByTag:kTagLayeredBackgrounds];
	CGPoint currentPosBG = [nodeBG position];
	CGPoint diff;
	BOOL isCatcherMoved = FALSE;
	
	CCNode *nodeCatcher = [self getChildByTag:kTagCatcher]; // For Catcher position
	CGPoint currentPos = [nodeCatcher position];
	
	// For catcher movement
	if(acceleration.x < -kAccelerometerTiltThreshold)
	{
		// Catcher
		if(currentPos.x >= 20)
		{
			currentPos = ccp(currentPos.x-kCatcherMovePixel, currentPos.y);
		}
		
		// Background movement
		if(currentPosBG.x < 100)
		{
			diff = ccp(currentPosBG.x+kCatcherMovePixel,currentPosBG.y);
			[nodeBG setPosition:diff];
			
		}
		isCatcherMoved = TRUE;
	}
	
	else if(acceleration.x > kAccelerometerTiltThreshold)
	{
		// Catcher
		if(currentPos.x <= 300)
		{
			currentPos = ccp(currentPos.x+kCatcherMovePixel, currentPos.y);
		}
		
		// Background movement
		if(currentPosBG.x > - 100)
		{
			diff = ccp(currentPosBG.x-kCatcherMovePixel,currentPosBG.y);
			[nodeBG setPosition:diff];
		}
		isCatcherMoved = TRUE;
	}
	
	if(acceleration.y < -0.4)		
	{
		if(currentPos.y >= 20)
		{
			currentPos = ccp(currentPos.x, currentPos.y-kCatcherMovePixel);
			isCatcherMoved = TRUE;
		}
	}
	else if(acceleration.y > -0.2)		
	{
		if(currentPos.y <= 460)
		{			
			currentPos = ccp(currentPos.x, currentPos.y+kCatcherMovePixel);
			isCatcherMoved = TRUE;			
		}
	}
	
	if(isCatcherMoved)
	{
		[catcher setPosition:currentPos];
	}
	xposOffset = currentPosBG.x;
	
	for (int i=0; i<[wispsArray count] ; i++) {
		
		Wisp *targetWisp = [wispsArray objectAtIndex:i];	// For Wisp position
		CCNode *node = [self getChildByTag:kTagCatcher]; // For Catcher position
		CGPoint currentPos = [node position];
		
		if([targetWisp isCaptured] == FALSE)
		{
			if (([targetWisp pos].x > currentPos.x - xposOffset - kWispDodgeBoundary) 
				&& ([targetWisp pos].x < currentPos.x - xposOffset + kWispDodgeBoundary)
				&& ([targetWisp pos].y > currentPos.y - kWispDodgeBoundary)
				&& ([targetWisp pos].y < currentPos.y + kWispDodgeBoundary)) 
			{
				//NSLog(@"Captured!");
				
				[targetWisp performDodging];
			}
		}
	}
}

-(void) menuCallbackMainmenu:(id) sender
{
	[self unschedule:@selector(step:)];
	
	UIAlertView*			alertView;
	currentAlertView = 0;
	alertView = [[UIAlertView alloc] initWithTitle:@"Wisps" message:nil delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
	[alertView setMessage:[NSString stringWithFormat:@"Do you want to finish the game?", 						[[UIDevice currentDevice] model]]];
	[alertView show];
	[alertView release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(currentAlertView == 0) // Quit Alert
	{
		if(buttonIndex == 1) // YES
		{
			currentAlertView = 1;
			AlertInputView *prompt = [AlertInputView alloc];
			prompt = [prompt initWithTitle:@"Post score" message:@"Please enter your name\n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" okButtonTitle:@"Okay"];
			[prompt show];
			[prompt release];		
			
		}
		else
		{
			[self schedule:@selector(step:)];
		}
		
	}
	else if(currentAlertView == 1) // Before posting
	{ 
		if(buttonIndex == 1) // OK
		{
			postName = [(AlertInputView*)alertView enteredText];
			currentAlertView = 2;
			[self postScore];
		}
		else { // CANCEL
			
			[self resetGame];
			[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainMenuScene scene]]];
		}
		
	}
	else if(currentAlertView == 2) // After posting
	{
		[self resetGame];
		[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainMenuScene scene]]];

	}
}

-(void) postScore
{
	CLScoreServerPost *server = [[CLScoreServerPost alloc] initWithGameName:@"Wisps" gameKey:@"ad0c544c19f91c3fd6c6cxxxxxxxx" delegate:self];
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
	
	WispsAppDelegate *appDelegate = (WispsAppDelegate *)[[UIApplication sharedApplication] delegate];
	[dict setObject: [NSNumber numberWithInt:[appDelegate currentScore]] forKey:@"cc_score"];
	
	NSString *cat = @"Classic";
	[dict setObject:cat forKey:@"cc_category"];
	[dict setObject:postName forKey:@"cc_playername"];
	[server updateScore:dict];
	[server release];
}

-(void) scorePostOk: (id) sender
{
	if( [sender ranking] != kServerPostInvalidRanking && [sender scoreDidUpdate]) {
		NSString *message = [NSString stringWithFormat:@"World ranking: %d", [sender ranking]];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Post Ok." message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];	
		[alert show];
		[alert release];		
	}
}

-(void) scorePostFail: (id) sender
{
	NSString *message = nil;
	tPostStatus status = [sender postStatus];
	if( status == kPostStatusPostFailed )
		message = @"Score server had a problem. Sorry!";
	else if( status == kPostStatusConnectionFailed )
		message = @"Internet connection not available. Enable Wi-Fi/3G to post your scores to the server";
	
	NSLog(@"%@", message);
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Score Post Failed" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];	
	[alert show];
	[alert release];		
}

-(void) resetGame
{
	WispsAppDelegate *appDelegate = (WispsAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[appDelegate setCurrentStage:1];
	[appDelegate setCurrentScore:0];
	[appDelegate setNumCaughtWispsTotal:0];
	[appDelegate setNumWispsOnThisStage:0];
	[appDelegate setNumCaughtWispsOnThisStage:0];
}

- (void) dealloc
{
	
	for (int i=0; i<numFreeWisps; i++) {
		
		Wisp *targetWisp = [wispsArray objectAtIndex:i];
		
		[targetWisp release];
	}		
	
	[wispsArray release];
	
	[super dealloc];
}


@end






