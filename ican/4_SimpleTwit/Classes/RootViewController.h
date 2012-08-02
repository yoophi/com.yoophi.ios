//
//  iCan iPhone4 Programming : Project 4 Simple Twit
//
//  RootViewController.h
//  Simple Twit
//
//  Created by DeArto20 on 1/25/11.
//  Copyright DeArto20 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
    NSMutableArray  *tweetList;
}

@property (nonatomic, retain) NSMutableArray *tweetList;

- (void)updateTimeLine;
- (void)fetchPublicTimeLine;
- (void)didFinishFetchingPublicTimeLine:(NSArray *)result;

@end
