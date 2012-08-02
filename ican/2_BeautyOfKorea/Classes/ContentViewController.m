//
//  iCan iPhone4 Programming : Project 2 Beauty of Korea
//
//  ContentViewController.m
//  BeautyOfKorea
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import "ContentViewController.h"
#import "GalleryViewController.h"


@implementation ContentViewController
@synthesize currentMenu;
@synthesize btnBack;
@synthesize btnPhotos;
@synthesize svContent;

-(IBAction)btnBackTouched
{
	[self.navigationController popViewControllerAnimated:YES];  
}

-(IBAction)btnPhotosTouched
{
	GalleryViewController *galleryViewController = [[GalleryViewController alloc] initWithNibName:@"GalleryViewController" bundle:nil];
	galleryViewController.currentMenu = self.currentMenu;
	[self.navigationController pushViewController:galleryViewController animated:YES];
	[galleryViewController release];
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
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
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[btnBack release];
	[btnPhotos release];
    [super dealloc];
}


@end
