//
//  CAShapeLayer+HJUIBezierPath.h
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import <QuartzCore/QuartzCore.h>

#if __has_feature(nullability) // Xcode 6.3+
#pragma clang assume_nonnull begin
#else
#define nullable
#define __nullable
#endif

@interface CAShapeLayer (HJUIBezierPath)

/**
 Update CAShapeLayer with UIBezierPath.
 */
- (void)hj_updateWithBezierPath:(UIBezierPath *)path;

/**
 Get UIBezierPath object, constructed from CAShapeLayer.
 */
- (UIBezierPath*)hj_bezierPath;

@end

#if __has_feature(nullability)
#pragma clang assume_nonnull end
#endif
