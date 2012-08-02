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
@synthesize viewForMovie;
@synthesize thumbnailScrollView;


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
// START:notify
 - (void)viewDidLoad {
	 [super viewDidLoad];
	 
	 // START_HIGHLIGHT	
	 [[NSNotificationCenter defaultCenter] 
		addObserver:self 
		selector:@selector(movieDurationAvailable:)
		name:MPMovieDurationAvailableNotification
		object:nil];
	 // END_HIGHLIGHT	

 
	 self.player = [[MPMoviePlayerController alloc] init];
	 self.player.contentURL = [self movieURL];	 

	 self.player.view.frame = self.viewForMovie.bounds;
	 self.player.view.autoresizingMask = 
		UIViewAutoresizingFlexibleWidth |
		UIViewAutoresizingFlexibleHeight;

	 [self.viewForMovie addSubview:player.view];
	 [self.player play];
 }
// END:notify

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

// START:duration
- (void) movieDurationAvailable:(NSNotification*)notification {
	float duration = [self.player duration];
	
	[[NSNotificationCenter defaultCenter] 
	 addObserver:self 
	 selector:@selector(playerThumbnailImageRequestDidFinish:)
	 name:MPMoviePlayerThumbnailImageRequestDidFinishNotification
	 object:nil];
	
	NSMutableArray *times = [[NSMutableArray alloc] init];
	for(int i = 0; i < 20; i++) {
		float playbackTime = i * duration/20;
		[times addObject:[NSNumber numberWithInt:playbackTime]];
	}
	[self.player 
		requestThumbnailImagesAtTimes:times 
		timeOption: MPMovieTimeOptionExact];
}
// END:duration
	// START:taprecognizer
// START:finish
- (void) playerThumbnailImageRequestDidFinish:(NSNotification*)notification {
	NSDictionary *userInfo = [notification userInfo];
	NSNumber *timecode = 
		[userInfo objectForKey: MPMoviePlayerThumbnailTimeKey];	
	UIImage *image = 
		[userInfo objectForKey: MPMoviePlayerThumbnailImageKey];

	ImageViewWithTime *imageView = 
		[self makeThumbnailImageViewFromImage:image andTimeCode:timecode];

	[thumbnailScrollView addSubview:imageView];
	// END:finish

	// START_HIGHLIGHT	
	UITapGestureRecognizer *tapRecognizer = 
		[[UITapGestureRecognizer alloc] 
		initWithTarget:self action:@selector(handleTapFrom:)];
	[tapRecognizer setNumberOfTapsRequired:1];
	
	[imageView addGestureRecognizer:tapRecognizer];
	[tapRecognizer release];
	// END_HIGHLIGHT	
	// START:finish
}
// END:finish
	// END:taprecognizer
// START:tapfrom
- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer {
	ImageViewWithTime *imageView = recognizer.view;
	self.player.currentPlaybackTime = [imageView.time floatValue];
}
// END:tapfrom
// START:makethumb

- (ImageViewWithTime *)makeThumbnailImageViewFromImage:(UIImage *)image andTimeCode:(NSNumber *)timecode {
	float timeslice = self.player.duration / 20.0;
	int pos = [timecode intValue] / (int)timeslice;
	
	float width = 75 * 
	((float)image.size.width / (float)image.size.height);
	
	self.thumbnailScrollView.contentSize = 
	CGSizeMake((width + 2) * 20, 75);
	
	ImageViewWithTime *imageView = 
	[[ImageViewWithTime alloc] initWithImage:image];
	[imageView setUserInteractionEnabled:YES];
	[imageView setFrame:CGRectMake(pos * width + 2, 
								   0, 
								   width, 
								   75.0f)];
	imageView.time = [[NSNumber alloc] initWithFloat:(pos * timeslice)];
	return imageView;
}
// END:makethumb

@end
