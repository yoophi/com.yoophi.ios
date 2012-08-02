//
//  iCan iPhone4 Programming : Project 3 Memo Pad
//
//  ContentViewController.h
//  MemoPad
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemoData.h"

@interface ContentViewController : UIViewController <UIAlertViewDelegate> {
    IBOutlet UILabel *labelDate;
    IBOutlet UILabel *labelTitle;
    IBOutlet UITextView *tvContent;
    IBOutlet UIBarButtonItem *btnDelete;
    IBOutlet UIBarButtonItem *btnEdit;
	IBOutlet UISlider *sliderFontSize;

	MemoData *mData;
	
}
- (IBAction)deleteMemo:(id)sender;
- (IBAction)editMemo:(id)sender;
- (IBAction)changeFontSize:(id)sender;


@property (retain, nonatomic) IBOutlet UILabel *labelDate;
@property (retain, nonatomic) IBOutlet UILabel *labelTitle;
@property (retain, nonatomic) IBOutlet UITextView *tvContent;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnDelete;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnEdit;
@property (retain, nonatomic) IBOutlet UISlider *sliderFontSize;
@property (retain, nonatomic) MemoData *mData;


@end
