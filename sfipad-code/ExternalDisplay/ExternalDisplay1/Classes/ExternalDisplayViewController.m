//
//  ExternalDisplayViewController.m
//  ExternalDisplay
//
//  Created by Eric Freeman on 5/5/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "ExternalDisplayViewController.h"

@implementation ExternalDisplayViewController

//START:viewDidLoad1
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// START_HIGHLIGHT	
	NSNotificationCenter *notificationCenter = 
	[NSNotificationCenter defaultCenter];
	// END_HIGHLIGHT	
	
		// START_HIGHLIGHT	
	[notificationCenter addObserver:self 
		selector:@selector(screenDidConnectNotification:) 
		name:UIScreenDidConnectNotification 
		object:nil];
	[notificationCenter addObserver:self 
		selector:@selector(screenDidDisconnectNotification:) 
		name:UIScreenDidDisconnectNotification 
		object:nil];
		// END_HIGHLIGHT
	//END:viewDidLoad1
	//START:exttest
	externalScreen = [self scanForExternalScreen];
	if (externalScreen) {
		statusLabel.text = @"Connected";	
	}
	//START:viewDidLoad1
	//END:exttest
}
//END:viewDidLoad1
	//START:connect2
//START:connect
- (void)screenDidConnectNotification:(NSNotification *)notification {
	statusLabel.text = @"Connected";	
	//END:connect
	//START:connect2
			// START_HIGHLIGHT	
	externalScreen = (UIScreen *)[notification object];
			// END_HIGHLIGHT	
	//START:connect
}
//END:connect
	//END:connect2

//START:disconnect
- (void)screenDidDisconnectNotification:(NSNotification *)notification {
	statusLabel.text = @"Not Connected";	
	//END:disconnect
	externalScreen = nil;
	//START:disconnect
}
//END:disconnect


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

//START:scan
-(UIScreen *)scanForExternalScreen {
	NSArray *deviceScreens = [UIScreen screens];
	for (UIScreen *screen in deviceScreens) {
		if (![screen isEqual:[UIScreen mainScreen]]) {
			return screen;
		}
	}
	return nil;
}
//END:scan



@end
