//
//  iCan iPhone4 Programming : Project 4 Simple Twit
//
//  DetailViewController.m
//  Simple Twit
//
//  Created by DeArto20 on 1/25/11.
//  Copyright DeArto20 All rights reserved.
//

#import "DetailViewController.h"
#import "TwitterClientModel.h"


@implementation DetailViewController

@synthesize tweet;
@synthesize userImageView;
@synthesize userScreenNameLabel;
@synthesize userNameLabel;
@synthesize userTextLabel;
@synthesize userTimeLabel;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *user  = [self.tweet objectForKey:@"user"];
    UIImage      *image = [[TwitterClientModel sharedInstance] cachedImageForURL:[user objectForKey:@"profile_image_url"]
                                                               withTarget:self
                                                               withAction:@selector(didFinishLoadingImage)];
    
    [self.userImageView         setImage:image];
    [self.userScreenNameLabel   setText:[user objectForKey:@"screen_name"]];
    [self.userNameLabel         setText:[NSString stringWithFormat:@"(%@)", [user objectForKey:@"name"]]];
    [self.userTextLabel         setText:[tweet objectForKey:@"text"]];
    [self.userTimeLabel         setText:[tweet objectForKey:@"created_at"]];
}

- (void)didFinishLoadingImage {
    NSDictionary *user  = [self.tweet objectForKey:@"user"];
    UIImage      *image = [[TwitterClientModel sharedInstance] cachedImageForURL:[user objectForKey:@"profile_image_url"]
                                                                      withTarget:self
                                                                      withAction:@selector(didFinishLoadingImage)];
    
    [self.userImageView setImage:image];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
    if (userTimeLabel) {
        [userTimeLabel release];
    }
    
    if (userTextLabel) {
        [userTextLabel release];
    }
    
    if (userNameLabel) {
        [userNameLabel release];
    }
    
    if (userScreenNameLabel) {
        [userScreenNameLabel release];
    }
    
    if (userImageView) {
        [userImageView release];
    }
    
    if (tweet) {
        [tweet release];
    }
    
    [super dealloc];
}


@end
