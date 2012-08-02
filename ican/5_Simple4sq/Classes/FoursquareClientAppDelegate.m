//
//  iCan iPhone4 Programming : Project 5 Simple 4sq
//
//  FoursquareClientAppDelegate.m
//  Simple 4sq
//
//  Created by DeArto20 on 1/25/11.
//  Copyright DeArto20 All rights reserved.
//

#import "FoursquareClientAppDelegate.h"
#import "RootViewController.h"


@implementation FoursquareClientAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
	return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    RootViewController *rootViewController = (RootViewController *) [navigationController topViewController];
    
    [rootViewController refreshTableView];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

