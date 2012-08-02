//
//  iCan iPhone4 Programming : Project 2 Beauty of Korea
//
//  GalleryViewController.m
//  BeautyOfKorea
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import "GalleryViewController.h"

#define kScrollObjHeight 466.0
#define kScrollObjWidth 310.0
#define kNumPhotos 20

@implementation GalleryViewController
@synthesize currentMenu;
@synthesize btnBack;
@synthesize svContent;

-(IBAction)btnBackTouched
{
	[self.navigationController popViewControllerAnimated:YES];  
}

- (void)layoutScrollImages
{
	UIImageView *view = nil;
	NSArray *subviews = [svContent subviews];
	
	CGFloat curXLoc = 0;
	for (view in subviews)
	{
		if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
		{
			CGRect frame = view.frame;
			frame.origin = CGPointMake(curXLoc, 0);
			view.frame = frame;
			
			curXLoc += (kScrollObjWidth);
		}
	}
	
	[svContent setContentSize:CGSizeMake((kNumPhotos * kScrollObjWidth), [svContent bounds].size.height)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	svContent.clipsToBounds = YES;
	svContent.scrollEnabled = YES;
	svContent.directionalLockEnabled = YES;
	svContent.pagingEnabled = YES;
	
	for (int i = 1; i <= kNumPhotos; i++)
	{
		NSString *imageName;
		
		//NSLog(@"Loading images = %d",i);
		
		if (i<10) {
			imageName = [NSString stringWithFormat:@"photos_%d_0%d.JPG", currentMenu, i];
		}
		else {
			imageName = [NSString stringWithFormat:@"photos_%d_%d.JPG", currentMenu, i];
		}
		
		UIImage *image = [UIImage imageNamed:imageName];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		
		// setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
		CGRect rect = imageView.frame;
		rect.size.height = kScrollObjHeight;
		rect.size.width = kScrollObjWidth;
		imageView.frame = rect;
		imageView.tag = i;	// tag our images for later use when we place them in serial fashion
		[svContent addSubview:imageView];
		[imageView release];
	}
	
	[self layoutScrollImages];	// now place the photos in serial layout within the scrollview
	
	
}

- (void)didReceiveMemoryWarning {
	
	[svContent release];
	svContent = nil;
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[btnBack release];
	[svContent release];
    [super dealloc];
}


@end
