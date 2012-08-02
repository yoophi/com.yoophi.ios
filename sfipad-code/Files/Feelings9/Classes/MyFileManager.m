#import "MyFileManager.h"


@implementation MyFileManager

//START:code.documents.launch
-(void)applicationDidFinishLaunchingWithFileURL:(NSURL *)fileURL 
                                     inTextView:(UITextView *) textView {
    NSError *error2;
        textView.text = [NSString stringWithContentsOfURL: fileURL 
                                                  encoding:NSUTF8StringEncoding 
                                                     error:&error2 ];
}
//END:code.documents.launch
@end
