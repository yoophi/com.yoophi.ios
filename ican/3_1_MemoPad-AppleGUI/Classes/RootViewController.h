//
//  iCan iPhone4 Programming : Project 3 Memo Pad
//
//  RootViewController.h
//  MemoPad
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
    IBOutlet UIBarButtonItem *btnWrite;

}
- (IBAction)btnWriteTouched:(id)sender;
@end
