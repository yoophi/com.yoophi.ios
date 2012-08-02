//
//  MoviePlayerViewController.m
//  MoviePlayer
//
//  Created by Eric Freeman on 3/27/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "MoviePlayerViewController.h"

@implementation MoviePlayerViewController

@synthesize player;
// START:synth
@synthesize viewForMovie;
// END:synth

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
// START:viewDidLoad
// START:viewDidLoad1
 - (void)viewDidLoad {
	 [super viewDidLoad];
 
	 self.player = [[MPMoviePlayerController alloc] init];
	 self.player.contentURL = [self movieURL];
	 // END:viewDidLoad1
	 
	 	 // START_HIGHLIGHT	
	 self.player.view.frame = self.viewForMovie.bounds;
	 self.player.view.autoresizingMask = 
		UIViewAutoresizingFlexibleWidth |
		UIViewAutoresizingFlexibleHeight;

	 [self.viewForMovie addSubview:player.view];
	 [self.player play];
	 // END_HIGHLIGHT	

	 // START:viewDidLoad1
 }
 // END:viewDidLoad
// END:viewDidLoad1
 
 // START:movieURL
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
 // END:movieURL


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

@end
