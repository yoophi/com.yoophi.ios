#import <UIKit/UIKit.h>
@class CargoColorChooser;
@class CarDriver;

@interface CargoViewController : UIViewController <UIPopoverControllerDelegate> {
    IBOutlet UIView *cargoView;
    IBOutlet CargoColorChooser *cargoColorChooser;
    IBOutlet CarDriver *carDriver;
    UIPopoverController *driveControls;
}
-(IBAction) showOrHideDriveControls:(id)sender;
@end
