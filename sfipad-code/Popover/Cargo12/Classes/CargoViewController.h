#import <UIKit/UIKit.h>
@class CargoColorChooser;
@class CarDriver;

@interface CargoViewController : UIViewController {
    IBOutlet UIView *cargoView;
    IBOutlet CargoColorChooser *cargoColorChooser;
    IBOutlet CarDriver *carDriver;
}
-(IBAction) showDriveControls:(id)sender;
@end
