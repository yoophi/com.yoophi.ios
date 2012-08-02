//
//  Bubbles1ViewController.m
//  Bubbles1
//
//  Created by Eric Freeman on 3/14/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "Bubbles1ViewController.h"

@implementation Bubbles1ViewController


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



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
// START:viewDidLoad
// START:viewDidLoad2
- (void)viewDidLoad {
	[super viewDidLoad];
	
	UITapGestureRecognizer *tapRecognizer = 
		[[UITapGestureRecognizer alloc] 
		 initWithTarget:self 
		 action:@selector(handleTapFrom:)];
// END:viewDidLoad2
// START_HIGHLIGHT	
	[tapRecognizer setNumberOfTapsRequired:1];
	[self.view addGestureRecognizer:tapRecognizer];
	[tapRecognizer release];
// END_HIGHLIGHT	
// START:viewDidLoad2
}
// END:viewDidLoad2
// END:viewDidLoad


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

/*
 In response to a tap gesture, show the image view appropriately then make it fade out in place.
 */
// START:handleTapFrom
- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer {
	CGPoint location = [recognizer locationInView:self.view];
	
	CGRect rect = CGRectMake(location.x - 40, 
		location.y - 40, 80.0f, 80.0f);
	UIImageView *image = [[UIImageView alloc] 
		initWithFrame:rect];
	[image setImage:[UIImage imageNamed:@"bubble.png"]];
	
	[self.view addSubview:image];
	
	[image release];
}
// END:handleTapFrom


- (void)dealloc {
    [super dealloc];
}

@end
