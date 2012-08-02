#import <UIKit/UIKit.h>
@class CargoColorChooser;
@class CarDriver;

@interface CargoViewController : UIViewController <UIPopoverControllerDelegate> {
    IBOutlet UIView *cargoView;
    IBOutlet CargoColorChooser *cargoColorChooser;
    IBOutlet CarDriver *carDriver;
    UIPopoverController *driveControls;
    IBOutlet UIView *corner1, *corner2, *corner3, *corner4;
}
-(IBAction) showOrHideDriveControls:(id)sender;
@end
