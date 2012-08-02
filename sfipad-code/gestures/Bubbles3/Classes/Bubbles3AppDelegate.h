//
//  Bubbles3AppDelegate.h
//  Bubbles3
//
//  Created by Eric Freeman on 3/16/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Bubbles3ViewController;

@interface Bubbles3AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Bubbles3ViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Bubbles3ViewController *viewController;

@end

