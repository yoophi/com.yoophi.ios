//
//  CommentView.m
//  MoviePlayer1
//
//  Created by Eric Freeman on 3/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CommentView.h"


@implementation CommentView

- (id)initWithFrame:(CGRect)frame andText:(NSString *) text {
    if ((self = [super initWithFrame:frame])) {
		UIImage *image = [UIImage imageNamed:@"comment.png"];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		[self addSubview:imageView];
 
		CGRect rect = CGRectMake(20, 20, 200.0f, 90.0f);
		UILabel *label = [[UILabel alloc] initWithFrame:rect];
		label.text = text;
		label.numberOfLines = 3;
		label.adjustsFontSizeToFitWidth = YES;
		label.textAlignment = UITextAlignmentCenter;
		label.backgroundColor = [UIColor clearColor];
		[self addSubview:label];
	}
    return self;
}

- (id)initWithText:(NSString *) text {
    if ((self = [super init])) {
		UIImage *image = [UIImage imageNamed:@"comment.png"];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		[self addSubview:imageView];
		
		CGRect rect = CGRectMake(20, 20, 200.0f, 90.0f);
		UILabel *label = [[UILabel alloc] initWithFrame:rect];
		label.text = text;
		label.numberOfLines = 3;
		label.adjustsFontSizeToFitWidth = YES;
		label.textAlignment = UITextAlignmentCenter;
		label.backgroundColor = [UIColor clearColor];
		[self addSubview:label];
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
