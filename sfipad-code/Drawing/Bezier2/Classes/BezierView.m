#import "BezierView.h"


@implementation BezierView
//START:code.drawing.path
- (UIBezierPath *) triangle {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0,-173)];
    [path addLineToPoint:CGPointMake(200,173)];
    [path addLineToPoint:CGPointMake(-200,173)];
    [path closePath];
    return path;
}
//END:code.drawing.path
//START:code.drawing.fill
- (void) fill: (UIBezierPath *) path 
    withColor:(UIColor *) color  {
    [color setFill];
    [path fill];
}
- (void) stroke:(UIBezierPath *) path
      withColor:(UIColor *) color
          width:(CGFloat) width  {
    [color setStroke];
    path.lineWidth = width;
    [path stroke];
}
//END:code.drawing.fill
//START:code.drawing.center
-(void) centerPath:(UIBezierPath *) path {
    CGPoint center = [self convertPoint:self.center fromView:nil];
    [path applyTransform:CGAffineTransformMakeTranslation(center.x, center.y)];
}
//END:code.drawing.center
//START:code.drawing.draw
- (void)drawRect:(CGRect)rect {
    UIBezierPath *triangle = [[self triangle] retain];
    [self centerPath: triangle];
    [self fill:triangle withColor:[UIColor yellowColor]];
    [self stroke:triangle withColor:[UIColor blackColor] width:20.0];
    [triangle release];
}
//END:code.drawing.draw
- (void)dealloc {
    [super dealloc];
}


@end
