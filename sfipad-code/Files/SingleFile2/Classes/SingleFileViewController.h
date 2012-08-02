#import <UIKit/UIKit.h>

@interface SingleFileViewController : UIViewController <UIDocumentInteractionControllerDelegate>{
}
@property (nonatomic, retain) UIDocumentInteractionController *controller;
-(void)applicationDidFinishLaunching;

@end

