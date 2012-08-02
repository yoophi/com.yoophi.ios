//
//  iCan iPhone4 Programming : Project 1 Abstract Clock
//
//  FlipsideViewController.m
//  AbstractClock
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr All rights reserved.
//

#import "FlipsideViewController.h"
#import "AbstractClockAppDelegate.h"	// 133 페이지 하단 참조


@implementation FlipsideViewController

@synthesize delegate;
@synthesize tableView;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];      
	
    CGRect tableViewFrame = CGRectMake(0.0, 44.0, self.view.bounds.size.width, self.view.bounds.size.height);
    tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStyleGrouped];
    tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    [tableView reloadData];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2; 
}


- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    switch (section) {
		case 0:
			return 2;
			break;
		case 1:
			return 3; 
			break;
	}
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
		case 0:
			return @"Geometry type";
			break;
		case 1:
			return @"Clock Options";	
			break;
	}
    return @"";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if(section == 1)
		return @"Abstract Clock Ver 1.0\nDesigned by Dong Yoon Park\n www.cre8ive.kr\n\n";
    else
		return nil;
}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"PrefCell"];
	
    if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"PrefCell"] autorelease];
    }
	
	AbstractClockAppDelegate *appDelegate = (AbstractClockAppDelegate *)[[UIApplication sharedApplication] delegate];
	
    // Geometry type
    if(indexPath.section == 0) {
		if(indexPath.row == 0) {
			cell.textLabel.text = @"Squares";
		}
		else {
			cell.textLabel.text = @"Circles";
		}
		
		// Show checkmark for stored information
		NSIndexPath *selectedPath = [NSIndexPath indexPathForRow:[appDelegate optionClockMode] inSection:0];
		if ([selectedPath compare:indexPath] == NSOrderedSame ) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		else {
			cell.accessoryType = UITableViewCellAccessoryNone;
		}
    }
	
	// Clock Options
    else {
		UISwitch *switch24HourMode;
		UISwitch *switchDateInfo;
		UISwitch *switchAllowAutolock;
		
		switch (indexPath.row) {
			case 0:
				cell.textLabel.text = @"24 Hours Mode";
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				switch24HourMode = [[[UISwitch alloc] init] autorelease];
				switch24HourMode.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"key24Hour"];
				[switch24HourMode addTarget:appDelegate action:@selector(optionSwitch24Hour:) forControlEvents:UIControlEventValueChanged];
				cell.accessoryView = switch24HourMode;
				break;
				
			case 1:
				cell.textLabel.text = @"Date Information";
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				switchDateInfo = [[[UISwitch alloc] init] autorelease];
				switchDateInfo.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"keyDateInfo"];
				[switchDateInfo addTarget:appDelegate action:@selector(optionSwitchDateInfo:) forControlEvents:UIControlEventValueChanged];
				cell.accessoryView = switchDateInfo;
				break;
				
			case 2:
				cell.textLabel.text = @"Allow Auto-Lock";
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				switchAllowAutolock = [[[UISwitch alloc] init] autorelease];
				switchAllowAutolock.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"keyAllowAutoLock"];
				[switchAllowAutolock addTarget:appDelegate action:@selector(optionSwitchAllowAutolock:) forControlEvents:UIControlEventValueChanged];
				cell.accessoryView = switchAllowAutolock;
				break;
		}
    }
    return cell;
}

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)newIndexPath {
	
    AbstractClockAppDelegate *appDelegate = (AbstractClockAppDelegate *)[[UIApplication sharedApplication] delegate];
	
    if (newIndexPath.section == 1) {	// 두 번째 그룹을 터치한 것이면 그냥 리턴한다.
		return;
    }
	
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:[appDelegate optionClockMode] inSection:0];
	
    [[table cellForRowAtIndexPath:oldIndexPath] setAccessoryType:UITableViewCellAccessoryNone];
    [[table cellForRowAtIndexPath:newIndexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
	
    [table deselectRowAtIndexPath:newIndexPath animated:YES];
	
    switch (newIndexPath.row) {
		case 0:
			[appDelegate setOptionClockMode:0];
			break;
		case 1:
			[appDelegate setOptionClockMode:1];
			break;
		default:
			[appDelegate setOptionClockMode:0];
			break;
    }
}
				
	
	
	

- (IBAction)done:(id)sender {
	[self.delegate flipsideViewControllerDidFinish:self];	
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)dealloc {
    [super dealloc];
}


@end
