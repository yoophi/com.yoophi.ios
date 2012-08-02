#import "FeelingsViewController.h"


@implementation FeelingsViewController
@synthesize moodKeyboard,textView;

//START:code.textinput.angry
-(void) updateTextViewWithMood:(NSString *) mood {
    self.textView.text = [NSString stringWithFormat:@"%@ %@ ",
                                             self.textView.text, mood];
}
//END:code.textinput.angry

-(IBAction) didTapWinkKey {
    [self updateTextViewWithMood:@";-)"];
}
-(IBAction) didTapHappyKey{
    [self updateTextViewWithMood: @":-)" ];
}
-(IBAction) didTapSadKey {
    [self updateTextViewWithMood: @":-("];
}
-(IBAction) didTapAngryKey{
    [self updateTextViewWithMood: @">:("];
}
//START:code.textinput.load
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSBundle mainBundle] loadNibNamed:@"MoodKeyboard" 
                                  owner:self 
                                options:nil];
    //START_HIGHLIGHT
    self.textView.inputAccessoryView = self.moodKeyboard;
    //END_HIGHLIGHT
}
//END:code.textinput.load
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
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


- (void)dealloc {
    [moodKeyboard release], moodKeyboard = nil;
    [textView release], textView = nil;
    [super dealloc];
}

@end
