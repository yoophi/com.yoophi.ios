#import <UIKit/UIKit.h>

@interface FeelingsViewController : UIViewController {
}
@property(nonatomic,retain) IBOutlet UIView *moodKeyboard;
@property(nonatomic, retain) IBOutlet UITextView *textView;
//START_HIGHLIGHT
-(IBAction) didTapWinkKey;
-(IBAction) didTapHappyKey;
-(IBAction) didTapSadKey;
-(IBAction) didTapAngryKey;
//END_HIGHLIGHT
@end

