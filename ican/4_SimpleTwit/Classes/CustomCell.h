//
//  iCan iPhone4 Programming : Project 4 Simple Twit
//
//  CustomCell.h
//  Simple Twit
//
//  Created by DeArto20 on 1/25/11.
//  Copyright DeArto20 All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomCell : UITableViewCell {
    IBOutlet UIImageView    *userImageView;
    IBOutlet UILabel        *userNameLabel;
    IBOutlet UILabel        *userTextLabel;
}

@property (nonatomic, retain) IBOutlet UIImageView  *userImageView;
@property (nonatomic, retain) IBOutlet UILabel      *userNameLabel;
@property (nonatomic, retain) IBOutlet UILabel      *userTextLabel;

@end
