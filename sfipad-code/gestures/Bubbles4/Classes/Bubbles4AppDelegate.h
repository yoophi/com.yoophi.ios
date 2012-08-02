//
//  Bubbles4AppDelegate.h
//  Bubbles4
//
//  Created by Eric Freeman on 3/16/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Bubbles4ViewController;

@interface Bubbles4AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Bubbles4ViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Bubbles4ViewController *viewController;

@end

