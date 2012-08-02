#import "Assignments.h"

@implementation Assignments
-(NSUInteger) count {
    return [assignmentArray count];
}
-(NSNumber *) assignmentAtIndex:(NSUInteger) index {
    return [assignmentArray objectAtIndex:index];
}
-(void) awakeFromNib {
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < 125; i++) {
        [temp addObject:[NSNumber numberWithInt:125 - i]];
    }
    assignmentArray = [[NSArray alloc] initWithArray:temp];
}
-(void) dealloc {
    [assignmentArray release];
    [super dealloc];
}
@end