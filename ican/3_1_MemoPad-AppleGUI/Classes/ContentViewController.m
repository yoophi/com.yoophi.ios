//
//  iCan iPhone4 Programming : Project 3 Memo Pad
//
//  ContentViewController.m
//  MemoPad
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import "ContentViewController.h"
#import "MemoPadAppDelegate.h"
#import "MemoEditViewController.h"


@implementation ContentViewController


@synthesize labelDate;
@synthesize labelTitle;
@synthesize tvContent;
@synthesize mData;
@synthesize btnDelete;
@synthesize btnEdit;
@synthesize sliderFontSize;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (IBAction)changeFontSize:(id)sender
{
	int fontSizeValue = self.sliderFontSize.value;
	
	self.tvContent.font = [UIFont fontWithName:@"Helvetica" size:fontSizeValue];
	
	
}

- (IBAction)deleteMemo:(id)sender {
	
	
	UIAlertView*			alertView;

	alertView = [[UIAlertView alloc] initWithTitle:@"MemoPad" message:nil delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
	[alertView setMessage:@"Do you want to delete the memo?"];
	[alertView show];
	[alertView release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	
	if(buttonIndex == 1) // YES
	{
		
		MemoPadAppDelegate *appDelegate = (MemoPadAppDelegate *)[[UIApplication sharedApplication] delegate];
		
		[appDelegate deleteMemoFromDatabase];
		[self.navigationController popViewControllerAnimated:YES];  
		
	}
	else
	{
		
	}
}

- (IBAction)editMemo:(id)sender {
	
	MemoEditViewController *memoEditViewController = [[MemoEditViewController alloc] initWithNibName:@"MemoEditViewController" bundle:nil];
	
	[self.navigationController presentModalViewController:memoEditViewController animated:YES];
	[memoEditViewController release];
	
	
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	MemoPadAppDelegate *appDelegate = (MemoPadAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.mData = [[appDelegate DBData] objectAtIndex:[appDelegate currentMemoRowIndex]];

	self.labelDate.text = [self.mData mDate];
	self.labelTitle.text = [self.mData mTitle];
	self.tvContent.text = [self.mData mContent];
	self.tvContent.font = [UIFont fontWithName:@"Helvetica" size:12.0];
	
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	MemoPadAppDelegate *appDelegate = (MemoPadAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate readMemoFromDatabase];
	self.mData = [[appDelegate DBData] objectAtIndex:[appDelegate currentMemoRowIndex]];

	self.labelDate.text = [self.mData mDate];
	self.labelTitle.text = [self.mData mTitle];
	self.tvContent.text = [self.mData mContent];
	NSLog(@"reloadData");
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
