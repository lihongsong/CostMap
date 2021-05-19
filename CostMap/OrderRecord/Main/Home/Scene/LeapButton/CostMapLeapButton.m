#import "CostMapLeapButton.h"
@implementation CostMapLeapButton

- (void)startLeapAnimation {
}
- (void)stopLeapAnimation {
}
- (void)startShakeAnimation {
    NSInteger idx = 0;
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.calculationMode = kCAAnimationPaced;
    positionAnimation.fillMode = kCAFillModeForwards;
    positionAnimation.repeatCount = MAXFLOAT;
    positionAnimation.autoreverses = YES;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    positionAnimation.duration = 4+idx;
    UIBezierPath *positionPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.frame, self.frame.size.width/2-5, self.frame.size.height/2-5)];
    positionAnimation.path = positionPath.CGPath;
    [self.layer addAnimation:positionAnimation forKey:@"layer-shake-p"];
    CAKeyframeAnimation *scaleXAniamtion = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleXAniamtion.values = @[@1.0,@1.1,@1.0];
    scaleXAniamtion.keyTimes = @[@0.0,@0.5,@1.0];
    scaleXAniamtion.repeatCount = MAXFLOAT;
    scaleXAniamtion.autoreverses = YES;
    scaleXAniamtion.duration = 4+idx;
    [self.layer addAnimation:scaleXAniamtion forKey:@"layer-shake-x"];
    CAKeyframeAnimation *scaleYAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleYAnimation.values = @[@1,@1.1,@1.0];
    scaleYAnimation.keyTimes = @[@0.0,@0.5,@1.0];
    scaleYAnimation.autoreverses = YES;
    scaleYAnimation.repeatCount = YES;
    scaleYAnimation.duration = 4+idx;
    [self.layer addAnimation:scaleYAnimation forKey:@"layer-shake-y"];
}
- (void)stopShakeAnimation {
    [self.layer removeAnimationForKey:@"layer-shake-p"];
    [self.layer removeAnimationForKey:@"layer-shake-y"];
    [self.layer removeAnimationForKey:@"layer-shake-x"];
}

@end
