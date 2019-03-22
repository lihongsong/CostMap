#import "YosKeepAccountsTranstionAnimationPush.h"
#import "UIViewController+Push.h"
@interface YosKeepAccountsTranstionAnimationPush() <CAAnimationDelegate>
@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;
@end
@implementation YosKeepAccountsTranstionAnimationPush
#pragma mark -- UIViewControllerAnimatedTransitioning --
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.4;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext = transitionContext;
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containScene = [transitionContext containerView];
    [containScene addSubview:fromVc.view];
    [containScene addSubview:toVc.view];
    CGRect animateRect = fromVc.animateRect;
    animateRect = [fromVc.view convertRect:animateRect toView:toVc.view];
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:animateRect];
    CGPoint finalPoint;
    if(animateRect.origin.x > (toVc.view.bounds.size.width / 2)){
        if (animateRect.origin.y < (toVc.view.bounds.size.height / 2)) {
            finalPoint = CGPointMake(0, CGRectGetMaxY(toVc.view.frame));
        }else{
            finalPoint = CGPointMake(0, 0);
        }
    }else{
        if (animateRect.origin.y < (toVc.view.bounds.size.height / 2)) {
            finalPoint = CGPointMake(CGRectGetMaxX(toVc.view.frame), CGRectGetMaxY(toVc.view.frame));
        }else{
            finalPoint = CGPointMake(CGRectGetMaxX(toVc.view.frame), 0);
        }
    }
    CGPoint startPoint = CGPointMake(CGRectGetMidX(animateRect), CGRectGetMidY(animateRect));
    CGFloat radius = sqrt((finalPoint.x-startPoint.x) * (finalPoint.x-startPoint.x) + (finalPoint.y-startPoint.y) * (finalPoint.y-startPoint.y)) - sqrt(animateRect.size.width/2 * animateRect.size.width/2 + animateRect.size.height/2 * animateRect.size.height/2);
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(animateRect, -radius, -radius)];
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
    [self.transitionContext completeTransition:YES];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}
@end
