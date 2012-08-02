#import "SingleFileViewController.h"

@implementation SingleFileViewController
@synthesize controller;
//START:code.documents.controller
-(UIDocumentInteractionController *) controller {
    if (controller == nil) {
        NSString *applicationDocumentsDirectory = 
                 [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                      NSUserDomainMask, 
                                                      YES)     lastObject];
        NSString *fileLocation = 
        [applicationDocumentsDirectory stringByAppendingPathComponent:@"Mood.txt"];
        NSURL *fileURL = [NSURL fileURLWithPath:fileLocation];
        //START_HIGHLIGHT
        self.controller = 
            [UIDocumentInteractionController interactionControllerWithURL:fileURL];
        //END_HIGHLIGHT
    }
    return controller;
}
//END:code.documents.controller
//START:code.documents.launch
-(void)applicationDidFinishLaunching {
    [self.controller presentOpenInMenuFromRect:CGRectMake(200, 200, 200, 200) 
                                        inView:self.view 
                                      animated:YES];
}
//END:code.documents.launch
- (void)dealloc {
    [controller release], controller = nil;
    [super dealloc];
}

@end
