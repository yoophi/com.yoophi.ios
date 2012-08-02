//
//  Bubbles5ViewController.h
//  Bubbles5
//
//  Created by Eric Freeman on 3/16/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface Bubbles5ViewController : UIViewController <UIGestureRecognizerDelegate> {
	AVAudioPlayer *player;
}
-(void)makePopSound;
-(void)preparePopSound;

@end

