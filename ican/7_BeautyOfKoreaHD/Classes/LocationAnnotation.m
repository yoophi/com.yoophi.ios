//
//  iCan iPhone4 Programming : Project 7 Beauty of Korea HD
//
//  LocationAnnotation.m
//  BeautyOfKorea
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import "LocationAnnotation.h"
#import <MapKit/MapKit.h>


@implementation LocationAnnotation

@synthesize coordinate;
@synthesize currentTitle;
@synthesize currentSubTitle;


- (NSString *)subtitle{
	return currentSubTitle;
}

- (NSString *)title{
	return currentTitle;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	return self;
}

- (void)dealloc {
	[currentSubTitle release];
	[currentTitle release];
    [super dealloc];
}

@end