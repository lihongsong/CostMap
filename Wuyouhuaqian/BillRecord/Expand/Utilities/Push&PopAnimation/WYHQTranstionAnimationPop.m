//
//  WYHQTranstionAnimationPop.m
//  HJHQWY
//
//  Created by yoser on 2018/11/7.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import "WYHQTranstionAnimationPop.h"

#import "UIViewController+Push.h"

@interface WYHQTranstionAnimationPop() <CAAnimationDelegate>

@property (nonatomic, strong)id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation WYHQTranstionAnimationPop

#pragma mark -- UIViewControllerAnimatedTransitioning --

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.7;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    self.transitionContext = transitionContext;
    
    //获取源控制器 注意不要写成 UITransitionContextFromViewKey
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //获取目标控制器 注意不要写成 UITransitionContextToViewKey
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //注意：添加顺序和push动画相反
    UIView *containView = [transitionContext containerView];
    [containView addSubview:toVc.view];
    [containView addSubview:fromVc.view];
    
    CGRect animateRect = toVc.animateRect;

    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:animateRect];
    
    ///按钮中心离屏幕最远的那个角的点
    CGPoint startPoint;
    if (animateRect.origin.x > toVc.view.center.x) {
        
        if (animateRect.origin.y < toVc.view.center.y) {
            //第一象限
            startPoint = CGPointMake(0, CGRectGetMaxY(toVc.view.frame));
        }else{
            //第四象限
            startPoint = CGPointMake(0, 0);
        }
        
    }else{
        
        if (animateRect.origin.y < toVc.view.center.y) {
            //第二象限
            startPoint = CGPointMake(CGRectGetMaxX(toVc.view.frame), CGRectGetMaxY(toVc.view.frame));
        }else{
            //第三象限
            startPoint = CGPointMake(CGRectGetMaxX(toVc.view.frame), 0);
        }
    }
    
    CGPoint endPoint = CGPointMake(CGRectGetMidX(animateRect), CGRectGetMidY(animateRect));
    CGFloat radius = sqrt((endPoint.x-startPoint.x) * (endPoint.x-startPoint.x) + (endPoint.y-startPoint.y) * (endPoint.y-startPoint.y)) - sqrt((animateRect.size.width/2 * animateRect.size.width/2) + (animateRect.size.height/2 * animateRect.size.height/2));
    
    //一开始是很大的圆，执行动画往里面回缩
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(animateRect, -radius, -radius)];
    
    //注意是赋值给fromVc视图layer的mask
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    fromVc.view.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id)startPath.CGPath;
    animation.toValue = (__bridge id)endPath.CGPath;
    animation.duration = [self transitionDuration:transitionContext];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.delegate = self;
    [maskLayer addAnimation:animation forKey:nil];
}


#pragma mark -- CAAnimationDelegate --

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    [self.transitionContext completeTransition:YES];
    
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
    
}

@end
