//
//  iCan iPhone4 Programming : Project 3 Memo Pad
//
//  MemoWriteViewController.h
//  MemoPad
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MemoWriteViewController : UIViewController <UITextViewDelegate> {

	IBOutlet UITextField *tfTitle;
	IBOutlet UITextView *tvContent;	
    IBOutlet UINavigationBar *navigationBar;
    IBOutlet UIBarButtonItem *btnSave;
    IBOutlet UIBarButtonItem *btnCancel;
}

@property (retain, nonatomic) IBOutlet UITextField *tfTitle;
@property (retain, nonatomic) IBOutlet UITextView *tvContent;	
@property (retain, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnSave;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnCancel;

- (IBAction)saveMemo:(id)sender;
- (IBAction)cancelMemo:(id)sender;

@end
