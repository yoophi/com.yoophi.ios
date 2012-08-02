//
//  iCan iPhone4 Programming : Project 6 Wisps
//
//  AlertInputView.h
//  Wisps
//
//  Created by DongyoonPark on 1/25/11.
//  Original Game Design by Jess Haskins
//  Copyright Jess Haskins and Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertInputView : UIAlertView 
{
	UITextField *textField;
	NSString *enteredText;
}

@property (nonatomic, retain) UITextField *textField;
@property (readonly) NSString *enteredText;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okButtonTitle;

@end

