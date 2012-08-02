//
//  iCan iPhone4 Programming : Project 2 Beauty of Korea
//
//  MapViewController.m
//  BeautyOfKorea
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import "MapViewController.h"
#import "ContentViewController.h"

@implementation MapViewController
@synthesize btnBack;	
@synthesize mapView;
@synthesize mapType;
@synthesize locationAnnotation;

-(IBAction)btnBackTouched
{
	[self.navigationController popViewControllerAnimated:YES];  
}

-(IBAction)mapTypeChanged
{
	
	if(mapType.selectedSegmentIndex==0){
		mapView.mapType=MKMapTypeStandard;
	}
	else if (mapType.selectedSegmentIndex==1){
		mapView.mapType=MKMapTypeSatellite;
	}
	else if (mapType.selectedSegmentIndex==2){
		mapView.mapType=MKMapTypeHybrid;
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
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
	
	
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
	
    MKAnnotationView *annView=[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
    annView.canShowCallout = YES;

	UIButton *btnDetailInfo = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    btnDetailInfo.frame = CGRectMake(0, 0, 23, 23);
    btnDetailInfo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    btnDetailInfo.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	
    annView.rightCalloutAccessoryView = btnDetailInfo;
	annView.image = [UIImage imageNamed:@"annotationIcon.png"];
    annView.canShowCallout = YES;
	
    return annView;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	LocationAnnotation *temp = view.annotation;
	
	//NSLog(@"LocationAnnotation = %@",temp.title);
	
 	ContentViewController *contentViewController = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
	if(temp.title == @"병산서원(屛山書院)")
	{
		contentViewController.currentMenu = 1;
	}
	else if(temp.title == @"불국사(佛國寺)")
	{
		contentViewController.currentMenu = 2;
	}
	else if(temp.title == @"부석사(浮石寺)")
	{
		contentViewController.currentMenu = 3;
	}
	else if(temp.title == @"첨성대(瞻星臺)")
	{
		contentViewController.currentMenu = 4;
	}
	else if(temp.title == @"하회마을")
	{
		contentViewController.currentMenu = 5;
	}
	
	[self.navigationController pushViewController:contentViewController animated:YES];
	[contentViewController release];
	
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
	[mapView release];
    [super dealloc];
}


@end
