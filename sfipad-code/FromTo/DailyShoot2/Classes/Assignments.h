#import <Foundation/Foundation.h>

@interface Assignments : NSObject {
    NSArray *assignmentArray;
}
-(NSUInteger) count;
-(NSNumber *) assignmentAtIndex:(NSUInteger) index;
@end
