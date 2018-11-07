//
//  ProgressView.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/15.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "ProgressView.h"
#import "ZYZControl.h"

@implementation ProgressView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self chushihua:frame];
    return self;
}
-(void)chushihua:(CGRect)frame{
    _zj_kd = 5;
    _gradientlayer1 = [CAGradientLayer layer];
    _gradientlayer2 = [CAGradientLayer layer];
    
    //渐变范围
    _gradientlayer1.startPoint = CGPointMake(0, 0);
    _gradientlayer1.endPoint = CGPointMake(0, 1);
    _gradientlayer2.startPoint = CGPointMake(1, 0);
    _gradientlayer2.endPoint = CGPointMake(1, 1);
    
    
    _array1 = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:1.f alpha:0.5] CGColor],(id)[[UIColor colorWithWhite:1.f alpha:0.4] CGColor],(id)[[UIColor colorWithWhite:1.f alpha:0.3] CGColor],(id)[[UIColor colorWithWhite:1.f alpha:0.2] CGColor],(id)[[UIColor colorWithWhite:1.f alpha:0.1] CGColor],nil];
    _array2 = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:1.f alpha:0.6] CGColor],(id)[[UIColor colorWithWhite:1.f alpha:0.7] CGColor],(id)[[UIColor colorWithWhite:1.f alpha:0.8] CGColor],(id)[[UIColor colorWithWhite:1.f alpha:0.9] CGColor],(id)[[UIColor colorWithWhite:1.f alpha:1.0] CGColor], nil];
    _gradientlayer1.locations = @[@(0.0),@(0.1),@(0.2),@(0.3),@(0.4),@(0.5),@(0.6),@(0.7),@(0.8),@(0.9)];
    
    //渐变开始
    _gradientlayer1.colors = _array1;
    _gradientlayer2.colors = _array2;
    
    //将渐变层合并一个层，方便控制
    _layer_d = [CALayer layer];
    [_layer_d insertSublayer:_gradientlayer1 atIndex:0];
    [_layer_d insertSublayer:_gradientlayer2 atIndex:0];
    
    
//    //设置蒙板
    _shapelayer = [CAShapeLayer layer];
    
    _shapelayer.fillColor = [[UIColor clearColor]CGColor];
    _shapelayer.strokeColor = [[UIColor redColor] CGColor];
    _shapelayer.backgroundColor = [[UIColor clearColor] CGColor];
    _shapelayer.lineJoin = kCALineJoinRound;
    _shapelayer.lineCap = kCALineCapRound;
    _shapelayer.frame = CGRectMake(0, 0, 0, 0);
    [self initArrow:frame];

}

-(void)setcanshu:(CGRect)rect{
    _point = CGPointMake(rect.size.width/2, _bj);
    _rect1 = CGRectMake(rect.size.width/2-_bj,0, _bj, 2*_bj);
    _rect2 = CGRectMake(rect.size.width/2,0,_bj, 2*_bj);
    
    _gradientlayer1.frame = _rect1;
    _gradientlayer2.frame = _rect2;
    
    _layer_d.frame = rect;
    _shapelayer.lineWidth = _zj_kd;
    _apath = [UIBezierPath bezierPath];
    [_apath addArcWithCenter:_point radius:_bj-2 startAngle:M_PI*2.95/4 endAngle:M_PI*1.05/4 clockwise:YES];
    
    _shapelayer.path = _apath.CGPath;
    if(_z>_z1){
        _z1 = 0.001+_z>0.999?1:0.001+_z;
    }else {
        _z1 = 0.001+_z<0?0.001:0.001+_z;
    }
    _shapelayer.strokeEnd =_z1;
    
    //[self addBackgroundCircle];
    
    [_layer_d setMask:_shapelayer];
    [self.layer addSublayer:_layer_d];
    
}

- (void)initArrow:(CGRect)frame{
    self.bgView = [ZYZControl createViewWithFrame:CGRectMake(frame.size.width/2.0 - 7, 0, 14, frame.size.width)];
    UIImageView *arrowImage = [ZYZControl createImageViewFrame:CGRectMake(0, 15, 14, 31) imageName:@"home_bg_dial_arrow"];
    
    UIImageView *lightImage = [ZYZControl createImageViewFrame:CGRectMake(-7, -10, 29, 29) imageName:@"home_Light"];
    
    [self addSubview: self.bgView];
    [self.bgView addSubview:arrowImage];
    [self.bgView addSubview:lightImage];
}

-(void)addBackgroundCircle
{
    CAShapeLayer *backgrounLayer = [CAShapeLayer layer];
    backgrounLayer.lineJoin = kCALineJoinRound;
    backgrounLayer.lineCap = kCALineCapRound;
    backgrounLayer.frame = CGRectMake(0, 0, 0, 0);
    UIBezierPath *pathT = [UIBezierPath bezierPath];
    [pathT addArcWithCenter:_point radius:_bj-2 startAngle:M_PI*2.95/4 endAngle:M_PI*1.05/4 clockwise:YES];
    
    backgrounLayer.path = pathT.CGPath;
    backgrounLayer.fillColor = [UIColor clearColor].CGColor;
    backgrounLayer.lineWidth = _zj_kd;
    backgrounLayer.strokeColor = [UIColor grayColor].CGColor;
    [self.layer addSublayer:backgrounLayer];
}
-(void)drawRect:(CGRect)rect{
    [self setcanshu:rect];
}

-(void)setZj_kd:(float)zj_kd{
    _zj_kd = zj_kd;
    [self setNeedsDisplay];
}
-(void)startAnimaition
{
    self.bgView.transform = CGAffineTransformMakeRotation(-(M_PI * 3 / 4.0));
    self.lastTransform = CGAffineTransformMakeRotation(-(M_PI * 3 / 4.0));
    CABasicAnimation * ani = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    ani.fromValue = @0.0;
    if(self.toValue > 0.6){
        self.toValue = 0.83;
    }
    ani.toValue = [NSNumber numberWithFloat:self.toValue];
    ani.duration = 1.5;
    ani.fillMode=kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    ani.removedOnCompletion=NO;
    [_shapelayer addAnimation:ani forKey:nil];
    if ((self.toValue * M_PI * 2 - M_PI/4.0) > M_PI) {
        [UIView animateWithDuration:1.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.bgView.transform = CGAffineTransformRotate(self.lastTransform, M_PI);
                self.lastTransform = CGAffineTransformRotate(self.lastTransform,M_PI);
        } completion:^(BOOL finished) {
            if ((self.toValue * M_PI * 2 - M_PI/4.0) > M_PI){
                //        [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                //            self.bgView.transform = CGAffineTransformRotate(self.lastTransform, self.toValue * (M_PI * 2) - M_PI/4.0 - M_PI);
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    self.bgView.transform = CGAffineTransformRotate(self.lastTransform, M_PI/4.0);
                }completion:^(BOOL finished) {
                    
                }];
            }
        }];
    }else{
        [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.bgView.transform = CGAffineTransformRotate(self.lastTransform, self.toValue * (M_PI * 2) - M_PI/4.0);
        } completion:^(BOOL finished) {
        }];
    }
}
@end
