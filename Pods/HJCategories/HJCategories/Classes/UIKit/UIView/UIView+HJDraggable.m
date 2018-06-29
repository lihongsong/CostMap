//
//  UIView+HJDraggable.m
//  HJCategories
//
//  Created by yoser on 2017/12/15.
//

#import "UIView+HJDraggable.h"
#import "objc/runtime.h"

@implementation UIView (HJDraggable)

- (void)setHj_panGesture:(UIPanGestureRecognizer*)panGesture
{
    objc_setAssociatedObject(self, @selector(hj_panGesture), panGesture, OBJC_ASSOCIATION_RETAIN);
}

- (UIPanGestureRecognizer*)hj_panGesture
{
    return objc_getAssociatedObject(self, @selector(hj_panGesture));
}

- (void)setHj_cagingArea:(CGRect)cagingArea
{
    if (CGRectEqualToRect(cagingArea, CGRectZero) ||
        CGRectContainsRect(cagingArea, self.frame)) {
        NSValue *cagingAreaValue = [NSValue valueWithCGRect:cagingArea];
        objc_setAssociatedObject(self, @selector(hj_cagingArea), cagingAreaValue, OBJC_ASSOCIATION_RETAIN);
    }
}

- (CGRect)hj_cagingArea
{
    NSValue *cagingAreaValue = objc_getAssociatedObject(self, @selector(hj_cagingArea));
    return [cagingAreaValue CGRectValue];
}

- (void)setHj_handle:(CGRect)handle
{
    CGRect relativeFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (CGRectContainsRect(relativeFrame, handle)) {
        NSValue *handleValue = [NSValue valueWithCGRect:handle];
        objc_setAssociatedObject(self, @selector(hj_handle), handleValue, OBJC_ASSOCIATION_RETAIN);
    }
}

- (CGRect)hj_handle
{
    NSValue *handleValue = objc_getAssociatedObject(self, @selector(hj_handle));
    return [handleValue CGRectValue];
}

- (void)setHj_shouldMoveAlongY:(BOOL)newShould
{
    NSNumber *shouldMoveAlongYBool = [NSNumber numberWithBool:newShould];
    objc_setAssociatedObject(self, @selector(hj_shouldMoveAlongY), shouldMoveAlongYBool, OBJC_ASSOCIATION_RETAIN );
}

- (BOOL)hj_shouldMoveAlongY
{
    NSNumber *moveAlongY = objc_getAssociatedObject(self, @selector(hj_shouldMoveAlongY));
    return (moveAlongY) ? [moveAlongY boolValue] : YES;
}

- (void)setHj_shouldMoveAlongX:(BOOL)newShould
{
    NSNumber *shouldMoveAlongXBool = [NSNumber numberWithBool:newShould];
    objc_setAssociatedObject(self, @selector(hj_shouldMoveAlongX), shouldMoveAlongXBool, OBJC_ASSOCIATION_RETAIN );
}

- (BOOL)hj_shouldMoveAlongX
{
    NSNumber *moveAlongX = objc_getAssociatedObject(self, @selector(hj_shouldMoveAlongX));
    return (moveAlongX) ? [moveAlongX boolValue] : YES;
}

- (void)setHj_draggingStartedBlock:(void (^)(void))draggingStartedBlock
{
    objc_setAssociatedObject(self, @selector(hj_draggingStartedBlock), draggingStartedBlock, OBJC_ASSOCIATION_RETAIN);
}

- (void (^)(void))hj_draggingStartedBlock
{
    return objc_getAssociatedObject(self, @selector(hj_draggingStartedBlock));
}

- (void)setHj_draggingEndedBlock:(void (^)(void))draggingEndedBlock
{
    objc_setAssociatedObject(self, @selector(hj_draggingEndedBlock), draggingEndedBlock, OBJC_ASSOCIATION_RETAIN);
}

- (void (^)(void))hj_draggingEndedBlock
{
    return objc_getAssociatedObject(self, @selector(hj_draggingEndedBlock));
}

- (void)hj_handlePan:(UIPanGestureRecognizer*)sender
{
    // Check to make you drag from dragging area
    CGPoint locationInView = [sender locationInView:self];
    if (!CGRectContainsPoint(self.hj_handle, locationInView)) {
        return;
    }
    
    [self hj_adjustAnchorPointForGestureRecognizer:sender];
    
    if (sender.state == UIGestureRecognizerStateBegan && self.hj_draggingStartedBlock) {
        self.hj_draggingStartedBlock();
    }
    
    if (sender.state == UIGestureRecognizerStateEnded && self.hj_draggingEndedBlock) {
        self.hj_draggingEndedBlock();
    }
    
    CGPoint translation = [sender translationInView:[self superview]];
    
    CGFloat newXOrigin = CGRectGetMinX(self.frame) + (([self hj_shouldMoveAlongX]) ? translation.x : 0);
    CGFloat newYOrigin = CGRectGetMinY(self.frame) + (([self hj_shouldMoveAlongY]) ? translation.y : 0);
    
    CGRect cagingArea = self.hj_cagingArea;
    
    CGFloat cagingAreaOriginX = CGRectGetMinX(cagingArea);
    CGFloat cagingAreaOriginY = CGRectGetMinY(cagingArea);
    
    CGFloat cagingAreaRightSide = cagingAreaOriginX + CGRectGetWidth(cagingArea);
    CGFloat cagingAreaBottomSide = cagingAreaOriginY + CGRectGetHeight(cagingArea);
    
    if (!CGRectEqualToRect(cagingArea, CGRectZero)) {
        
        // Check to make sure the view is still within the caging area
        if (newXOrigin <= cagingAreaOriginX ||
            newYOrigin <= cagingAreaOriginY ||
            newXOrigin + CGRectGetWidth(self.frame) >= cagingAreaRightSide ||
            newYOrigin + CGRectGetHeight(self.frame) >= cagingAreaBottomSide) {
            
            // Don't move
            newXOrigin = CGRectGetMinX(self.frame);
            newYOrigin = CGRectGetMinY(self.frame);
        }
    }
    
    [self setFrame:CGRectMake(newXOrigin,
                              newYOrigin,
                              CGRectGetWidth(self.frame),
                              CGRectGetHeight(self.frame))];
    
    [sender setTranslation:(CGPoint){0, 0} inView:[self superview]];
}

- (void)hj_adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = self;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}

- (void)hj_setDraggable:(BOOL)draggable
{
    [self.hj_panGesture setEnabled:draggable];
}

- (void)hj_enableDragging
{
    self.hj_panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(hj_handlePan:)];
    [self.hj_panGesture setMaximumNumberOfTouches:1];
    [self.hj_panGesture setMinimumNumberOfTouches:1];
    [self.hj_panGesture setCancelsTouchesInView:NO];
    [self setHj_handle:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addGestureRecognizer:self.hj_panGesture];
}


@end
