//
//  iCan iPhone4 Programming : Project 4 Simple Twit
//
//  TwitterClientAppDelegate.h
//  Simple Twit
//
//  Created by DeArto20 on 1/25/11.
//  Copyright DeArto20 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterClientAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

