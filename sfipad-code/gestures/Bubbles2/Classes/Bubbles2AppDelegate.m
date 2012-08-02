//
//  Bubbles2AppDelegate.m
//  Bubbles2
//
//  Created by Eric Freeman on 3/15/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "Bubbles2AppDelegate.h"
#import "Bubbles2ViewController.h"

@implementation Bubbles2AppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];

	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
