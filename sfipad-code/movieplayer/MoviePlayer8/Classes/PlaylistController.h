//
//  PlaylistController.h
//  MoviePlayer
//
//  Created by Eric Freeman on 4/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerController.h>



@interface PlaylistController : UITableViewController {
	NSArray *items;
	MPMoviePlayerController *player;
}
-(id)initWithPlayer:(MPMoviePlayerController *)thePlayer;
-(void) playerPlaybackDidFinish:(NSNotification*)notification;
-(NSURL *)movieURL:(NSString *)filename withFiletype:(NSString *)type;
@end
