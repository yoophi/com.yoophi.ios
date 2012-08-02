//
//  iCan iPhone4 Programming : Project 1 Abstract Clock
//
//  FlipsideViewController.h
//  AbstractClock
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlipsideViewControllerDelegate;


@interface FlipsideViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	id <FlipsideViewControllerDelegate> delegate;
	UITableView *tableView;

}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property(retain, nonatomic) UITableView *tableView;
- (IBAction)done:(id)sender;
@end


@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

