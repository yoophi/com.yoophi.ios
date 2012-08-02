    //
//  PlayerControls.m
//  customscroll
//
//  Created by Eric Freeman on 4/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlayerControls.h"


@implementation PlayerControls

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


-(id)initWithPlayer:(MPMoviePlayerController *)thePlayer {
	self = [super init];
	if (self) {
		player = thePlayer;
		sliding = NO;
		[[NSNotificationCenter defaultCenter] 
		 addObserver:self 
		 selector:@selector(playerPlaybackStateDidChange:)
		 name:MPMoviePlayerPlaybackStateDidChangeNotification
		 object:nil];
		
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
		
		
		
		[NSTimer scheduledTimerWithTimeInterval:1.0f 
										 target:self 
									   selector:@selector(updatePlaybackTime:) 
									   userInfo:nil 
										repeats:YES];
		
		
		[[NSNotificationCenter defaultCenter] 
		 addObserver:self 
		 selector:@selector(movieDurationAvailable:)
		 name:MPMovieDurationAvailableNotification
		 object:nil];

		
	}
	return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.alpha = 0.0;
	[playbackSlider setThumbImage:[UIImage imageNamed:@"thumb.png"] forState:UIControlStateNormal];
	UIImage *stetchLeftTrack = [[UIImage imageNamed:@"leftslider.png"]
								stretchableImageWithLeftCapWidth:5.0 topCapHeight:0.0];
	UIImage *stetchRightTrack = [[UIImage imageNamed:@"rightslider.png"]
								 stretchableImageWithLeftCapWidth:5.0 topCapHeight:0.0];
	[playbackSlider setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
	[playbackSlider setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
	
	
	UIView *backView = [[UIView alloc] init];
	backView.frame = player.view.frame;
	[player.view addSubview:backView];
	
	UITapGestureRecognizer *tapRecognizer = 
		[[UITapGestureRecognizer alloc] 
		 initWithTarget:self action:@selector(handleTapFrom:)];
	[tapRecognizer setNumberOfTapsRequired:1];
	[backView addGestureRecognizer:tapRecognizer];
}



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

- (void)updatePlaybackTime:(NSTimer*)theTimer {
	if (!sliding) {
		float playbackTime = player.currentPlaybackTime; 
		float duration = player.duration;
	
		timeLabel.text = [NSString stringWithFormat:
								 @"%.f of %.f secs",
								 playbackTime, duration];
		playbackSlider.value = playbackTime;
	}

}

-(IBAction)handlePlayAndPauseButton:(id)sender {
	NSLog(@"press");

	UIButton *button = (UIButton *)sender;
	if (button.selected) {
		button.selected = NO;
		[player play];
		[self removeControls];
	} else {
		button.selected = YES;
		[player pause];
		[self cancelTimer];
	}
}

-(IBAction)handleFullscreenButton {
	[player setFullscreen:YES animated:YES];

	[player setControlStyle:MPMovieControlStyleDefault];

}



- (void) playerWillExitFullscreen:(NSNotification*)notification {
	[player setControlStyle:MPMovieControlStyleNone];
}

- (void) playerDidEnterFullscreen:(NSNotification*)notification {
	
	NSLog(@"did enter fullscreen");
	//player setControlStyle:MPMovieControlStyleNone];
	UIImageView *backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pragwatermark.png"]];
	//[player.view addSubview:backImg];
	//UIView *myview = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]]; 
	CGRect frame = [[UIScreen mainScreen] applicationFrame];
	frame.origin.y = (frame.size.height / 2) - 25;
	frame.origin.x = frame.size.width - 150;
	frame.size.width = 146;
	frame.size.height = 47;
	backImg.frame = frame;

	//[myview addSubview:backImg];
	NSArray *windows = [[UIApplication sharedApplication] windows];

	UIWindow *moviePlayerWindow = [windows objectAtIndex:0];
	[moviePlayerWindow addSubview:backImg];  
}


- (void) playerPlaybackStateDidChange:(NSNotification*)notification {
	if ([player playbackState] == MPMoviePlaybackStatePaused) {
		playPauseButton.selected = YES;

	} else if ([player playbackState] == MPMoviePlaybackStatePlaying) {
		playPauseButton.selected = NO;
		//[self handleTapFrom:nil];

	}
	
	MPMoviePlayerController* moviePlayerObj = [notification object];
	char *s;
	
	switch ([moviePlayerObj playbackState]) {
		case MPMoviePlaybackStateStopped:			s = "stopped"; break;
		case MPMoviePlaybackStatePlaying:			s = "playing"; break;
		case MPMoviePlaybackStatePaused:			s = "paused"; break;
		case MPMoviePlaybackStateInterrupted:		s = "interrupted"; break;
		case MPMoviePlaybackStateSeekingForward:	s = "seekingForward"; break;
		case MPMoviePlaybackStateSeekingBackward:	s = "seekingBackward"; break;
		default:									s = "???"; break;
	};
	NSLog(@"playerPlaybackStateDidChange - %s, %f @ %f", s, moviePlayerObj.currentPlaybackTime, moviePlayerObj.currentPlaybackRate);
	
}

- (IBAction)playbackSliderMoved:(UISlider *)sender
{
	sliding = YES;
	if (player.playbackState != MPMoviePlaybackStatePaused) {
		[player pause];
	}
	player.currentPlaybackTime = sender.value;

	timeLabel.text = [NSString stringWithFormat:
					  @"%.f of %.f secs",
					  sender.value, player.duration];
	
	[self cancelTimer];
	
}

- (IBAction)playbackSliderDone:(UISlider *)sender
{
	sliding = NO;
	//[playbackSlider setValue: sender.value animated:YES];
	//player.currentPlaybackTime = sender.value;
	//NSLog(@"slider done");
	if (player.playbackState != MPMoviePlaybackStatePlaying) {
		[player play];
	}
}


-(IBAction)handleShareButton {
	
}



// START:duration
- (void) movieDurationAvailable:(NSNotification*)notification {
	float duration = [player duration];
	
	playbackSlider.minimumValue = 0.0;
	playbackSlider.maximumValue = duration;
	
}

- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer {
	[self cancelTimer];

	[UIView	beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.5];
	self.view.alpha = 1.0;
	[UIView commitAnimations];
	controlsTimer = [[NSTimer timerWithTimeInterval:3.0 
											 target:self 
										   selector:@selector(handleControlsTimer:) 
										   userInfo:nil 
											repeats:NO] retain];
	[[NSRunLoop currentRunLoop] addTimer:controlsTimer forMode:NSDefaultRunLoopMode];
}

- (void)handleControlsTimer:(NSTimer *)timer
{
	[self removeControls];
}

-(void)removeControls {
	[UIView	beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.5];
	self.view.alpha = 0.0;
	[UIView commitAnimations];
}

-(void)cancelTimer {
	if (controlsTimer) {
		[controlsTimer invalidate];
		[controlsTimer release];
		controlsTimer = nil;
	}
}


@end
