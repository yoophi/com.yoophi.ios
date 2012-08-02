#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
@interface MontyHallViewController : UIViewController <GKSessionDelegate>{
}
@property (nonatomic, retain) GKSession *session;
@property (nonatomic, retain) IBOutlet UITextField *statusField; 
@end

