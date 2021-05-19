//
//  SHWWaterView.m
//  
//
//  Created by  on 16/9/8.//

#import "CostMapWaterWaveView.h"

@interface CostMapWaterWaveView ()
@property(nonatomic, strong) UIView *ripple1View;
@property(nonatomic, strong) UIView *ripple2View;
@property(nonatomic, strong) CADisplayLink *waterTimer;
@property(nonatomic, assign) CGFloat offsetX1;
@property(nonatomic, assign) CGFloat offsetX2;
@property(nonatomic, assign) CGFloat rippleWidth;
@property(nonatomic, assign) CGFloat progressHeight;

@property(nonatomic, strong) CAGradientLayer *ripple1Layer;
@property(nonatomic, strong) CAGradientLayer *ripple2Layer;

@property(nonatomic, strong) CAShapeLayer *ripple1ShapeLayer;
@property(nonatomic, strong) CAShapeLayer *ripple2ShapeLayer;

@property(nonatomic, assign) BOOL animationing;

@end

@implementation CostMapWaterWaveView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _ripple2View = [[UIView alloc] initWithFrame:CGRectZero];
        _ripple2View.backgroundColor = [UIColor clearColor];
        _ripple2View.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        [self addSubview:_ripple2View];
        _ripple2Layer = [CAGradientLayer layer];
        _ripple2Layer.frame = _ripple2View.bounds;
        [_ripple2View.layer addSublayer:_ripple2Layer];
        _ripple2ShapeLayer = [CAShapeLayer layer];
        _ripple2ShapeLayer.frame = _ripple2View.bounds;

        _ripple1View = [[UIView alloc] initWithFrame:CGRectZero];
        _ripple1View.backgroundColor = [UIColor clearColor];
        _ripple1View.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        [self addSubview:_ripple1View];
        _ripple1Layer = [CAGradientLayer layer];
        [_ripple1View.layer addSublayer:_ripple1Layer];
        _ripple1ShapeLayer = [CAShapeLayer layer];
        _ripple1ShapeLayer.frame = _ripple1View.frame;
        _ripple1Layer.frame = _ripple1View.bounds;

        [self bringSubviewToFront:_ripple1View];

        _firstWaveSpeed = 2.5;
        _secondWaveSpeed = 2;
        _firstWaveColor = [UIColor cyanColor];
        _secondWaveColor = [UIColor lightGrayColor];
        _firstWaveHeight = 10.;
        _secondWaveHeight = 10.;
        _showSecondWave = NO;
        _progress = 0.5;
        _waterWaveNum = 2;
        _rippleWidth = CGRectGetWidth(frame) / _waterWaveNum;
        _progressHeight = CGRectGetHeight(frame) * _progress;
        [self createFirstWave];
        [self createSecondWave];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];

    if (self.ripple1View) {
        self.ripple1View.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
    }
    if (self.ripple2View) {
        self.ripple2View.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
    }
}

- (void)startWaveAnimate {

    self.waterTimer = [CADisplayLink displayLinkWithTarget:[CostMapWaterWeakProxy proxyWithTarget:self] selector:@selector(rippleAnimate)];
    [self.waterTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    self.animationing = YES;
}

- (void)stopWaveAnimate {
    self.waterTimer.paused = YES;
    [self.waterTimer invalidate];
    self.waterTimer = nil;

    self.animationing = NO;
}

- (void)rippleAnimate {
    self.offsetX1 += self.firstWaveSpeed;
    if (self.offsetX1 / self.rippleWidth > 2) {
        self.offsetX1 = 0;
    }
    self.ripple1View.transform = CGAffineTransformMakeTranslation(0 - self.offsetX1, 0);

    self.offsetX2 += self.secondWaveSpeed;
    if (self.offsetX2 / self.rippleWidth > 2) {
        self.offsetX2 = 0;
    }
    self.ripple2View.transform = CGAffineTransformMakeTranslation(0 - self.offsetX2, 0);
}

- (void)createSecondWave {

    CGFloat height = self.ripple2View.hj_height;
    CGFloat width = self.ripple2View.hj_width + self.rippleWidth * 2;
    self.ripple2Layer.frame = CGRectMake(0, 0, width, height);

    UIBezierPath *aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 0;
    for (int i = 0; i < self.waterWaveNum + 2; i++) {
        [aPath moveToPoint:CGPointMake(i * self.rippleWidth, self.progressHeight)];
        [aPath addQuadCurveToPoint:CGPointMake((i + 1) * self.rippleWidth, self.progressHeight) controlPoint:CGPointMake(i * self.rippleWidth + self.rippleWidth / 2, self.progressHeight + (i % 2 == 0 ? (0 - self.secondWaveHeight) : self.secondWaveHeight))];
    }
    [aPath addLineToPoint:CGPointMake((self.waterWaveNum + 2) * self.rippleWidth, self.progressHeight)];
    [aPath addLineToPoint:CGPointMake((self.waterWaveNum + 2) * self.rippleWidth, CGRectGetHeight(self.bounds))];
    [aPath addLineToPoint:CGPointMake(0, CGRectGetHeight(self.bounds))];
    [aPath addLineToPoint:CGPointMake(0, self.progressHeight)];

    [aPath closePath];

    self.ripple2Layer.colors = @[(__bridge id) _secondWaveColor.CGColor,
            (__bridge id) [[UIColor whiteColor] colorWithAlphaComponent:1.0].CGColor];

    self.ripple2Layer.locations = @[@(0.5), @(1.0)];

    self.ripple2Layer.startPoint = CGPointMake(0, 0.5);
    self.ripple2Layer.endPoint = CGPointMake(0, 1.0);

    self.ripple2ShapeLayer.path = aPath.CGPath;
    self.ripple2Layer.mask = self.ripple2ShapeLayer;
}

- (void)createFirstWave {

    CGFloat height = self.ripple1View.hj_height;
    CGFloat width = self.ripple1View.hj_width + self.rippleWidth * 2;
    self.ripple1Layer.frame = CGRectMake(0, 0, width, height);

    UIBezierPath *aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 0;
    for (int i = 0; i < self.waterWaveNum + 2; i++) {
        [aPath moveToPoint:CGPointMake(i * self.rippleWidth, self.progressHeight)];
        [aPath addQuadCurveToPoint:CGPointMake((i + 1) * self.rippleWidth, self.progressHeight) controlPoint:CGPointMake(i * self.rippleWidth + self.rippleWidth / 2, self.progressHeight + (i % 2 == 0 ? (0 - self.firstWaveHeight) : self.firstWaveHeight))];
    }
    [aPath addLineToPoint:CGPointMake((self.waterWaveNum + 2) * self.rippleWidth, self.progressHeight)];
    [aPath addLineToPoint:CGPointMake((self.waterWaveNum + 2) * self.rippleWidth, CGRectGetHeight(self.bounds))];
    [aPath addLineToPoint:CGPointMake(0, CGRectGetHeight(self.bounds))];
    [aPath addLineToPoint:CGPointMake(0, self.progressHeight)];

    [aPath closePath];

    self.ripple1Layer.colors = @[(__bridge id) _firstWaveColor.CGColor,
            (__bridge id) [[UIColor whiteColor] colorWithAlphaComponent:0.7].CGColor];

    self.ripple1Layer.locations = @[@(0.3), @(0.6)];

    self.ripple1Layer.startPoint = CGPointMake(0, 0.5);
    self.ripple1Layer.endPoint = CGPointMake(0, 1.0);

    self.ripple1ShapeLayer.path = aPath.CGPath;
    self.ripple1Layer.mask = self.ripple1ShapeLayer;
}

- (void)setFirstWaveHeight:(CGFloat)firstWaveHeight {
    _firstWaveHeight = firstWaveHeight;
    [self createFirstWave];
}

- (void)setFirstWaveColor:(UIColor *)firstWaveColor {
    _firstWaveColor = firstWaveColor;
    [self createFirstWave];
}

- (void)setSecondWaveColor:(UIColor *)secondWaveColor {
    _secondWaveColor = secondWaveColor;
    [self createSecondWave];
}

- (void)setSecondWaveHeight:(CGFloat)secondWaveHeight {
    _secondWaveHeight = secondWaveHeight;
    [self createSecondWave];
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    self.progressHeight = CGRectGetHeight(self.bounds) * progress;
    [self createFirstWave];
    [self createSecondWave];
}

- (void)setWaterWaveNum:(NSUInteger)waterWaveNum {
    _waterWaveNum = waterWaveNum;
    self.rippleWidth = CGRectGetWidth(self.bounds) / waterWaveNum;
    [self createFirstWave];
    [self createSecondWave];
}

- (void)setShowSecondWave:(BOOL)showSecondWave {
    _showSecondWave = showSecondWave;
    self.ripple2View.hidden = !showSecondWave;
}

@end
