//
//  iCan iPhone4 Programming : Project 7 Beauty of Korea HD
//
//  RootViewController.m
//  BeautyOfKoreaHD
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"


@implementation RootViewController

@synthesize detailViewController;
@synthesize btnMenu1;
@synthesize btnMenu2;
@synthesize btnMenu3;
@synthesize btnMenu4;
@synthesize btnMenu5;
@synthesize btnMenu6;
@synthesize ivBackground;
@synthesize ivTitle;

-(IBAction)btnMenu1Touched
{
	detailViewController.currentMenu = 1;
}

-(IBAction)btnMenu2Touched
{
	detailViewController.currentMenu = 2;
}

-(IBAction)btnMenu3Touched
{
	detailViewController.currentMenu = 3;
}

-(IBAction)btnMenu4Touched
{
	detailViewController.currentMenu = 4;
}

-(IBAction)btnMenu5Touched
{
	detailViewController.currentMenu = 5;
}

-(IBAction)btnMenu6Touched
{
	detailViewController.currentMenu = 6;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    detailViewController.currentMenu = 1;
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}



#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [detailViewController release];
    [super dealloc];
}


@end

