//
//  iCan iPhone4 Programming : Project 7 Beauty of Korea HD
//
//  DetailViewController.m
//  BeautyOfKoreaHD
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import "DetailViewController.h"
#import "RootViewController.h"

#define kScrollObjWidth 708.0
#define kScrollObjHeight 471.0
#define kNumPhotos 20


@implementation DetailViewController

@synthesize toolbar, popoverController;
@synthesize svGallery, svContent, currentMenu;
@synthesize mapView;
@synthesize locationAnnotation;

- (void)setCurrentMenu:(int)newMenu {
    if (currentMenu != newMenu) {
		currentMenu = newMenu;
        
		if(currentMenu == 6)
		{
			[self initMapView];
		}
		else {
			[self initPhotoGallery];
		}
    }
	
    if (popoverController != nil) {
        [popoverController dismissPopoverAnimated:YES];
    }        
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
	
    MKAnnotationView *annView=[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
    annView.canShowCallout = YES;
	annView.image = [UIImage imageNamed:@"annotationIcon.png"];
	
    return annView;
}

- (void)initMapView
{
	mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 708, 768)];
	[self.view addSubview:mapView];
	
	for(UIView *subview in [svGallery subviews]) {
		[subview removeFromSuperview];
	}
	
	for(UIView *subview in [svContent subviews]) {
		[subview removeFromSuperview];
	}
	
	svGallery.hidden = YES;
	svContent.hidden = YES;
	mapView.hidden = NO;
	
	mapView.showsUserLocation = NO;
	mapView.mapType = MKMapTypeStandard;
	mapView.delegate = self;	
	
	
	CLLocationCoordinate2D location;

	// 35.78995,129.331838 : South Korea Gyeongsangbuk-do Gyeongju-si Jinhyeon-dong 15-1
	location.latitude = 35.78995;
	location.longitude = 129.331838;
	
	locationAnnotation = [[LocationAnnotation alloc] initWithCoordinate:location];
	[locationAnnotation setCurrentTitle:@"불국사(佛國寺)"];
	[locationAnnotation setCurrentSubTitle:@"Bulguksa Temple"];
	
	[mapView addAnnotation:locationAnnotation];
	
	// 36.634187,128.68585 : Korea 경상북도 안동시 풍천면 병산리 30
	location.latitude = 36.634187;
	location.longitude = 128.68585;
	
	locationAnnotation = [[LocationAnnotation alloc] initWithCoordinate:location];
	[locationAnnotation setCurrentTitle:@"병산서원(屛山書院)"];
	[locationAnnotation setCurrentSubTitle:@"Byungsan Seowon"];
	
	[mapView addAnnotation:locationAnnotation];
	
	// 36.538778,128.519547
	location.latitude = 36.538778;
	location.longitude = 128.519547;
	
	locationAnnotation = [[LocationAnnotation alloc] initWithCoordinate:location];
	[locationAnnotation setCurrentTitle:@"하회마을"];
	[locationAnnotation setCurrentSubTitle:@"Hahoe Village"];
	
	[mapView addAnnotation:locationAnnotation];
	
	// 36.998963,128.687453 : Korea 경상북도 영주시 부석면 북지리 148 : Buseok-myeon, Yeongju-si, Gyeongsangbuk-do‎South Korea
	location.latitude = 36.998963;
	location.longitude = 128.687453;
	
	locationAnnotation = [[LocationAnnotation alloc] initWithCoordinate:location];
	[locationAnnotation setCurrentTitle:@"부석사(浮石寺)"];
	[locationAnnotation setCurrentSubTitle:@"Busoksa Temple"];
	
	[mapView addAnnotation:locationAnnotation];
	
	
	// 35.835089,129.218992 : Korea 경상북도 경주시 황남동 202-5
	location.latitude = 35.835089;
	location.longitude = 129.218992;
	
	locationAnnotation = [[LocationAnnotation alloc] initWithCoordinate:location];
	[locationAnnotation setCurrentTitle:@"첨성대(瞻星臺)"];
	[locationAnnotation setCurrentSubTitle:@"Cheomseongdae"];
	
	[mapView addAnnotation:locationAnnotation];
	
	location.latitude = 36.256861;
	location.longitude = 128.716908;
	
	// Region and Zoom
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta = 1; // bigger, wider 0.01 proper
	span.longitudeDelta = 1;
	
	region.span = span;
	region.center = location;
	
	[mapView setRegion:region animated:FALSE];
	[mapView regionThatFits:region];
	
	UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
	[self adjustInterfaceWithOrientation:interfaceOrientation];

}


- (void)layoutScrollImages {
    UIImageView *view = nil;
    NSArray *subviews = [svGallery subviews];
	
    CGFloat curXLoc = 0;
    for (view in subviews) {
        if ([view isKindOfClass:[UIImageView class]] && view.tag > 0) {
            CGRect frame = view.frame;
            frame.origin = CGPointMake(curXLoc, 0);
            view.frame = frame;
            curXLoc += (kScrollObjWidth);
        }
    }
	
    [svGallery setContentSize:
	 CGSizeMake((kNumPhotos * kScrollObjWidth), [svGallery bounds].size.height)];
}




- (void)initPhotoGallery {

	svGallery.hidden = NO;
	svContent.hidden = NO;
	mapView.hidden = YES;

	if(svGallery == nil)
	{
		svGallery = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 708, 471)];
	}
	if(svContent == nil)
	{
		svContent = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 708, 225)];
	}
	[self.view addSubview:svGallery];
	[self.view addSubview:svContent];
	
	for(UIView *subview in [svGallery subviews]) {
		[subview removeFromSuperview];
	}
	
	for(UIView *subview in [svContent subviews]) {
		[subview removeFromSuperview];
	}
	[svGallery setContentOffset:CGPointMake(0,0) animated:NO];
	[svContent setContentOffset:CGPointMake(0,0) animated:NO];
	
	// Gallery Scroll View
	svGallery.clipsToBounds = YES;
	svGallery.scrollEnabled = YES;
	svGallery.directionalLockEnabled = YES;
	svGallery.pagingEnabled = YES;
	svGallery.showsHorizontalScrollIndicator = YES;
	svGallery.showsVerticalScrollIndicator = NO;
	
	for (int i = 0; i < kNumPhotos; i++)
	{
		NSString *imageName;
		
		NSLog(@"Loading images = %d",i);
		
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
		imageView.tag = i+1;	// tag our images for later use when we place them in serial fashion
		[svGallery addSubview:imageView];
		[imageView release];
	}
	
	[self layoutScrollImages];	// now place the photos in serial layout within the scrollview
	
	
	// Description Scroll View
	
	UIImageView *imageView;
	
	switch (currentMenu) {
		case 1:
			imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"introByungsan.png"]];
			break;
		case 2:
			imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"introBulguksa.png"]];
			break;
		case 3:
			imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"introBusoksa.png"]];
			break;
		case 4:
			imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"introChumsongdae.png"]];
			break;
		case 5:
			imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"introAndong.png"]];
			break;			
		default:
			break;
	}
	[svContent addSubview:imageView];
	[svContent setContentSize:CGSizeMake(imageView.frame.size.width, imageView.frame.size.height)];
	[svContent setScrollEnabled:YES];
	[imageView release];
	
	UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
	[self adjustInterfaceWithOrientation:interfaceOrientation];
	
}

- (void)adjustInterfaceWithOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	CGSize screenSize = [[UIScreen mainScreen] bounds].size;

	if((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight))
	{
		self.svGallery.center = CGPointMake(354, 235);
		self.svContent.bounds = CGRectMake(0, 0, 708, 245);
		self.svContent.center = CGPointMake(354, screenSize.width-155);
		self.mapView.bounds = CGRectMake(0, 0, 708, 768);
		self.mapView.center = CGPointMake(354, screenSize.width/2);
		self.toolbar.hidden = YES;
	}
	else 
	{
		self.svContent.bounds = CGRectMake(0, 0, 708, 400);
		self.svGallery.center = CGPointMake(screenSize.width/2, 320);
		self.svContent.center = CGPointMake(screenSize.width/2, screenSize.height-250);
		self.mapView.bounds = CGRectMake(0, 0, screenSize.width, screenSize.height-55);
		self.mapView.center = CGPointMake(screenSize.width/2, screenSize.height/2+15);
		self.toolbar.hidden = NO;
	}
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
	[self adjustInterfaceWithOrientation:interfaceOrientation];

}

#pragma mark -
#pragma mark Split view support

- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc {
    
    barButtonItem.title = @"Main Menu";
    NSMutableArray *items = [[toolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = pc;
}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    NSMutableArray *items = [[toolbar items] mutableCopy];
    [items removeObjectAtIndex:0];
    [toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = nil;
}


#pragma mark -
#pragma mark Rotation support

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.popoverController = nil;
}


#pragma mark -
#pragma mark Memory management

/*
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
*/

- (void)dealloc {
	[svGallery release];
	[svContent release];
	[mapView release];

    [popoverController release];
    [toolbar release];
    [super dealloc];
}

@end
