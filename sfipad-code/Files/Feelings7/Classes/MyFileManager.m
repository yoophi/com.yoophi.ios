#import "MyFileManager.h"


@implementation MyFileManager

- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                NSUserDomainMask, 
                                                YES)     lastObject];
}
-(NSString *) fileLocation {
    return  [[self applicationDocumentsDirectory] 
                         stringByAppendingPathComponent:@"Mood.txt"];
}
//START:code.documents.save
-(void) saveDocument:(UITextView *) textView {
    NSError *error1 = nil;
    [textView.text writeToFile:[self fileLocation] 
                    atomically:YES 
                      encoding:NSUTF8StringEncoding 
                         error:&error1];
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    [self saveDocument:textView];
    return YES;
}
-(void)applicationWillTerminate:(UITextView *)textView{
    [self saveDocument:textView];
}
//END:code.documents.save
//START:code.documents.launch
-(void)applicationDidFinishLaunching:(UITextView *) textView {
    NSError *error2;
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self fileLocation]] ) {
        textView.text = [NSString stringWithContentsOfFile:[self fileLocation] 
                                                  encoding:NSUTF8StringEncoding 
                                                     error:&error2 ];
    }
}
//END:code.documents.launch
@end
