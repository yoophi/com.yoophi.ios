//
//  iCan iPhone4 Programming : Project 4 Simple Twit
//
//  TwitterClientModel.h
//  Simple Twit
//
//  Created by DeArto20 on 1/25/11.
//  Copyright DeArto20 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterClientModel : NSObject {
    // Thread queue
    NSOperationQueue    *operationQueue;
    // User image cache
    NSMutableDictionary *cachedImages;
    // ImageLoadingInfo array
    NSMutableArray      *imageLoadingInfoArray;
}

@property (nonatomic, retain) NSOperationQueue      *operationQueue;
@property (nonatomic, retain) NSMutableDictionary   *cachedImages;
@property (nonatomic, retain) NSMutableArray        *imageLoadingInfoArray;

// Singleton creation method
+ (TwitterClientModel *)sharedInstance;

// Get cached image.
- (UIImage *)cachedImageForURL:(NSString *)url withTarget:(id)target withAction:(SEL)action;

// Called when image loading has been finished.
- (void)didFinishLoadingImageWithResult:(NSDictionary *)result;

@end
