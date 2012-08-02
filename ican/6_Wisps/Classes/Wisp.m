//
//  iCan iPhone4 Programming : Project 6 Wisps
//
//  Wisp.m
//  Wisps
//
//  Created by DongyoonPark on 1/25/11.
//  Original Game Design by Jess Haskins
//  Copyright Jess Haskins and Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import "Wisp.h"

// 유리병의 경계 영역
#define JAR_BOUNDARY_X1 145
#define JAR_BOUNDARY_X2 175
#define JAR_BOUNDARY_Y1 15
#define JAR_BOUNDARY_Y2 60

// 스테이지의 경계 영역
#define STAGE_BOUNDARY_X1 -100
#define STAGE_BOUNDARY_X2 420
#define STAGE_BOUNDARY_Y1 60
#define STAGE_BOUNDARY_Y2 480

@implementation Wisp
@synthesize pos;
@synthesize color;
@synthesize isCaptured;
@synthesize isInTheJar;
@synthesize waverSpeed;
@synthesize dodgeSpeed;
@synthesize wispImage;
@synthesize blink_deg;
@synthesize blink_t;

-(id) init
{
	[super init];
	
	CGSize size = [[CCDirector sharedDirector] winSize];
	pos = ccp( CCRANDOM_0_1() * size.width, (CCRANDOM_0_1() * (size.height-150))+80);
	
	isCaptured = FALSE;
	waverSpeed = 2;
	dodgeSpeed = 15;
	
	ccColor4F startColor = {0.5f, 0.5f, 0.5f, 1.0f};
	ccColor4F startColorVar = {0.5f, 0.5f, 0.5f, 1.0f};	
	ccColor4F start;
	start.r = startColor.r + startColorVar.r * CCRANDOM_MINUS1_1();
	start.g = startColor.g + startColorVar.g * CCRANDOM_MINUS1_1();
	start.b = startColor.b + startColorVar.b * CCRANDOM_MINUS1_1();
	start.a = startColor.a + startColorVar.a * CCRANDOM_MINUS1_1();
	color = start;
	
	// 반짝임 효과를 위한 임의의 초기값
	blink_deg = CCRANDOM_0_1()*360;
	blink_t = CCRANDOM_0_1()*3+1;
	
	// Sprite 이미지
	wispImage = [CCSprite spriteWithFile:@"Wisp.png"];
	[wispImage setColor:ccc3(color.r * 255, color.g * 255, color.b * 255 )];
	[wispImage setPosition:pos];	
	[wispImage setBlendFunc: (ccBlendFunc) { GL_SRC_ALPHA, GL_ONE }];  
	
	return self;
}

// 매 프레임 불리게 될 step 메소드 
-(void) step:(ccTime) dt
{
	
	// 붙잡힌 상태인 경우
	if (isCaptured) 
	{
		if(!isInTheJar)
		{
			pos = ccp( CCRANDOM_0_1()*(JAR_BOUNDARY_X2-JAR_BOUNDARY_X1) + JAR_BOUNDARY_X1 , CCRANDOM_0_1()*(JAR_BOUNDARY_Y2-JAR_BOUNDARY_Y1) + JAR_BOUNDARY_Y1);
			isInTheJar = TRUE;
		}
		else {
			pos = ccp( pos.x + CCRANDOM_MINUS1_1() * waverSpeed, pos.y +CCRANDOM_MINUS1_1() * waverSpeed);
			if (pos.x <= JAR_BOUNDARY_X1)
				pos.x = JAR_BOUNDARY_X1;
			else if (pos.x >= JAR_BOUNDARY_X2)
				pos.x = JAR_BOUNDARY_X2;
			
			if (pos.y <= JAR_BOUNDARY_Y1)
				pos.y = JAR_BOUNDARY_Y1;
			else if (pos.y >= JAR_BOUNDARY_Y2)
				pos.y = JAR_BOUNDARY_Y2;
		}
	}
	// 자유 상태인 경우 
	else
	{
		pos = ccp( pos.x + CCRANDOM_MINUS1_1() * waverSpeed, pos.y +CCRANDOM_MINUS1_1() * waverSpeed);
		if (pos.x <= STAGE_BOUNDARY_X1)
			pos.x = STAGE_BOUNDARY_X1;
		else if (pos.x >= STAGE_BOUNDARY_X2)
			pos.x = STAGE_BOUNDARY_X2;
		
		if (pos.y <= STAGE_BOUNDARY_Y1)
			pos.y = STAGE_BOUNDARY_Y1;
		else if (pos.y >= STAGE_BOUNDARY_Y2)
			pos.y = STAGE_BOUNDARY_Y2;
	}
	[wispImage setPosition:pos];
	
	if(blink_deg<360)
		blink_deg = blink_deg+10;
	else 
		blink_deg = 0;
	
	color.a = 0.35 * sin((M_PI/180)*blink_deg*blink_t)+0.65;
	wispImage.opacity = color.a * 255;
	[wispImage setColor:ccc3(color.r * 255, color.g * 255, color.b * 255 )];
	
}

// 캐쳐가 다가오는 경우 도망가는 동작
-(void) performDodging
{
	pos = ccp( pos.x + CCRANDOM_MINUS1_1() * dodgeSpeed, pos.y +CCRANDOM_MINUS1_1() * dodgeSpeed);
	[wispImage setPosition:pos];
}

- (void) dealloc
{
	[super dealloc];
}

@end
