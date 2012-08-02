//
//  ExternalDisplayAppDelegate.h
//  ExternalDisplay
//
//  Created by Eric Freeman on 5/5/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExternalDisplayViewController;

@interface ExternalDisplayAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ExternalDisplayViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ExternalDisplayViewController *viewController;

@end

