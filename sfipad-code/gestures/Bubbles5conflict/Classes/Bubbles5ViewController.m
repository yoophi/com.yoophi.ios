//
//  Bubbles1ViewController.m
//  Bubbles1
//
//  Created by Eric Freeman on 3/14/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "Bubbles5ViewController.h"
#import "DeleteGestureRecognizer.h"

@implementation Bubbles5ViewController


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
// START:adddelete
- (void)viewDidLoad {
	[super viewDidLoad];
	// END:adddelete
	[self preparePopSound];
	UITapGestureRecognizer *tapRecognizer = 
	[[UITapGestureRecognizer alloc] 
	 initWithTarget:self 
	 action:@selector(handleTapFrom:)];
	// END:viewDidLoad2

	[self.view addGestureRecognizer:tapRecognizer];
	[tapRecognizer setNumberOfTapsRequired:1];
	[tapRecognizer release];

	

	UISwipeGestureRecognizer *swipeRecognizer = 
	[[UISwipeGestureRecognizer alloc] 
	 initWithTarget:self 
	 action:@selector(handleSwipeFrom:)];
	[self.view addGestureRecognizer:swipeRecognizer];

	// START:viewDidLoad2
	// START:adddelete 
	
	// previous gesture code goes here
	

	DeleteGestureRecognizer *deleteRecognizer = 
		[[DeleteGestureRecognizer alloc] 
			initWithTarget:self 
			action:@selector(handleDeleteFrom:)];
	[self.view addGestureRecognizer:deleteRecognizer];

			// START_HIGHLIGHT	
	[swipeRecognizer requireGestureRecognizerToFail:deleteRecognizer];
	[deleteRecognizer release];
	[swipeRecognizer release];
		// END_HIGHLIGHT
}
// END:viewDidLoad2
// END:viewDidLoad
// END:adddelete

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
	
	UIView *hitView = [self.view hitTest:location withEvent:nil];
	if ([hitView isKindOfClass:[UIImageView class]]) {
		[(UIImageView *)hitView 
		 setImage:[UIImage imageNamed:@"popped.png"]];
		// START_HIGHLIGHT	
		[self makePopSound];
		// END_HIGHLIGHT
	} else {
		//rest of handleTapFrom goes here
		// END:handleTapFrom

		CGRect rect = CGRectMake(location.x - 40, 
								 location.y - 40, 80.0f, 80.0f);
		UIImageView *image = 
		[[UIImageView alloc] initWithFrame:rect];
		[image setImage:[UIImage imageNamed:@"bubble.png"]];
		[image setUserInteractionEnabled: YES];
		

		UIPinchGestureRecognizer *pinchRecognizer = 
		[[UIPinchGestureRecognizer alloc] 
		 initWithTarget:self 
		 action:@selector(handlePinchFrom:)];
		[image addGestureRecognizer:pinchRecognizer];
		[pinchRecognizer release];

		[self.view addSubview:image];
		[image release];
		// START:handleTapFrom
	}
	
}
// END:handleTapFrom

// START:handleSwipeFrom
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:.75];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
	[UIView commitAnimations];
	
	for (UIView *subview in [self.view subviews]) {
		[subview removeFromSuperview];
	}
}
// END:handleSwipeFrom

// START:handlePinchFrom
- (void)handlePinchFrom:(UIPinchGestureRecognizer *)recognizer {
	
	CGAffineTransform transform = CGAffineTransformMakeScale([recognizer scale], [recognizer scale]);
	recognizer.view.transform = transform;
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.65];
	[UIView commitAnimations];
}
// END:handlePinchFrom


// START:handledelete 
- (void)handleDeleteFrom:(DeleteGestureRecognizer *)recognizer {
	if (recognizer.state == UIGestureRecognizerStateRecognized) {
		UIView *viewToDelete = [recognizer viewToDelete];
		[viewToDelete removeFromSuperview];
	}
}
// END:handledelete 
// START:prepare
-(void)preparePopSound {
	NSURL *url = [NSURL fileURLWithPath:
		[NSString stringWithFormat:@"%@/bubble.aif", 
		[[NSBundle mainBundle] resourcePath]]];
	
	NSError *error;
	player = [[AVAudioPlayer alloc] 
			  initWithContentsOfURL:url error:&error];
	player.numberOfLoops = 0;
}
// END:prepare
// START:make
-(void)makePopSound {
	[player play];
}
// END:make

- (void)dealloc {
	[player release];
    [super dealloc];
}

@end


