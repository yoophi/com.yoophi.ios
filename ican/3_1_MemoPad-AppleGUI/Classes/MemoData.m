//
//  iCan iPhone4 Programming : Project 3 Memo Pad
//
//  MemoData.m
//  MemoPad
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import "MemoData.h"

@implementation MemoData

@synthesize mIndex;
@synthesize mTitle;
@synthesize mContent;
@synthesize mDate;

-(id)initWithData:(NSInteger)pIndex Title:(NSString*)pTitle Content:(NSString*)pContent Date:(NSString*)pDate
{
	self.mIndex = pIndex;
	self.mTitle = pTitle;
	self.mContent = pContent;
	self.mDate = pDate;
	return self;
}

- (void)dealloc {
	if(mTitle) {
		[mTitle release];
	}
	if(mContent) {
		[mContent release];
	}
	if(mDate) {
		[mDate release];
	}
	
    [super dealloc];
}

@end
