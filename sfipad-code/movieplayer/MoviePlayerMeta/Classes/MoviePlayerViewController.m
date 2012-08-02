//
//  MoviePlayerViewController.m
//  MoviePlayer
//
//  Created by Eric Freeman on 3/27/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "MoviePlayerViewController.h"

@implementation MoviePlayerViewController
// START:synth
@synthesize player;
@synthesize viewForMovie;
@synthesize onScreenDisplayLabel;
@synthesize myScrollView;
@synthesize keyframeTimes;
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
 
	 keyframeTimes = [[NSMutableArray alloc] init];
	 
	 shoutOutTexts = [[NSArray 
							arrayWithObjects:@"This film\nwas rendered using\ncloud computing ", 
											 @"Look out\nFrank, Rinky\nand Gamera!",
					   nil] retain];
	 shoutOutTimes = [[NSArray 
							  arrayWithObjects:[[NSNumber alloc] initWithInt: 2], 
											   [[NSNumber alloc] initWithInt: 325],
					   nil] retain];
	 
	 
	 
	 self.player = [[MPMoviePlayerController alloc] init];
	 self.player.contentURL = [self movieURL];
	 // END:viewDidLoad1
	 

	 self.player.view.frame = self.viewForMovie.bounds;
	 self.player.view.autoresizingMask = 
		UIViewAutoresizingFlexibleWidth |
		UIViewAutoresizingFlexibleHeight;

	 [self.viewForMovie addSubview:player.view];
	 [self.player play];
	 	 // START_HIGHLIGHT	
	 
	[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
	 	 // END_HIGHLIGHT	

	 // START:viewDidLoad1
	 
	 [self.view addSubview:self.myScrollView];

	 
	 [[NSNotificationCenter defaultCenter] 
	  addObserver:self 
	  selector:@selector(movieDurationAvailable:)
	  name:MPMovieDurationAvailableNotification
	  object:nil];
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

int position = 0;

- (void)timerAction:(NSTimer*)theTimer {
	NSLog(@"hi");
	int count = [shoutOutTimes count];
	NSLog(@"count is at %d", count);

	if (position < count) {
		NSNumber *timeObj = [shoutOutTimes objectAtIndex:position];
		int time = [timeObj intValue];
		NSLog(@"time is at %d", time);
		if (self.player.currentPlaybackTime >= time) {
			CommentView *cview = [[CommentView alloc] 
								  initWithText:[shoutOutTexts objectAtIndex:position]];
			[self.player.view addSubview:cview];
			position++;
			[NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(removeView:) userInfo:cview repeats:NO];
		}
	}
	 
}

- (void)removeView:(NSTimer*)theTimer {
	UIView *view = [theTimer userInfo];
	[view removeFromSuperview];
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

- (void) movieDurationAvailable:(NSNotification*)notification {
	MPMoviePlayerController *moviePlayer = [notification object];
	int duration = [moviePlayer duration];
	
	[[NSNotificationCenter defaultCenter] 
	 addObserver:self 
	 selector:@selector(playerThumbnailImageRequestDidFinish:)
	 name:MPMoviePlayerThumbnailImageRequestDidFinishNotification
	 object:nil];
	
	NSMutableArray *times = [[NSMutableArray alloc] init];
	for(int i = 0; i < 20; i++) {
		[times addObject:[NSNumber numberWithInt:5+i*((duration)/20)]];
	}
	[self.player requestThumbnailImagesAtTimes:times timeOption: MPMovieTimeOptionNearestKeyFrame];
}

int p = 0;
int ll=0;
- (void) playerThumbnailImageRequestDidFinish:(NSNotification*)notification {
	
	
	NSDictionary *userInfo;
    userInfo = [notification userInfo];
	
	NSNumber *timecode;
    timecode = [userInfo objectForKey: @"MPMoviePlayerThumbnailTimeKey"];
	
	
	[keyframeTimes addObject: timecode];
	
	UIImage *image;
    image = [userInfo objectForKey: @"MPMoviePlayerThumbnailImageKey"];
	
	int width = image.size.width;
	int height = image.size.height;
	float newwidth = 75 * ((float)width / (float)height);
	
	
		 self.myScrollView.contentSize = CGSizeMake((newwidth + 2) * 20, 75);
	
	UIImageView *imgv = [[UIImageView alloc] initWithImage:image];
	[imgv setUserInteractionEnabled:YES];
	
	[imgv setFrame:CGRectMake(ll, 0, newwidth, 75.0f)];
	ll+=newwidth + 2;
	

	
	UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] 
												   initWithTarget:self action:@selector(handleTapFrom:)];
	[tapRecognizer setNumberOfTapsRequired:1];
	
	[imgv addGestureRecognizer:tapRecognizer];
	[tapRecognizer release];
	
	
	[myScrollView addSubview:imgv];
	
}

- (void) getInfo:(id)sender
{
	MPMovieMediaTypeMask mask = self.player.movieMediaTypes;
	NSMutableString *mediaTypes = [[NSMutableString alloc] init];
	if (mask == MPMovieMediaTypeMaskNone) {
		[mediaTypes appendString:@"Unknown Media Type"];
	} else {
		if (mask & MPMovieMediaTypeMaskAudio) {
			[mediaTypes appendString:@"Audio"];
		}		
		if (mask & MPMovieMediaTypeMaskVideo) {
			[mediaTypes appendString:@"Video"];
		}
		
	}
	
	MPMovieSourceType type = self.player.movieSourceType;
	NSMutableString *sourceType = [[NSMutableString alloc] initWithString:@""];
	if (type == MPMovieSourceTypeUnknown) {
		[sourceType appendString:@"Source Unknown"];
	} else if (type == MPMovieSourceTypeFile) {
		[sourceType appendString:@"File"];
	} else if (type == MPMovieSourceTypeStreaming) {
		[sourceType appendString:@"Streaming"];
	}			
	
	
	CGSize size = self.player.naturalSize;
	
	onScreenDisplayLabel.text = [NSString stringWithFormat:@"[Type: %@] [Source: %@] [Time: %.1f of %.f secs] [Playback: %.0fx] [Size: %.0fx%.0f]", 
								 mediaTypes,
								 sourceType,
								 self.player.currentPlaybackTime, 
								 self.player.duration,
								 self.player.currentPlaybackRate,
								 size.width,
								 size.height];
}

- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer {
	NSArray *subviews = [myScrollView subviews];
	for (int i = 0; i < 20; i++) {
		if (recognizer.view == [subviews objectAtIndex:i]) {
			NSNumber *num = [keyframeTimes objectAtIndex:i];
			self.player.currentPlaybackTime = [num intValue];
			return;
		}
	}

}

@end
