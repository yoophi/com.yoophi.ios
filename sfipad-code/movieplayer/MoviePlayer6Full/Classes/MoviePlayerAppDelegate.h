//
//  MoviePlayerAppDelegate.h
//  MoviePlayer
//
//  Created by Eric Freeman on 3/27/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MoviePlayerViewController;

@interface MoviePlayerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MoviePlayerViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MoviePlayerViewController *viewController;

@end

