//
//  PlaylistController.h
//  MoviePlayer
//
//  Created by Eric Freeman on 4/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerController.h>
@class MoviePlayerViewController;

// START:properties
@interface PlaylistController : UITableViewController {
	NSArray *items;
	MoviePlayerViewController *playerController;
}
// END:properties
-(id)initWithPlayer:(MoviePlayerViewController *)thePlayer;
-(void) playerPlaybackDidFinish:(NSNotification*)notification;
@end
