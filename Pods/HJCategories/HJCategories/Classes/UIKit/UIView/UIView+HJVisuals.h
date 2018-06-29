//
//  UIView+HJVisuals.h
//  HJCategories
//
//  Created by yoser on 2017/12/15.
//

#import <UIKit/UIKit.h>

@interface UIView (HJVisuals)

/**
 可以在xib设置圆角
 */
@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;

/*
 *  Sets a corners with radius, given stroke size & color
 */
-(void)hj_cornerRadius: (CGFloat)radius
            strokeSize: (CGFloat)size
                 color: (UIColor *)color;
/*
 *  Sets a corners
 */
-(void)hj_setRoundedCorners: (UIRectCorner)corners
                     radius: (CGFloat)radius;

/*
 *  Draws shadow with properties
 */
-(void)hj_shadowWithColor: (UIColor *)color
                   offset: (CGSize)offset
                  opacity: (CGFloat)opacity
                   radius: (CGFloat)radius;

/*
 *  Removes from superview with fade
 */
-(void)hj_removeFromSuperviewWithFadeDuration: (NSTimeInterval)duration;

/*
 *  Adds a subview with given transition & duration
 */
-(void)hj_addSubview: (UIView *)view
      withTransition: (UIViewAnimationTransition)transition
            duration: (NSTimeInterval)duration;

/*
 *  Removes view from superview with given transition & duration
 */
-(void)hj_removeFromSuperviewWithTransition: (UIViewAnimationTransition)transition duration: (NSTimeInterval)duration;

/*
 *  Rotates view by given angle. TimingFunction can be nil and defaults to kCAMediaTimingFunctionEaseInEaseOut.
 */
-(void)hj_rotateByAngle: (CGFloat)angle
               duration: (NSTimeInterval)duration
            autoreverse: (BOOL)autoreverse
            repeatCount: (CGFloat)repeatCount
         timingFunction: (CAMediaTimingFunction *)timingFunction;

/*
 *  Moves view to point. TimingFunction can be nil and defaults to kCAMediaTimingFunctionEaseInEaseOut.
 */
-(void)hj_moveToPoint: (CGPoint)newPoint
             duration: (NSTimeInterval)duration
          autoreverse: (BOOL)autoreverse
          repeatCount: (CGFloat)repeatCount
       timingFunction: (CAMediaTimingFunction *)timingFunction;


@end
