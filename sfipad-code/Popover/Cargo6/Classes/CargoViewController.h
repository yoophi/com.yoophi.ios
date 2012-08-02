#import <UIKit/UIKit.h>
@class CargoColorChooser;

@interface CargoViewController : UIViewController {
    IBOutlet UIView *cargoView;
    IBOutlet CargoColorChooser *cargoColorChooser;
}
@end
