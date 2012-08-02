#import <UIKit/UIKit.h>
//START_HIGHLIGHT
@class Assignments;
//END_HIGHLIGHT

@interface RootViewController : UITableViewController {
}
//START_HIGHLIGHT
@property(nonatomic, retain) IBOutlet Assignments *assignments;
//END_HIGHLIGHT
@end
