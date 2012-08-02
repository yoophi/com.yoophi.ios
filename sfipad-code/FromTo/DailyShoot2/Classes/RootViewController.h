#import <UIKit/UIKit.h>
@class Assignments;

@interface RootViewController : UITableViewController {
}
//START_HIGHLIGHT
@property(nonatomic, retain) IBOutlet Assignments *assignments;
//END_HIGHLIGHT
@end
