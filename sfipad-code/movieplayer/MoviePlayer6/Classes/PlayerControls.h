//
//  PlayerControls.h
//  customscroll
//
//  Created by Eric Freeman on 4/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerController.h>

// START:ibos
@interface PlayerControls : UIViewController {
	IBOutlet UISlider *playbackSlider;
	IBOutlet UIButton *playPauseButton;
	IBOutlet UIButton *fullscreenButton;
	IBOutlet UILabel *statusLabel;
	IBOutlet UILabel *timeLabel;
	IBOutlet UILabel *chapterLabel;
// END:ibos
	MPMoviePlayerController *player;
	NSTimer *controlsTimer;
	BOOL sliding;
// START:ibos
}
// END:ibos

-(id)initWithPlayer:(MPMoviePlayerController *)player;
-(void)updatePlaybackTime:(NSTimer*)theTimer;
-(IBAction)handlePlayAndPauseButton:(id)sender;
-(IBAction)handleFullscreenButton;
-(IBAction)handleShareButton;
- (IBAction)playbackSliderMoved:(UISlider *)sender;
- (IBAction)playbackSliderDone:(UISlider *)sender;
-(void)playerPlaybackStateDidChange:(NSNotification*)notification;
- (void) playerWillExitFullscreen:(NSNotification*)notification;
-(void)handleControlsTimer:(NSTimer *)timer;
-(void)removeControls;
-(void)cancelTimer;

- (void) playerDidEnterFullscreen:(NSNotification*)notification;
@end
