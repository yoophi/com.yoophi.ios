//
//  iCan iPhone4 Programming : Project 5 Simple 4sq
//
//  FoursquareClientModel.m
//  Simple 4sq
//
//  Created by DeArto20 on 1/25/11.
//  Copyright DeArto20 All rights reserved.
//

#import "FoursquareClientModel.h"
#import "ImageLoadingOperation.h"


@implementation FoursquareClientModel

@synthesize operationQueue;
@synthesize cachedImages;
@synthesize imageLoadingInfoArray;

- (id)init {
    if (self = [super init]) {
        self.operationQueue        = [[[NSOperationQueue alloc] init] autorelease];
        [self.operationQueue setMaxConcurrentOperationCount:10];
        self.cachedImages          = [NSMutableDictionary dictionaryWithCapacity:0];
        self.imageLoadingInfoArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return self;
}

+ (FoursquareClientModel *)sharedInstance {
    static FoursquareClientModel   *instance = nil;
    
    @synchronized (self) {
        if (instance == nil) {
            instance = [[FoursquareClientModel alloc] init];
        }
    }
    
    return instance;
}

- (UIImage *)cachedImageForURL:(NSString *)url withTarget:(id)target withAction:(SEL)action {
    id cachedObject = nil;
    
    if (url == nil) {
        return nil;
    }
    
    cachedObject = [self.cachedImages objectForKey:url];
    
    if ([cachedObject isKindOfClass:[NSData class]]) {
        cachedObject = [UIImage imageWithData:cachedObject];
    }
    
    if (cachedObject == nil) {
        // Store arguments (target, action and url) for notification.
        ImageLoadingInfo *info = [[ImageLoadingInfo alloc] init];
        
        info.target = target;
        info.action = action;
        info.url    = url;
        [self.imageLoadingInfoArray addObject:info];
        [info release];
        
        // Set temporal object during operation.
        [self.cachedImages setObject:@"Loading..." forKey:url];
        
        // Create new loading operation.
        ImageLoadingOperation *operation = [[ImageLoadingOperation alloc] initWithImageURL:url
                                                                          target:self
                                                                          action:@selector(didFinishLoadingImageWithResult:)];
        
        [self.operationQueue addOperation:operation];
        [operation release];
    }
    
    else if (![cachedObject isKindOfClass:[UIImage class]]) {
        // Already loading specified image.
        cachedObject = nil;
    }
    
    else {
        ;
    }
    
    return cachedObject;
}

- (void)didFinishLoadingImageWithResult:(NSDictionary *)result {
    if (result == nil) {
        return;
    }
    
    NSString *url   = [result objectForKey:[ImageLoadingOperation urlResultKey]];
    UIImage  *image = [result objectForKey:[ImageLoadingOperation imageResultKey]];
    
    // Store the image in the cache.
    [self.cachedImages setObject:UIImagePNGRepresentation(image) forKey:url];
    
    // Notify that the operation has finished.
    NSEnumerator     *enumerator = [self.imageLoadingInfoArray objectEnumerator];
    ImageLoadingInfo *info       = nil;
    
    while (info = [enumerator nextObject]) {
        if ([[info url] isEqual:url]) {
            if ([info target] && [info action] && [[info target] respondsToSelector:[info action]]) {
                [[info target] performSelector:[info action]];
                [self.imageLoadingInfoArray removeObject:info];
                break;
            }
        }
    }
}

- (void)dealloc {
    if (imageLoadingInfoArray) {
        [imageLoadingInfoArray release];
    }
    
    if (cachedImages) {
        [cachedImages release];
    }
    
    if (operationQueue) {
        [operationQueue release];
    }
    
    [super dealloc];
}

@end
