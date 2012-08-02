#import <UIKit/UIKit.h>
@class Assignments;

@class DetailViewController;

@interface RootViewController : UITableViewController {
    DetailViewController *detailViewController;
    Assignments *assignments;
}

@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;
@property (nonatomic, retain) IBOutlet Assignments *assignments;


@end
