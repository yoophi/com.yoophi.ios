//
//  MoviePlayer1ViewController.h
//  MoviePlayer1
//
//  Created by Eric Freeman on 3/16/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

// START:import
#import <UIKit/UIKit.h>
// START_HIGHLIGHT	
#import <MediaPlayer/MPMoviePlayerController.h>
#import "CommentView.h"
// END_HIGHLIGHT	


// START:def
// START:wiring
@interface MoviePlayerViewController : UIViewController {
	UIView *viewForMovie;
	// END:wiring
	// START_HIGHLIGHT	
	MPMoviePlayerController *player;
	// END_HIGHLIGHT
	// START:wiring
	UILabel *onScreenDisplayLabel;
	UIScrollView *myScrollView;
	NSMutableArray *keyframeTimes;
	NSArray *shoutOutTexts;
	NSArray *shoutOutTimes;
}

@property (nonatomic, retain) IBOutlet UIView *viewForMovie;
// END:wiring
// START_HIGHLIGHT
@property (nonatomic, retain) MPMoviePlayerController *player;
// END_HIGHLIGHT
@property (nonatomic, retain) IBOutlet UILabel *onScreenDisplayLabel;

@property (nonatomic, retain) IBOutlet UIScrollView *myScrollView;
@property (nonatomic, retain) NSMutableArray *keyframeTimes;


// START_HIGHLIGHT
-(NSURL *)movieURL;
- (void)timerAction:(NSTimer*)theTimer;
- (void) playerThumbnailImageRequestDidFinish:(NSNotification*)notification;
- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer;
- (IBAction) getInfo:(id)sender;
- (void)removeView:(NSTimer*)theTimer;

// END_HIGHLIGHT
// START:wiring
@end
// END:def
// END:wiring
// END:import
