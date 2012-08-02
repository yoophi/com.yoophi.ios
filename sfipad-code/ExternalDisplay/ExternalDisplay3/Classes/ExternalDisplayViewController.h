//
//  ExternalDisplayViewController.h
//  ExternalDisplay
//
//  Created by Eric Freeman on 5/5/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerController.h>


@class CargoColorChooser;

@interface ExternalDisplayViewController : UIViewController {
	IBOutlet UILabel *statusLabel;
	UIScreen *externalScreen;
	IBOutlet UIView *colorView;
    IBOutlet CargoColorChooser *cargoColorChooser;
	UIView *externalView;
	IBOutlet UIButton *switchButton;
	MPMoviePlayerController *player;
	IBOutlet UIView *viewForMovie;
}
@property (nonatomic, retain) MPMoviePlayerController *player;

-(UIScreen *)scanForExternalScreen;
-(void)setupExternalScreen;
-(NSURL *)movieURL;
-(IBAction)switchMovie;
@end


