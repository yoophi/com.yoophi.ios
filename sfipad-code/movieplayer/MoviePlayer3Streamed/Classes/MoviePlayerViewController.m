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
@synthesize onScreenDisplayLabel;

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
	 
// START:stallednotification
	 [[NSNotificationCenter defaultCenter] 
	  addObserver:self 
	  selector:@selector(handleLoadStateDidChange:)
	  name:MPMoviePlayerLoadStateDidChangeNotification
	  object:nil];
// END:stallednotification
	 [self.viewForMovie addSubview:player.view];
	 [self.player play];
 }
// END:notify
// START:movieurl
 -(NSURL *)movieURL
 {
  return [NSURL URLWithString:
    @"http://devimages.apple.com/iphone/samples/bipbop/gear1/prog_index.m3u8"];
 }
// END:movieurl

// START:available
- (void) movieDurationAvailable:(NSNotification*)notification {
	[self getInfo:nil];
}
// END:available

// START:handloadstate
- (void) handleLoadStateDidChange:(NSNotification*)notification {
	MPMovieLoadState state = [player loadState];
	
	if (state & MPMovieLoadStateStalled) {
		[activityView startAnimating];
	} else if (state & MPMovieLoadStatePlaythroughOK) {
		[activityView stopAnimating];
	}
}
// END:handloadstate


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

// START:getinfo1
// START:getinfo2
- (void) getInfo:(id)sender
{
	MPMoviePlayerController *moviePlayer = self.player;
	// END:getinfo1
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
	// END:getinfo2
	// START:getinfo1
	
	float width = moviePlayer.naturalSize.width;
	float height = moviePlayer.naturalSize.height;
	float playbackTime = moviePlayer.currentPlaybackTime;
	float playbackRate = moviePlayer.currentPlaybackRate;
	float duration = moviePlayer.duration;

	onScreenDisplayLabel.text = 
		[NSString stringWithFormat:
			@"[Time: %.1f of %.f secs] \
			  [Playback: %.0fx] \
			  [Size: %.0fx%.0f]", 
				playbackTime, 
				duration,
				playbackRate,
				width,
				height];
	// END:getinfo1
	/*
	 // START:getinfo2
	onScreenDisplayLabel.text = [NSString stringWithFormat:@"[Type: %@] [Source: %@] 
	 [Time: %.1f of %.f secs] [Playback: %.0fx] [Size: %.0fx%.0f]", 
								 mediaTypes,
								 sourceType,
								 self.player.currentPlaybackTime, 
								 self.player.duration,
								 self.player.currentPlaybackRate,
								 size.width,
								 size.height];
	 // END:getinfo2
	 */
	// START:getinfo1
	// START:getinfo2
}
// END:getinfo1
// END:getinfo2


@end
