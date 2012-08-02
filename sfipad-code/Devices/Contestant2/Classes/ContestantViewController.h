#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface ContestantViewController : UIViewController  <GKSessionDelegate> {
    NSUInteger prizeDoorNumber, selectedDoorNumber;
    BOOL hasMadeInitialChoice;
}
@property (nonatomic, retain) GKSession *session;
@property (nonatomic, retain) IBOutlet UITextField *statusField; 
@property (nonatomic, copy) NSArray *doors;
@property (nonatomic, retain) IBOutlet UIButton *door1, *door2, *door3;
-(IBAction) selectDoor:(id)sender;

@end

