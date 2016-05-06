//
//  ViewController.h
//  Rest
//
//  Created by Pyunghyuk Yoo on 5/6/16.
//  Copyright © 2016 Pyunghyuk Yoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *greetingId;
@property (nonatomic, strong) IBOutlet UILabel *greetingContent;

- (IBAction)fetchGreeting;

- (IBAction)fetchGreetingWithNSURLRequest;
@end

