//
//  iCan iPhone4 Programming : Project 5 Simple 4sq
//
//  ImageLoadingOperation.h
//  Simple 4sq
//
//  Created by DeArto20 on 1/25/11.
//  Copyright DeArto20 All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImageLoadingInfo : NSObject {
    NSString    *url;
    id           target;
    SEL          action;
}

@property (retain) NSString *url;
@property (retain) id        target;
@property (assign) SEL       action;

@end

@interface ImageLoadingOperation : NSOperation {
    NSString    *url;
    id           target;
    SEL          action;
}

@property (retain) NSString *url;
@property (retain) id        target;
@property (assign) SEL       action;

+ (NSString *)imageResultKey;
+ (NSString *)urlResultKey;
- (id)        initWithImageURL:(NSString *)theUrl target:(id)theTarget action:(SEL)theAction;

@end
