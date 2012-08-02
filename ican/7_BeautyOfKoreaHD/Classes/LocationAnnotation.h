//
//  iCan iPhone4 Programming : Project 7 Beauty of Korea HD
//
//  LocationAnnotation.h
//  BeautyOfKorea
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface LocationAnnotation : NSObject <MKAnnotation> {
	
	CLLocationCoordinate2D coordinate;
	
	NSString *currentSubTitle;
	NSString *currentTitle;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *currentTitle;
@property (nonatomic, retain) NSString *currentSubTitle;

- (NSString *)title;
- (NSString *)subtitle;

-(id)initWithCoordinate:(CLLocationCoordinate2D) c;


@end