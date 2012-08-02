//
//  iCan iPhone4 Programming : Project 6 Wisps
//
//  Wisp.h
//  Wisps
//
//  Created by DongyoonPark on 1/25/11.
//  Original Game Design by Jess Haskins
//  Copyright Jess Haskins and Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "ccTypes.h"
#import "cocos2d.h"

@interface Wisp : NSObject {
	
	CGPoint		pos;		// 위치
	ccColor4F	color;		// 컬러
	BOOL		isCaptured;	// 잡혔는지 여부
	BOOL		isInTheJar;	// 유리병에 같혀있는지 여부
	
	float		waverSpeed;	// 자유상태에서 랜덤하게 움직이는 속도
	float		dodgeSpeed;	// 캐쳐가 다가올때 도망가는 속도
	float		blink_deg;	// 반짝임 효과를 위한 변수
	float		blink_t;	// 반짝임 효과를 위한 변수
	
	CCSprite	*wispImage;	// 도깨비불 이미지
}

@property (nonatomic, assign) CGPoint		pos;
@property (nonatomic, assign) ccColor4F		color;
@property (nonatomic, assign) BOOL			isCaptured;
@property (nonatomic, assign) BOOL			isInTheJar;
@property (nonatomic, assign) float			waverSpeed;
@property (nonatomic, assign) float			dodgeSpeed;
@property (nonatomic, assign) float			blink_deg;
@property (nonatomic, assign) float			blink_t;
@property (nonatomic, retain) CCSprite		*wispImage;

-(void) step:(ccTime) dt;
-(void) performDodging;

@end
