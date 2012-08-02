//
//  iCan iPhone4 Programming : Project 7 Beauty of Korea HD
//
//  BeautyOfKoreaHDAppDelegate.m
//  BeautyOfKoreaHD
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import "BeautyOfKoreaHDAppDelegate.h"


#import "RootViewController.h"
#import "DetailViewController.h"


@implementation BeautyOfKoreaHDAppDelegate

@synthesize window, splitViewController, rootViewController, detailViewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
    
    // Add the split view controller's view to the window and display.
    [window addSubview:splitViewController.view];
    [window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [splitViewController release];
    [window release];
    [super dealloc];
}


@end

