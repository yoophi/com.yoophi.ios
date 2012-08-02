//
//  PlaybackViewController.h
//  MoviePlayer
//
//  Created by Eric Freeman on 4/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerController.h>

	// START:ibos
@interface PlaybackViewController : UIViewController {
	IBOutlet UISlider *playbackSlider;
	IBOutlet UIButton *playPauseButton;
	IBOutlet UIButton *fullscreenButton;
	IBOutlet UILabel *statusLabel;
	IBOutlet UILabel *timeLabel;
	// END:ibos
	// START:playerproperty
	MPMoviePlayerController *player;
		// END:playerproperty
	NSTimer *controlsTimer;
	BOOL sliding;
	NSTimer *playbackTimer;
	// START:ibos
}
// END:ibos
// START:initinheader
-(id)initWithPlayer:(MPMoviePlayerController *)player;
// END:initinheader
// START:handleplaypause
-(IBAction)handlePlayAndPauseButton:(id)sender;
// END:handleplaypause
// START:updatetime
-(void)updatePlaybackTime:(NSTimer*)theTimer;
// END:updatetime
// START:fullscreen
-(IBAction)handleFullscreenButton;
// END:fullscreen
// START:exitfullscreen
-(void) playerWillExitFullscreen:(NSNotification*)notification;
- (void) playerDidEnterFullscreen:(NSNotification*)notification;
// END:exitfullscreen
-(IBAction)handleShareButton;
// START:slider
-(IBAction)playbackSliderMoved:(UISlider *)sender;
-(IBAction)playbackSliderDone:(UISlider *)sender;
// END:slider
// START:statechange
-(void)playerPlaybackStateDidChange:(NSNotification*)notification;
// END:statechange

// START:timers
-(void)handleControlsTimer:(NSTimer *)timer;
-(void)removeControls;
-(void)setControlsTimer;
// END:timers
@end
