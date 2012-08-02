//
//  iCan iPhone4 Programming : Project 3 Memo Pad
//
//  MemoData.h
//  MemoPad
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemoData : NSObject {
	NSInteger mIndex;
	NSString *mTitle;
	NSString *mContent;
	NSString *mDate;
}

@property(nonatomic, assign) NSInteger mIndex;
@property(nonatomic, retain) NSString *mTitle;
@property(nonatomic, retain) NSString *mContent;
@property(nonatomic, retain) NSString *mDate;

-(id)initWithData:(NSInteger)pIndex Title:(NSString*)pTitle Content:(NSString*)pContent Date:(NSString*)pDate;

@end
