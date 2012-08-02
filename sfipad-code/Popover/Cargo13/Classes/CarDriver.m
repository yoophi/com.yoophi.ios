#import "CarDriver.h"

@implementation CarDriver

-(void) viewDidLoad{
    [super viewDidLoad];
    [rightArrow addGestureRecognizer:
     [[[UITapGestureRecognizer alloc] 
       initWithTarget:self 
       action:@selector(shouldMoveRight)]
      autorelease]];
    [leftArrow addGestureRecognizer:
     [[[UITapGestureRecognizer alloc] 
       initWithTarget:self 
       action:@selector(shouldMoveLeft)]
      autorelease]];
    [upArrow addGestureRecognizer:
     [[[UITapGestureRecognizer alloc] 
       initWithTarget:self 
       action:@selector(shouldMoveUp)]
      autorelease]];
    [downArrow addGestureRecognizer:
     [[[UITapGestureRecognizer alloc] 
       initWithTarget:self 
       action:@selector(shouldMoveDown)]
      autorelease]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) shouldMoveRight {
    cargoView.center = CGPointMake(cargoView.center.x + 10, 
                                   cargoView.center.y);
}
-(void) shouldMoveLeft {
    cargoView.center = CGPointMake(cargoView.center.x - 10, 
                                   cargoView.center.y);
}
-(void) shouldMoveUp {
    cargoView.center = CGPointMake(cargoView.center.x, 
                                   cargoView.center.y - 10);
}
-(void) shouldMoveDown {
    cargoView.center = CGPointMake(cargoView.center.x, 
                                   cargoView.center.y + 10);
}
@end