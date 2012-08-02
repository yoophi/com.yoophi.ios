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
@synthesize keyframeTimes;


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
// START:model

 - (void)viewDidLoad {
	 [super viewDidLoad];
	 
	 shoutOutTexts = [[NSArray 
		arrayWithObjects:
			@"This film\nwas rendered using\ncloud computing ", 
			@"Look out\nFrank, Rinky\nand Gamera!",
			nil] retain];
	 
	 shoutOutTimes = [[NSArray 
		arrayWithObjects:
			[[NSNumber alloc] initWithInt: 2], 
			[[NSNumber alloc] initWithInt: 325],
			nil] retain];
	 

	 
	 // rest of viewDidLoad goes here
	 // END:model
	 position = 0;
	 // START:model2
	 [NSTimer 
	  scheduledTimerWithTimeInterval:1.0f 
	  target:self 
	  selector:@selector(checkShoutouts:) 
	  userInfo:nil 
	  repeats:YES];
	 // END:model2
	 
	 // START_HIGHLIGHT	
	 [[NSNotificationCenter defaultCenter] 
		addObserver:self 
		selector:@selector(movieDurationAvailable:)
		name:MPMovieDurationAvailableNotification
		object:nil];
	 // END_HIGHLIGHT	

 
	 self.player = [[MPMoviePlayerController alloc] init];
	 //self.player.contentURL = [self movieURL];	 

	 self.player.view.frame = self.viewForMovie.bounds;
	 self.player.view.autoresizingMask = 
		UIViewAutoresizingFlexibleWidth |
		UIViewAutoresizingFlexibleHeight;
	 
	 [self.player setControlStyle:MPMovieControlStyleNone];
	 UIImageView *backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"videobackground.png"]];
	// [self.player.backgroundView addSubview:backImg];

	 [self.viewForMovie addSubview:player.view];
	 //[self.player play];
	 
	 PlayerControls *controls = [[PlayerControls alloc] initWithPlayer:self.player];
	 controls.view.alpha = 0.0;
	 CGRect rect = controls.view.frame;
	 rect.origin.y = 170;
	 rect.origin.x = 90;
	 controls.view.frame = rect;
	 [self.player.view  addSubview:controls.view];

	 CGRect rect2 = CGRectMake(64, 600, 640, 350);

	 PlaylistController *playlist = [[PlaylistController alloc] initWithPlayer:self.player];
	 playlist.view.frame = rect2; 
	 [self.view addSubview:playlist.view];
	 
	 // START:model
 }
// END:notify
// END:model


 -(NSURL *)movieURL
 {
	 NSBundle *bundle = [NSBundle mainBundle];
	 NSString *moviePath = 
		[bundle 
		 //pathForResource:@"BigBuckBunny_640x360" 
		 pathForResource:@"elephantsdream-720-h264-st-aac-1"
		 ofType:@"mov"];
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
	return;
	keyframeTimes = [[NSMutableArray alloc] init];
	float duration = [self.player duration];
	
	[[NSNotificationCenter defaultCenter] 
	 addObserver:self 
	 selector:@selector(playerThumbnailImageRequestDidFinish:)
	 name:MPMoviePlayerThumbnailImageRequestDidFinishNotification
	 object:nil];
	
	NSMutableArray *times = [[NSMutableArray alloc] init];
	for(int i = 0; i < 20; i++) {
		float playbackTime = i * duration/20;
		//NSLog(@"%f", playbackTime);
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
		[userInfo objectForKey: @"MPMoviePlayerThumbnailTimeKey"];	
	UIImage *image = 
		[userInfo objectForKey: @"MPMoviePlayerThumbnailImageKey"];

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

// START:checkshout
- (void)checkShoutouts:(NSTimer*)theTimer {
	return;
	if ([self isTimeForNextShoutout]) {
		CommentView *commentView = [[CommentView alloc] 
			initWithText:[shoutOutTexts objectAtIndex:position++]];
		
		[self.player.view addSubview:commentView];
		
		[NSTimer scheduledTimerWithTimeInterval:4.0f 
			target:self 
			selector:@selector(removeView:) 
			userInfo:commentView 
			repeats:NO];
	}
}
// END:checkshout
// START:istime
-(int)isTimeForNextShoutout {
	int count = [shoutOutTimes count];
	if (position < count) {
		int timecode = [[shoutOutTimes 
			  objectAtIndex:position] intValue];
		if (self.player.currentPlaybackTime >= timecode) {
			return YES;
		}
	}
	return NO;
}
// END:istime

// START:removeview
- (void)removeView:(NSTimer*)theTimer {
	UIView *view = [theTimer userInfo];
	[view removeFromSuperview];
}
// END:removeview

@end
