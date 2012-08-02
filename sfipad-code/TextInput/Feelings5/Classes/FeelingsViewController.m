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
//START:code.textinput.notifications
-(void)keyboardWillAppear:(NSNotification *)notification {
    NSLog(@"Keyboard will appear:\n %@", notification);
}
-(void)keyboardWillDisappear:(NSNotification *) notification {
    NSLog(@"Keyboard will disappear:\n %@", notification);
}
//END:code.textinput.notifications

//START:code.textinput.load
- (void)viewDidLoad {
    [super viewDidLoad];
    //START_HIGHLIGHT
    [[NSNotificationCenter defaultCenter] 
                           addObserver:self 
                              selector:@selector(keyboardWillAppear:) 
                                  name:UIKeyboardWillShowNotification 
                                object:nil];
    [[NSNotificationCenter defaultCenter] 
                           addObserver:self 
                              selector:@selector(keyboardWillDisappear:) 
                                  name:UIKeyboardWillHideNotification 
                                object:nil];
    //END_HIGHLIGHT 
    [[NSBundle mainBundle] loadNibNamed:@"MoodKeyboard" 
                                  owner:self 
                                options:nil];
    self.textView.inputAccessoryView = self.moodKeyboard;
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
