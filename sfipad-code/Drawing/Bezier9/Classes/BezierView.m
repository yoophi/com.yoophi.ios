#import "BezierView.h"


@implementation BezierView

- (UIBezierPath *) dot {
    return [UIBezierPath 
              bezierPathWithOvalInRect:CGRectMake(-25, 95, 50, 50)];
}
//START:code.drawing.top
- (UIBezierPath *) top {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(-30, -70)];
    //START_HIGHLIGHT
    [path addCurveToPoint:CGPointMake(30, -70) 
            controlPoint1:CGPointMake(-35, -98) 
            controlPoint2:CGPointMake(35, -98)];
    //END_HIGHLIGHT
    [path addLineToPoint:CGPointMake(30, -70)];
    [path addLineToPoint:CGPointMake(5, 70)];
    [path addQuadCurveToPoint:CGPointMake(-5, 70) 
                 controlPoint:CGPointMake(0, 98)];
    [path addLineToPoint:CGPointMake(-30, -70)];
    return path;
}
//END:code.drawing.top
//START:code.drawing.point
- (UIBezierPath *) exclamationPoint {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path appendPath:[self top]];
    [path appendPath:[self dot]];
    return path;
}
//END:code.drawing.point

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
    //START_HIGHLIGHT
    UIBezierPath *exclamationPoint = [[self exclamationPoint] retain];
    [self centerPath:exclamationPoint];
    [self fill:exclamationPoint withColor:[UIColor blackColor]];
    [exclamationPoint release];
    //END_HIGHLIGHT
    [triangle release];
}
//END:code.drawing.draw
- (void)dealloc {
    [super dealloc];
}


@end
