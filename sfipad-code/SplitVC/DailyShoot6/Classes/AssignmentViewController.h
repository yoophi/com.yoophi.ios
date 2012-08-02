#import <UIKit/UIKit.h>
@class RootViewController;

@interface AssignmentViewController : UIViewController {
}
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSNumber *assignmentNumber;
@property (nonatomic, retain) IBOutlet RootViewController *rootVC;
-(void) loadSelectedPage;
@end
