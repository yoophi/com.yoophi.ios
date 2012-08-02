    //
//  PlaybackViewController.m
//  MoviePlayer
//
//  Created by Eric Freeman on 4/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlaybackViewController.h"


@implementation PlaybackViewController

// START:initWithPlayer1
// START:initWithPlayer2
-(id)initWithPlayer:(MPMoviePlayerController *)thePlayer {
	self = [super init];
	if (nil != self) {
		player = thePlayer;
				// END:initWithPlayer1
		// START_HIGHLIGHT	
		[[NSNotificationCenter defaultCenter] 
		 addObserver:self 
		 selector:@selector(movieDurationAvailable:)
		 name:MPMovieDurationAvailableNotification
		 object:nil];
		// END_HIGHLIGHT	
		// END:initWithPlayer2
		
		// START:statechange
		[[NSNotificationCenter defaultCenter] 
		 addObserver:self 
		 selector:@selector(playerPlaybackStateDidChange:)
		 name:MPMoviePlayerPlaybackStateDidChangeNotification
		 object:nil];
		// END:statechange

		// START:fullscreennotify
		[[NSNotificationCenter defaultCenter] 
		 addObserver:self 
		 selector:@selector(playerWillExitFullscreen:)
		 name:MPMoviePlayerWillExitFullscreenNotification
		 object:nil];
		
		[[NSNotificationCenter defaultCenter] 
		 addObserver:self 
		 selector:@selector(playerDidEnterFullscreen:)
		 name:MPMoviePlayerDidEnterFullscreenNotification
		 object:nil];
		// END:fullscreennotify

		
		// START:initWithPlayer1
		// START:initWithPlayer2
	}
	return self;
}
// END:initWithPlayer1
// END:initWithPlayer2

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// START:viewdidload1
	[playbackSlider 
	 setThumbImage:[UIImage imageNamed:@"thumb.png"] 
	 forState:UIControlStateNormal];
	UIImage *stetchLeftTrack = 
		[[UIImage imageNamed:@"leftslider.png"]
		 stretchableImageWithLeftCapWidth:5.0 
		 topCapHeight:0.0];
	UIImage *stetchRightTrack = 
		[[UIImage imageNamed:@"rightslider.png"]
		 stretchableImageWithLeftCapWidth:5.0 
		 topCapHeight:0.0];
	[playbackSlider setMinimumTrackImage:stetchLeftTrack 
		forState:UIControlStateNormal];
	[playbackSlider setMaximumTrackImage:stetchRightTrack 
		forState:UIControlStateNormal];
	// END:viewdidload1
	
	// START:viewdidload2
	UIView *touchView = [[[UIView alloc] init] autorelease];
	touchView.frame = player.view.frame;
	[player.view addSubview:touchView];
	// END:viewdidload2
	
	// START:viewdidload3
	UITapGestureRecognizer *tapRecognizer = 
	[[[UITapGestureRecognizer alloc] 
		initWithTarget:self action:@selector(handleTapFrom:)]
	 autorelease];
	[tapRecognizer setNumberOfTapsRequired:1];
	[touchView addGestureRecognizer:tapRecognizer];
	// END:viewdidload3
	// START:setalpha
	self.view.alpha = 0.0;
	// END:setalpha
	// START:viewdidload1
}
// END:viewdidload1



/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
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

// START:handleplaypause2
// START:handleplaypause
-(IBAction)handlePlayAndPauseButton:(id)sender {	
	UIButton *button = (UIButton *)sender;
	if (button.selected) {
		button.selected = NO;
		[player play];
		// END:handleplaypause
		// START_HIGHLIGHT	
		[self setControlsTimer];
		// END_HIGHLIGHT	
		// START:handleplaypause
	} else {
		button.selected = YES;
		[player pause];
		// END:handleplaypause
		// START_HIGHLIGHT	
		[controlsTimer invalidate];
		[controlsTimer release];
		controlsTimer = nil;
		// END_HIGHLIGHT	
		// START:handleplaypause
	}
}
// END:handleplaypause
// END:handleplaypause2


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


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



// START:updateplayback
// START:updateplayback2
// START:updateplayback3
- (void)updatePlaybackTime:(NSTimer*)theTimer {
	// END:updateplayback
	// START_HIGHLIGHT	
	// END:updateplayback2
	if (!sliding) {  
		// START:updateplayback2
		// END_HIGHLIGHT	
		// START:updateplayback
		float playbackTime = player.currentPlaybackTime;
		float duration = player.duration;
		
		timeLabel.text = [NSString stringWithFormat:
						  @"%.f of %.f secs",
						  playbackTime, 
						  duration];
		// END:updateplayback
		// START_HIGHLIGHT	
		playbackSlider.value = playbackTime;
		// END_HIGHLIGHT	
		// END:updateplayback2
	}
	// START:updateplayback
	// START:updateplayback2
}
// END:updateplayback
// END:updateplayback2
// END:updateplayback3

// START:duration
// START:duration2
- (void) movieDurationAvailable:(NSNotification*)notification {
	if (playbackTimer == nil) {
		playbackTimer = 
			[NSTimer scheduledTimerWithTimeInterval:1.0f 
				target:self 
				selector:@selector(updatePlaybackTime:) 
				userInfo:nil 
				repeats:YES];
	}
	// END:duration
	// START_HIGHLIGHT	
	playbackSlider.minimumValue = 0.0;
	playbackSlider.maximumValue = [player duration];
	// END_HIGHLIGHT	
	// START:duration
}
// END:duration
// END:duration2

// START:slidermoved
- (IBAction)playbackSliderMoved:(UISlider *)sender {
	if (player.playbackState != MPMoviePlaybackStatePaused) {
		[player pause];
	}
	player.currentPlaybackTime = sender.value;
	
	timeLabel.text = [NSString stringWithFormat:
					  @"%.f of %.f secs",
					  sender.value, player.duration];
	// END:slidermoved
	[self setControlsTimer];
	// START:slidermoved
	sliding = YES;
}
// END:slidermoved

// START:sliderdone
- (IBAction)playbackSliderDone:(UISlider *)sender
{
	sliding = NO;

	if (player.playbackState != MPMoviePlaybackStatePlaying) {
		[player play];
	}
}
// END:sliderdone

// START:handletap
- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer {	
	[UIView	beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.5];
	self.view.alpha = 1.0;
	[UIView commitAnimations];
	[self setControlsTimer];
}
// END:handletap

// START:handlecontrolstimer
- (void)handleControlsTimer:(NSTimer *)timer
{
	[self removeControls];
	[controlsTimer release];
	controlsTimer = nil;
}
// END:handlecontrolstimer


// START:removecontrols
-(void)removeControls {
	[UIView	beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.5];
	self.view.alpha = 0.0;
	[UIView commitAnimations];
}
// END:removecontrols

// START:canceltimer
-(void)setControlsTimer {
	if (controlsTimer) {
		[controlsTimer invalidate];
		[controlsTimer release];
		controlsTimer = nil;
	}
	controlsTimer = [[NSTimer timerWithTimeInterval:4.0 
		target:self 
		selector:@selector(handleControlsTimer:) 
		userInfo:nil 
		repeats:NO] retain];
	[[NSRunLoop currentRunLoop] 
	 addTimer:controlsTimer 
	 forMode:NSDefaultRunLoopMode];
}
// END:canceltimer

// START:statechangemethod
- (void) playerPlaybackStateDidChange:(NSNotification*)notification {
	if ([player playbackState] 
			== MPMoviePlaybackStatePaused) {
		statusLabel.text = @"Paused...";
		playPauseButton.selected = YES;
		
	} else if ([player playbackState] 
			== MPMoviePlaybackStatePlaying) {
		statusLabel.text = @"Playing";
		playPauseButton.selected = NO;
	} else if ([player playbackState] 
			== MPMoviePlaybackStateStopped) {
		statusLabel.text = @"Stopped";
		playPauseButton.selected = NO;
	}
}
// END:statechangemethod

// START:exitfullscreen
- (void) playerWillExitFullscreen:(NSNotification*)notification {
	player.controlStyle = MPMovieControlStyleNone;
}
// END:exitfullscreen
// START:enterfullscreen
- (void) playerDidEnterFullscreen:(NSNotification*)notification {
	player.controlStyle = MPMovieControlStyleDefault;
}
// END:enterfullscreen
// START:handlefullscreen
-(IBAction)handleFullscreenButton {
	[player setFullscreen:YES animated:YES];
}
// END:handlefullscreen

@end
