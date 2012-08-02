#import <UIKit/UIKit.h>

@interface CargoColorChooser : UIViewController {
    IBOutlet UIView *cargoView;
}
-(IBAction) dismiss;
-(IBAction) setCargoColor:(id)sender;
@end