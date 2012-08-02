#import <UIKit/UIKit.h>

@interface CargoColorChooser : UIViewController {
    IBOutlet UIView *cargoView;
    UIPopoverController *popoverController;
}
@property(nonatomic, retain) UIPopoverController *popoverController;
-(IBAction) setCargoColor:(id)sender;
@end