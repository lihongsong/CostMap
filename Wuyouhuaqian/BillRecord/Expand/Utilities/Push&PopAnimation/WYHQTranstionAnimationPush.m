//
//  WYHQTranstionAnimationPush.m
//  HJHQWY
//
//  Created by yoser on 2018/11/7.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import "WYHQTranstionAnimationPush.h"

#import "UIViewController+Push.h"

@interface WYHQTranstionAnimationPush() <CAAnimationDelegate>

@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation WYHQTranstionAnimationPush

#pragma mark -- UIViewControllerAnimatedTransitioning --

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    self.transitionContext = transitionContext;
    
    //获取源控制器 注意不要写成 UITransitionContextFromViewKey
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //获取目标控制器 注意不要写成 UITransitionContextToViewKey
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //获得容器视图
    UIView *containView = [transitionContext containerView];
    // 都添加到container中。注意顺序 目标控制器的view需要后面添加
    [containView addSubview:fromVc.view];
    [containView addSubview:toVc.view];
    
    CGRect animateRect = fromVc.animateRect;
    
    animateRect = [fromVc.view convertRect:animateRect toView:toVc.view];
    
    //绘制圆形
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:animateRect];
    
    //创建两个圆形的 UIBezierPath 实例；一个是 button 的 size ，另外一个则拥有足够覆盖屏幕的半径。最终的动画则是在这两个贝塞尔路径之间进行的
    //按钮中心离屏幕最远的那个角的点
    CGPoint finalPoint;
    //判断触发点在那个象限
    if(animateRect.origin.x > (toVc.view.bounds.size.width / 2)){
        if (animateRect.origin.y < (toVc.view.bounds.size.height / 2)) {
            //第一象限
            finalPoint = CGPointMake(0, CGRectGetMaxY(toVc.view.frame));
        }else{
            //第四象限
            finalPoint = CGPointMake(0, 0);
        }
    }else{
        if (animateRect.origin.y < (toVc.view.bounds.size.height / 2)) {
            //第二象限
            finalPoint = CGPointMake(CGRectGetMaxX(toVc.view.frame), CGRectGetMaxY(toVc.view.frame));
        }else{
            //第三象限
            finalPoint = CGPointMake(CGRectGetMaxX(toVc.view.frame), 0);
        }
    }
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(animateRect), CGRectGetMidY(animateRect));
    //计算向外扩散的半径 = 按钮中心离屏幕最远的那个角距离 - 按钮半径
    CGFloat radius = sqrt((finalPoint.x-startPoint.x) * (finalPoint.x-startPoint.x) + (finalPoint.y-startPoint.y) * (finalPoint.y-startPoint.y)) - sqrt(animateRect.size.width/2 * animateRect.size.width/2 + animateRect.size.height/2 * animateRect.size.height/2);
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(animateRect, -radius, -radius)];
    
    //赋值给toVc视图layer的mask
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    toVc.view.layer.mask = maskLayer;
    
    CABasicAnimation *maskAnimation =[CABasicAnimation animationWithKeyPath:@"path"];
    maskAnimation.fromValue = (__bridge id)startPath.CGPath;
    maskAnimation.toValue = (__bridge id)endPath.CGPath;
    maskAnimation.duration = [self transitionDuration:transitionContext];
    maskAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    maskAnimation.delegate = self;
    [maskLayer addAnimation:maskAnimation forKey:@"path"];
    
}

#pragma mark -- CAAnimationDelegate --

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    //告诉 iOS 这个 transition 完成
    [self.transitionContext completeTransition:YES];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
    
}

@end