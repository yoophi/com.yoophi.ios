//
//  Bubbles2AppDelegate.h
//  Bubbles2
//
//  Created by Eric Freeman on 3/15/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Bubbles2ViewController;

@interface Bubbles2AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Bubbles2ViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Bubbles2ViewController *viewController;

@end

