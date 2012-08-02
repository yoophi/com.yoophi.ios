//
//  iCan iPhone4 Programming : Project 5 Simple 4sq
//
//  ImageLoadingOperation.m
//  Simple 4sq
//
//  Created by DeArto20 on 1/25/11.
//  Copyright DeArto20 All rights reserved.
//

#import "ImageLoadingOperation.h"


@implementation ImageLoadingInfo

@synthesize url;
@synthesize target;
@synthesize action;

- (void)dealloc {    
    if (target) {
        [target release];
    }
    
    if (url) {
        [url release];
    }
    
    [super dealloc];
}

@end

@implementation ImageLoadingOperation

@synthesize url;
@synthesize target;
@synthesize action;

+ (NSString *)imageResultKey {
    return @"image";
}

+ (NSString *)urlResultKey {
    return @"url";
}

- (id)initWithImageURL:(NSString *)theUrl target:(id)theTarget action:(SEL)theAction {
    self = [super init];
    
    if (self) {
        self.url    = theUrl;
        self.target = theTarget;
        self.action = theAction;
    }
    
    return self;
}

- (void)dealloc {
    if (target) {
        [target release];
    }
    
    if (url) {
        [url release];
    }
    
    [super dealloc];
}

- (void)main {
    // Fetch the data from the specified url.
    NSData  *data  = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.url]];
    UIImage *image = [[UIImage alloc] initWithData:data];
    
    // Send the result back to the main thread.
    NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:image, [ImageLoadingOperation imageResultKey], 
                                                                      self.url, [ImageLoadingOperation urlResultKey], 
                                                                      nil];
    
    [self.target performSelectorOnMainThread:self.action withObject:result waitUntilDone:NO];
    
    [image release];
    [data  release];
}

@end
