#import <UIKit/UIKit.h>
@class MyFileManager;

@interface FeelingsViewController : UIViewController {
}
@property(nonatomic,retain) IBOutlet UIView *moodKeyboard;
@property(nonatomic, retain) IBOutlet UITextView *textView;
@property(nonatomic, retain) MyFileManager *myFM;
-(IBAction) didTapWinkKey;
-(IBAction) didTapHappyKey;
-(IBAction) didTapSadKey;
-(IBAction) didTapAngryKey;
-(void)setFileManager:(MyFileManager *)newFM;

@end

