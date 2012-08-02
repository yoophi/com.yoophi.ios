#import <UIKit/UIKit.h>
@class Assignments;
@class AssignmentViewController;

@interface RootViewController : UITableViewController {
}
@property(nonatomic, retain) IBOutlet Assignments *assignments;
@property(nonatomic, retain) IBOutlet AssignmentViewController *assignmentVC;
@end
