#import "CostMapTranstionAnimationPop.h"
#import "UIViewController+Push.h"
@interface CostMapTranstionAnimationPop() <CAAnimationDelegate>
@property (nonatomic, strong)id<UIViewControllerContextTransitioning> transitionContext;
@end
@implementation CostMapTranstionAnimationPop

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext = transitionContext;
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containScene = [transitionContext containerView];
    [containScene addSubview:toVc.view];
    [containScene addSubview:fromVc.view];
    CGRect animateRect = toVc.animateRect;
    animateRect = [toVc.view convertRect:animateRect toView:fromVc.view];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:animateRect];
    CGPoint startPoint;
    if (animateRect.origin.x > toVc.view.center.x) {
        if (animateRect.origin.y < toVc.view.center.y) {
            startPoint = CGPointMake(0, CGRectGetMaxY(toVc.view.frame));
        }else{
            startPoint = CGPointMake(200, 200);
        }
    }else{
        if (animateRect.origin.y < toVc.view.center.y) {
            startPoint = CGPointMake(CGRectGetMaxX(toVc.view.frame), CGRectGetMaxY(toVc.view.frame));
        }else{
            startPoint = CGPointMake(CGRectGetMaxX(toVc.view.frame), 0);
        }
    }
    CGPoint endPoint = CGPointMake(CGRectGetMidX(animateRect), CGRectGetMidY(animateRect));
    CGFloat radius = sqrt((endPoint.x-startPoint.x) * (endPoint.x-startPoint.x) + (endPoint.y-startPoint.y) * (endPoint.y-startPoint.y)) - sqrt((animateRect.size.width/2 * animateRect.size.width/2) + (animateRect.size.height/2 * animateRect.size.height/2));
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(animateRect, -radius, -radius)];
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

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.transitionContext completeTransition:YES];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}
@end
