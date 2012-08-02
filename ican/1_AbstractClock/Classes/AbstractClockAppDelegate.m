//
//  iCan iPhone4 Programming : Project 1 Abstract Clock
//
//  AbstractClockAppDelegate.m
//  AbstractClock
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr All rights reserved.
//

#import "AbstractClockAppDelegate.h"
#import "MainViewController.h"

@implementation AbstractClockAppDelegate


@synthesize window;
@synthesize mainViewController;

@synthesize optionClockMode;
@synthesize option24Hour;
@synthesize optionDateInfo;


+ (void)initialize {
	
    if ([self class] == [AbstractClockAppDelegate class]) {
		
		NSNumber *defaultClockMode = [NSNumber numberWithInt:0]; // 0:Square
		NSNumber *defaultOpacity = [NSNumber numberWithFloat:0.3]; 
		
		NSDictionary *dicOptionDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
										   defaultClockMode, @"keyClockMode", // Geometry 0(Square)
										   defaultOpacity, @"keyOpacity", // Opacity 0.3
										   NO, @"key24Hour",
										   NO, @"keyDateInfo",
										   NO, @"keyAllowAutoLock",
										   nil];
		
		[[NSUserDefaults standardUserDefaults] registerDefaults:dicOptionDefaults];
    }
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
    self.optionClockMode = [[NSUserDefaults standardUserDefaults] integerForKey:@"keyClockMode"];
    self.option24Hour = [[NSUserDefaults standardUserDefaults] boolForKey:@"key24Hour"];
    self.optionDateInfo =[[NSUserDefaults standardUserDefaults] boolForKey:@"keyDateInfo"];
	
    if( [[NSUserDefaults standardUserDefaults] boolForKey:@"keyAllowAutoLock"] ) {
		[UIApplication sharedApplication].idleTimerDisabled = NO;	// Allow AutoLock : YES
    }
    else {
		[UIApplication sharedApplication].idleTimerDisabled = YES;	// Allow AutoLock : NO
    }
	
    [window addSubview:mainViewController.view];
    [window makeKeyAndVisible];
    return YES;
}


- (void)optionSwitch24Hour:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:@"key24Hour"];
    self.option24Hour = sender.on;
}

- (void)optionSwitchDateInfo:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:@"keyDateInfo"];
    self.optionDateInfo = sender.on;
}

- (void)optionSwitchAllowAutolock:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:@"keyAllowAutoLock"];
    [UIApplication sharedApplication].idleTimerDisabled = !sender.on;
}
- (void)applicationWillTerminate:(UIApplication *)application {
    [[NSUserDefaults standardUserDefaults] setInteger:self.optionClockMode forKey:@"keyClockMode"];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}



#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [mainViewController release];
    [window release];
    [super dealloc];
}

@end
