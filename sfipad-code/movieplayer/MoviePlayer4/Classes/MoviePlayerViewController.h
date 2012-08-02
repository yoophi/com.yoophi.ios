//
//  MoviePlayer1ViewController.h
//  MoviePlayer1
//
//  Created by Eric Freeman on 3/16/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import "ImageViewWithTime.h"

// START:scroll
@interface MoviePlayerViewController : UIViewController {
	UIView *viewForMovie;
	MPMoviePlayerController *player;
	// START_HIGHLIGHT	
	UIScrollView *thumbnailScrollView;
	// END_HIGHLIGHT
	// END:scroll
	// START:scroll
}

@property (nonatomic, retain) IBOutlet UIView *viewForMovie;
@property (nonatomic, retain) MPMoviePlayerController *player;
	// START_HIGHLIGHT	
@property (nonatomic, retain) IBOutlet UIScrollView *thumbnailScrollView;
	// END_HIGHLIGHT	
// END:scroll
// START:scroll
- (NSURL *)movieURL;
// END:scroll
- (void)playerThumbnailImageRequestDidFinish:(NSNotification*)notification;
- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer;
- (ImageViewWithTime *)makeThumbnailImageViewFromImage:(UIImage *)image andTimeCode:(NSNumber *)timecode;
// START:scroll
@end
// END:scroll
