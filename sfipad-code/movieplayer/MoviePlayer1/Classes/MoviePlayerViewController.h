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
}

@property (nonatomic, retain) IBOutlet UIView *viewForMovie;
// END:wiring
// START_HIGHLIGHT
@property (nonatomic, retain) MPMoviePlayerController *player;
// END_HIGHLIGHT

// START_HIGHLIGHT
-(NSURL *)movieURL;
// END_HIGHLIGHT
// START:wiring
@end
// END:def
// END:wiring
// END:import
