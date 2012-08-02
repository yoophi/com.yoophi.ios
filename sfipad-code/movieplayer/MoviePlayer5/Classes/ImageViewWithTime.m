//
//  ImageViewWithTime.m
//  MoviePlayer
//
//  Created by Eric Freeman on 3/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ImageViewWithTime.h"


@implementation ImageViewWithTime
@synthesize time;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
