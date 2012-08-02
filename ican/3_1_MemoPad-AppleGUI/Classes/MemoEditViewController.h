//
//  iCan iPhone4 Programming : Project 3 Memo Pad
//
//  MemoEditViewController.h
//  MemoPad
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemoData.h"
#import "ContentViewController.h"

@interface MemoEditViewController : UIViewController {
	
	IBOutlet UITextField *tfTitle;
	IBOutlet UITextView *tvContent;	
    IBOutlet UINavigationBar *navigationBar;
    IBOutlet UIBarButtonItem *btnSave;
    IBOutlet UIBarButtonItem *btnCancel;
	
	ContentViewController *parent;
	MemoData *mData;

}

@property (retain, nonatomic) IBOutlet UITextField *tfTitle;
@property (retain, nonatomic) IBOutlet UITextView *tvContent;	
@property (retain, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnSave;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnCancel;
@property (retain, nonatomic) ContentViewController *parent;
@property (retain, nonatomic) MemoData *mData;

- (IBAction)saveMemo:(id)sender;
- (IBAction)cancelMemo:(id)sender;

@end