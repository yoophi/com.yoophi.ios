//
//  DeleteGestureRecognizer.h
//  SimpleGestureRecognizers
//
//  Created by Eric Freeman on 3/13/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

// START:draftclass
// START:entireclass
#import <Foundation/Foundation.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface DeleteGestureRecognizer : UIGestureRecognizer {
	// END:draftclass
	// START_HIGHLIGHT	
	bool strokeMovingUp;
	int touchChangedDirection;
	UIView *viewToDelete;
	// END_HIGHLIGHT	
	// START:draftclass
}
// END:draftclass

	// START_HIGHLIGHT	
@property (nonatomic, retain) UIView *viewToDelete;
	// END_HIGHLIGHT	

// START:methods
// START:methods2
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event; 
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event; 
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event; 
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
// END:methods2
- (void)reset; 
// END:methods

// START:draftclass
@end
// END:entireclass
// END:draftclass

