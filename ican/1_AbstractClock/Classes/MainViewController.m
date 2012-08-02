//
//  iCan iPhone4 Programming : Project 1 Abstract Clock
//
//  MainViewController.m
//  AbstractClock
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr All rights reserved.
//

#import "MainViewController.h"
#import "AbstractClockAppDelegate.h"

#define RANDOM_INT(MIN, MAX) ((MIN) + arc4random() % ((MAX+1) - (MIN)))

@implementation MainViewController

@synthesize arraySquareImages;
@synthesize arrayCircleImages;
@synthesize timer;
@synthesize lblTimeDigit;
@synthesize lblAMPM;
@synthesize lblDateInfo;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
	
    arrayCircleImages = [[NSMutableArray alloc] initWithCapacity:10];
    arraySquareImages = [[NSMutableArray alloc] initWithCapacity:10];
	
	for( int i=0 ; i<10 ; i++) {
		CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.1, 0.1);
		
		// Init Square Images
		UIImage *imageSquare = [UIImage imageNamed:[NSString stringWithFormat:@"PatchSquare%d.png",i]];
		UIImageView *ivSquare = [[UIImageView alloc] initWithImage:imageSquare];
		[self.view addSubview:ivSquare];
		ivSquare.alpha = 0;
		ivSquare.center = CGPointMake(RANDOM_INT(0,320), RANDOM_INT(0,480));
		ivSquare.transform = scaleTransform;
		[arraySquareImages addObject:ivSquare];
		[ivSquare release];
		
		// Init Circle Images
		UIImage *imageCircle = [UIImage imageNamed:[NSString stringWithFormat:@"PatchCircle%d.png",i]];
		UIImageView *ivCircle = [[UIImageView alloc] initWithImage:imageCircle];
		[self.view addSubview:ivCircle];
		ivCircle.alpha = 0;
		ivCircle.center = CGPointMake(RANDOM_INT(0,320), RANDOM_INT(0,480));
		ivCircle.transform = scaleTransform;
		[arrayCircleImages addObject:ivCircle];
		[ivCircle release];
	}
	
	CGSize screenSize = [[UIScreen mainScreen] bounds].size;
	
	lblTimeDigit = [[UILabel alloc] initWithFrame:CGRectMake(screenSize.width-220, 10, 200, 50)];
	[self.view addSubview:lblTimeDigit];
	[lblTimeDigit release];
	lblTimeDigit.backgroundColor = [UIColor clearColor];
	lblTimeDigit.textColor = [UIColor whiteColor];
	lblTimeDigit.textAlignment = UITextAlignmentRight;
	lblTimeDigit.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.70];
	lblTimeDigit.shadowOffset = CGSizeMake(0, -1.0);	
	[lblTimeDigit setFont:[UIFont fontWithName:@"ArialRoundedMTBold" size:24.0]];
	
	
	lblAMPM = [[UILabel alloc] initWithFrame:CGRectMake(screenSize.width-145, 20, 20, 20)];
	[self.view addSubview:lblAMPM];
	[lblAMPM release];
	lblAMPM.backgroundColor = [UIColor clearColor];
	lblAMPM.textColor = [UIColor whiteColor];
	lblAMPM.textAlignment = UITextAlignmentRight;
	lblAMPM.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.70];
	lblAMPM.shadowOffset = CGSizeMake(0, -1.0);
	[lblAMPM setFont:[UIFont fontWithName:@"ArialRoundedMTBold" size:8.0]];
	
	lblDateInfo = [[UILabel alloc] initWithFrame:CGRectMake(screenSize.width-180, 45, 220, 20)];
	[self.view addSubview:lblDateInfo];
	[lblDateInfo release];
	lblDateInfo.backgroundColor = [UIColor clearColor];
	lblDateInfo.textColor = [UIColor whiteColor];
	lblDateInfo.textAlignment = UITextAlignmentRight;
	lblDateInfo.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.70];
	lblDateInfo.shadowOffset = CGSizeMake(0, -1.0);	
	[lblDateInfo setFont:[UIFont fontWithName:@"ArialRoundedMTBold" size:9.0]];
	
	self.timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}

- (void)updateTime {
	
	AbstractClockAppDelegate *appDelegate = (AbstractClockAppDelegate *)[[UIApplication sharedApplication] delegate];

	
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comp = [calendar components:unitFlags fromDate:date];
	
    int hourOfDay = [comp hour];
    int minuteOfHour = [comp minute];
    int secondOfMinute = [comp second];
	
	// 24H with AM PM
    if (hourOfDay < 12)
		lblAMPM.text =  @"AM";
    else
		lblAMPM.text =  @"PM";
	
    if([appDelegate option24Hour] == NO) {
		lblAMPM.alpha = 1;
		if(hourOfDay == 0)
			hourOfDay = 12;
		else {
			if (hourOfDay > 12)
				hourOfDay -= 12;
		}
    }
    else {
		lblAMPM.alpha = 0;
    }
	
	// Date Info
    if([appDelegate optionDateInfo] == YES) {
		lblDateInfo.alpha = 1;
		NSString *tmpString = [[self dateInFormat:@"%Y-%m-%d"] stringByAppendingString:@"\n\n\n\n"];
		tmpString = [tmpString stringByAppendingString:[self dateInFormat:@"%A"]];
		lblDateInfo.textAlignment = UITextAlignmentCenter;
		lblDateInfo.text =  tmpString;
    }
    else {
		lblDateInfo.alpha = 0;
    }
	
    self.lblTimeDigit.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hourOfDay, minuteOfHour, secondOfMinute];

    UIImageView *iv;
    if([appDelegate optionClockMode] == 0) {
		iv = [arraySquareImages objectAtIndex:secondOfMinute%10];
    }
    // Circle
    else {
		iv = [arrayCircleImages objectAtIndex:secondOfMinute%10];
    }
	
    iv.alpha = 0.3;
	
	CGFloat scale = RANDOM_INT(20,100);
	
    [UIView beginAnimations:nil context:NULL];
	
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    CGAffineTransform transform = CGAffineTransformMakeScale(scale/100,scale/100);
    iv.transform = transform;
	
	if(secondOfMinute%10 == 0) {
		[self clearScreen];
    }
	
	
    [UIView commitAnimations];
	
}

-(NSString *) dateInFormat:(NSString*) stringFormat {
    char buffer[80];
    const char *format = [stringFormat UTF8String];
    time_t rawtime;
    struct tm * timeinfo;
    time(&rawtime);
    timeinfo = localtime(&rawtime);
    strftime(buffer, 80, format, timeinfo);
    return [NSString  stringWithCString:buffer encoding:NSUTF8StringEncoding];
}

- (void)clearScreen {
    UIImageView *iv;
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.1, 0.1);
	
    for( int i=0 ; i<10 ; i++) {
		iv = [arraySquareImages objectAtIndex:i];
		iv.alpha = 0;
		iv.transform = scaleTransform;
		iv.center = CGPointMake(RANDOM_INT(0,320), RANDOM_INT(0,480));
		
		iv = [arrayCircleImages objectAtIndex:i];
		iv.alpha = 0;
		iv.transform = scaleTransform;
		iv.center = CGPointMake(RANDOM_INT(0,320), RANDOM_INT(0,480));
		
    }
}


- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}


- (IBAction)showInfo:(id)sender {    
	
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}

- (void)viewWillAppear:(BOOL)animated {
    [self clearScreen];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)dealloc {
    [super dealloc];
}


@end
