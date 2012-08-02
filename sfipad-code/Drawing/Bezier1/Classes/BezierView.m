#import "BezierView.h"


@implementation BezierView
//START:code.drawing.path
- (CGMutablePathRef) triangle {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0,-173);
    CGPathAddLineToPoint(path, NULL, 200,173);
    CGPathAddLineToPoint(path, NULL,-200,173);
    CGPathCloseSubpath(path);
    return path;
}
//END:code.drawing.path
//START:code.drawing.fill
- (void) fill: (CGMutablePathRef) path 
    withColor:(UIColor *) color
    inContext: (CGContextRef) ctx  {
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextAddPath(ctx, path);
    CGContextFillPath(ctx);    
}
- (void) stroke:(CGMutablePathRef) path
      withColor:(UIColor *) color
          width:(CGFloat) width
      inContext:(CGContextRef) ctx {
    CGContextSetStrokeColorWithColor(ctx, color.CGColor);
    CGContextSetLineWidth(ctx, width);
    CGContextAddPath(ctx, path);
    CGContextStrokePath(ctx);
}
//END:code.drawing.fill
//START:code.drawing.center
-(void) centerContext:(CGContextRef) ctx {
    CGPoint center = [self convertPoint:self.center fromView:nil];
    CGContextSaveGState(ctx);
    CGContextTranslateCTM(ctx, center.x, center.y);       
}
-(void) restoreContext:(CGContextRef) ctx {
    CGContextRestoreGState(ctx);
}
//END:code.drawing.center
//START:code.drawing.draw
- (void)drawRect:(CGRect)rect {
    CGMutablePathRef triangle  = [self triangle];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self centerContext:ctx];
    [self fill:triangle 
     withColor:[UIColor yellowColor] 
     inContext:ctx];
    [self stroke:triangle 
       withColor:[UIColor blackColor] 
           width:20.0 
       inContext:ctx];
    [self restoreContext:ctx];
    CGPathRelease(triangle);
}
//END:code.drawing.draw
- (void)dealloc {
    [super dealloc];
}


@end
