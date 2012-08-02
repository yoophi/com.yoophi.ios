//
//  Bubbles5AppDelegate.h
//  Bubbles5
//
//  Created by Eric Freeman on 3/16/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Bubbles5ViewController;

@interface Bubbles5AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Bubbles5ViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Bubbles5ViewController *viewController;

@end

