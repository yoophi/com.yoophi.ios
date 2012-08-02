//
//  ImageViewWithTime.h
//  MoviePlayer
//
//  Created by Eric Freeman on 3/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

// START:all
@interface ImageViewWithTime : UIImageView {
	NSNumber *time;
}

@property (nonatomic, retain) NSNumber *time;

@end
// END:all