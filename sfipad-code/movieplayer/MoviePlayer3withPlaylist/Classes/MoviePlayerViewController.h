//
//  MoviePlayer1ViewController.h
//  MoviePlayer1
//
//  Created by Eric Freeman on 3/16/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import "PlaylistController.h"

// START:label
@interface MoviePlayerViewController : UIViewController {
	UIView *viewForMovie;
	MPMoviePlayerController *player;
	// START_HIGHLIGHT	
	UILabel *onScreenDisplayLabel;
	// END_HIGHLIGHT
}

@property (nonatomic, retain) IBOutlet UIView *viewForMovie;
@property (nonatomic, retain) MPMoviePlayerController *player;
// START_HIGHLIGHT	
@property (nonatomic, retain) IBOutlet UILabel *onScreenDisplayLabel;
// END_HIGHLIGHT

- (NSURL *)movieURL;
-(NSURL *)movieURL:(NSString *)filename withFiletype:(NSString *)type;
// START_HIGHLIGHT	
- (IBAction)getInfo:(id)sender;
// END_HIGHLIGHT
@end
// END:label
