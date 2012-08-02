//
//  DeleteGestureRecognizer.m
//  SimpleGestureRecognizers
//
//  Created by Eric Freeman on 3/13/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "DeleteGestureRecognizer.h"

// START:skeleton
@implementation DeleteGestureRecognizer

@synthesize viewToDelete;

// END:skeleton
// START:touchesBegan
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { 
	[super touchesBegan:touches withEvent:event]; 
	
	if ([touches count] != 1) {
		self.state = UIGestureRecognizerStateFailed; 
		return;
	}
} 
// END:touchesBegan

	// START:touchesMovedHitTest
// START:touchesMoved
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event { 
	[super touchesMoved:touches withEvent:event]; 

	if (self.state == UIGestureRecognizerStateFailed) return; 
	
	CGPoint nowPoint = [[touches anyObject] locationInView:self.view];
	CGPoint prevPoint = [[touches anyObject] previousLocationInView:self.view];
	
	if (strokeMovingUp == YES) {
		if (nowPoint.y < prevPoint.y ) {
			strokeMovingUp = NO;
			touchChangedDirection++;
		} 
	} else if (nowPoint.y > prevPoint.y ) {
		strokeMovingUp = YES; 
		touchChangedDirection++;
	}
	
	// END:touchesMoved
	// START_HIGHLIGHT	
	if (viewToDelete == nil) {
		UIView *hit = [self.view hitTest:nowPoint withEvent:nil];
		if (hit != nil && hit != self.view) {
			self.viewToDelete = hit;
		}
	}
	// END_HIGHLIGHT	
	// START:touchesMoved
}
// END:touchesMoved
	// END:touchesMovedHitTest
// START:touchesEnded
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event { 
	[super touchesEnded:touches withEvent:event]; 
	if (self.state == UIGestureRecognizerStatePossible) {
		if (touchChangedDirection >= 3) {
			self.state = UIGestureRecognizerStateRecognized;
		} else {
			self.state = UIGestureRecognizerStateFailed;
		}
	}
}
// END:touchesEnded

// START:touchesCancelled
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event { 
	[super touchesCancelled:touches withEvent:event]; 
	[self reset];
	self.state = UIGestureRecognizerStateFailed;
}
// END:touchesCancelled

// START:reset
- (void)reset {
	[super reset];
	strokeMovingUp = YES;
	touchChangedDirection = 0;
	self.viewToDelete = nil;
}
// END:reset
// START:skeleton
@end
// END:skeleton
