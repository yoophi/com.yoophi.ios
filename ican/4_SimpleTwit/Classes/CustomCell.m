//
//  iCan iPhone4 Programming : Project 4 Simple Twit
//
//  CustomCell.m
//  Simple Twit
//
//  Created by DeArto20 on 1/25/11.
//  Copyright DeArto20 All rights reserved.
//

#import "CustomCell.h"


@implementation CustomCell

@synthesize userImageView;
@synthesize userNameLabel;
@synthesize userTextLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    if (userImageView) {
        [userImageView release];
    }
    
    if (userNameLabel) {
        [userNameLabel release];
    }
    
    if (userTextLabel) {
        [userTextLabel release];
    }
    
    [super dealloc];
}


@end
