//
//  iCan iPhone4 Programming : Project 3 Memo Pad
//
//  MemoWriteViewController.m
//  MemoPad
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import "MemoWriteViewController.h"
#import "MemoPadAppDelegate.h"

@implementation MemoWriteViewController

@synthesize tfTitle;
@synthesize tvContent;
@synthesize navigationBar;
@synthesize btnSave;
@synthesize btnCancel;


- (IBAction)saveMemo:(id)sender
{
	MemoPadAppDelegate *appDelegate = (MemoPadAppDelegate *)[[UIApplication sharedApplication] delegate];

	[appDelegate writeMemoToDatabaseWithTitle:[self.tfTitle text] Content:[self.tvContent text]];

	[self dismissModalViewControllerAnimated:YES];
}
- (IBAction)cancelMemo:(id)sender
{
	
	[self dismissModalViewControllerAnimated:YES];

}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.tvContent.font = [UIFont fontWithName:@"Helvetica" size:12.0];
}

- (void)viewDidAppear:(BOOL)animated {
    // This line makes textView to have the focus right after imagepicker has been closed.
    [self.tfTitle becomeFirstResponder];
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
