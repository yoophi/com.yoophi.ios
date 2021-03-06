#import "AssignmentViewController.h"
#import "RootViewController.h"


@implementation AssignmentViewController
@synthesize webView, assignmentNumber, rootVC;
//START:code.fromto.load
- (void) loadSelectedPage {
    NSString *url = 
    [NSString stringWithFormat:@"http://dailyshoot.com/assignments/%@",
     self.assignmentNumber];
    [self.webView loadRequest:
     [NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}
-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"Assignment #%@",
                  self.assignmentNumber];
    [self loadSelectedPage];
}
//END:code.fromto.load
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}
- (void)dealloc {
    [webView release], webView = nil;
    [assignmentNumber release], assignmentNumber = nil;
    [rootVC release], rootVC = nil;
    [super dealloc];
}
@end
