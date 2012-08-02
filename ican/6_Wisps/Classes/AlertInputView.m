//
//  iCan iPhone4 Programming : Project 6 Wisps
//
//  AlertInputView.m
//  Wisps
//
//  Created by DongyoonPark on 1/25/11.
//  Original Game Design by Jess Haskins
//  Copyright Jess Haskins and Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//


#import "AlertInputView.h"

@implementation AlertInputView
@synthesize textField;
@synthesize enteredText;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okayButtonTitle
{
	
    if (self == [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:okayButtonTitle, nil])
    {
        UITextField *theTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 85.0, 260.0, 25.0)]; 
        [theTextField setBackgroundColor:[UIColor whiteColor]]; 
        [self addSubview:theTextField];
        self.textField = theTextField;
        [theTextField release];
    }
    return self;
}
- (void)show
{
    [textField becomeFirstResponder];
    [super show];
}
- (NSString *)enteredText
{
    return textField.text;
}

- (void)dealloc
{
    [textField release];
    [super dealloc];
}
@end
