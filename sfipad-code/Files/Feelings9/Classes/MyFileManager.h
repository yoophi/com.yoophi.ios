#import <Foundation/Foundation.h>


@interface MyFileManager : NSObject <UITextViewDelegate>{
}

-(void)applicationDidFinishLaunchingWithFileURL:(NSURL *)fileURL inTextView:(UITextView *) textView;
@end
