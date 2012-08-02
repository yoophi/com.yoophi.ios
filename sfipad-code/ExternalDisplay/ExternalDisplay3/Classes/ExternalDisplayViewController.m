//
//  ExternalDisplayViewController.m
//  ExternalDisplay
//
//  Created by Eric Freeman on 5/5/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "ExternalDisplayViewController.h"
#import "CargoColorChooser.h"

@implementation ExternalDisplayViewController
@synthesize player;

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
	//START:exttest
	externalScreen = [self scanForExternalScreen];
	if (externalScreen) {
		statusLabel.text = @"Connected";	
	}
	//END:exttest
	
		//START:gesture
    [colorView addGestureRecognizer:
	 [[[UITapGestureRecognizer alloc] 
	   initWithTarget:self 
	   action:@selector(colorDidGetTapped)]
	  autorelease]];
	//END:gesture
	[self setupExternalScreen];
	self.player = [[MPMoviePlayerController alloc] init];
	self.player.contentURL = [self movieURL];
	// END:viewDidLoad1
	
	// START_HIGHLIGHT	
	//START:viewDidLoad1
	self.player.view.frame = viewForMovie.bounds;
	self.player.view.autoresizingMask = 
	UIViewAutoresizingFlexibleWidth |
	UIViewAutoresizingFlexibleHeight;
	[viewForMovie addSubview:player.view];
	[self.player play];
	//END:viewDidLoad1
	

}
	//START:setbackground
	//START:setbackground2
-(void)setbackgroundColor:(UIColor *)theColor {
	colorView.backgroundColor = theColor;
	//END:setbackground
	// START_HIGHLIGHT	
	if (externalScreen) {
		[externalView setBackgroundColor:theColor];
	}
				// END_HIGHLIGHT	
		//START:setbackground
}
//END:setbackground
//END:setbackground2


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
		//END:connect2
	//START:connect3
	if (externalScreen == nil) {
		[self setupExternalScreen];
	}
	//END:connect3
	//START:connect2
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

//START:code.gestures.color
-(void) colorDidGetTapped {
    UIPopoverController *popover = [[UIPopoverController alloc] 
									initWithContentViewController:cargoColorChooser];
    popover.popoverContentSize = cargoColorChooser.view.frame.size;
    [popover presentPopoverFromRect:colorView.bounds 
                             inView:colorView 
           permittedArrowDirections:
				UIPopoverArrowDirectionLeft 

                           animated:YES];    
}
//END:code.gestures.color
//START:setup
//START:setup2
-(void)setupExternalScreen {
	if (!externalScreen) {
		externalScreen = [self scanForExternalScreen];	
	}
	
	if (externalScreen) {
		statusLabel.text = @"Connected";
		UIWindow *thisWindow = [[UIWindow alloc] 
			initWithFrame:[externalScreen bounds]];
		[thisWindow setScreen:externalScreen];
		externalView = [[UIView alloc] 
			initWithFrame:[thisWindow bounds]];
		[externalView setBackgroundColor:[UIColor grayColor]];
		[thisWindow addSubview:externalView];
		[thisWindow makeKeyAndVisible];
		//END:setup
		// START_HIGHLIGHT	

		CGRect rect = [externalScreen bounds];
		rect.origin.x = (rect.size.width - 500) / 2;
		rect.origin.y = (rect.size.height - 300) / 2;
		rect.size.width = 500;
		rect.size.height = 300;
		
		UIImageView *imageView = 
		[[UIImageView alloc] initWithFrame:rect];
		[imageView setImage:[UIImage imageNamed:@"logo.png"]];
		imageView.frame = rect;

		[externalView addSubview:imageView];
		// END_HIGHLIGHT	
				//START:setup
	}
}
//END:setup
//END:setup2
//START:switch
//START:switch2
-(IBAction)switchMovie {
	if (player.view.superview == viewForMovie) {
		[player.view removeFromSuperview];
		[externalView addSubview:player.view];
		//END:switch
				// START_HIGHLIGHT	
		[player setFullscreen:YES animated:NO];
				// END_HIGHLIGHT	
		//START:switch
	} else {
		[player.view removeFromSuperview];
		[viewForMovie addSubview:player.view];
		//END:switch
				// START_HIGHLIGHT	
		[player setFullscreen:NO animated:NO];
				// END_HIGHLIGHT	
		//START:switch
	}
}
//END:switch
//END:switch2

-(NSURL *)movieURL
{
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *moviePath = 
	[bundle 
	 pathForResource:@"BigBuckBunny_640x360" 
	 ofType:@"m4v"];
	if (moviePath) {
		return [NSURL fileURLWithPath:moviePath];
	} else {
		return nil;
	}
}



@end
