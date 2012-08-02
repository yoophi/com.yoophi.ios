//
//  Bubbles1AppDelegate.h
//  Bubbles1
//
//  Created by Eric Freeman on 3/14/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Bubbles1ViewController;

@interface Bubbles1AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Bubbles1ViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Bubbles1ViewController *viewController;

@end

