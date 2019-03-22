#define AngleToRadian(x) (M_PI*(x)/180.0) 
#define SystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define DefaultFont(fontsize) SystemVersion >= 9.0 ? [UIFont fontWithName:@"Helvetica-Bold" size:(fontsize)] : [UIFont systemFontOfSize:(fontsize)]
#define FitValueBaseOnWidth(value) (value) / 375.0 * self.bounds.size.width
#define ApplyRatio(value) ((value) > 0 ? (value) : 1.0)
#import "CircleIndicatorScene.h"
@interface CircleIndicatorScene()
@property (nonatomic, strong) CALayer *layer1;
@property (nonatomic, strong) CALayer *layer2;
@property (nonatomic, strong) CALayer *layer3;
@property (nonatomic, assign) CGFloat outerAnnulusInnerCircleRadius; 
@property (nonatomic, assign) CGFloat innerAnnulusInnerCircleRadius; 
@property (nonatomic, assign) CGFloat outerAnnulusRectangleWidht; 
@property (nonatomic, assign) CGFloat outerAnnulusRectangleHeight; 
@property (nonatomic, assign) CGFloat innerAnnulusRectangleWidht; 
@property (nonatomic, assign) CGFloat innerAnnulusRectangleHeight; 
@property (nonatomic, assign) CGFloat innerAnnulusScaleRectangleWidht; 
@property (nonatomic, assign) CGFloat innerAnnulusScaleRectangleHeight; 
@property (nonatomic, assign) CGFloat startAngle; 
@property (nonatomic, assign) CGFloat endAngle;   
@property (nonatomic, assign) NSUInteger innerAnnulusLineCountToShow; 
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, assign) CGFloat outerAnnulusAngleEveryLine; 
@property (nonatomic, assign) CGFloat innerAnnulusAngleEveryLine; 
@property (nonatomic, assign) CGFloat dotRadius; 
@property (nonatomic, assign) CGFloat outerAnnulusIndicatorLabelOffset; 
@property (nonatomic, assign) CGFloat outerAnnulusIndicatorLabelFontSize; 
@property (nonatomic, assign) CGFloat innerAnnulusScaleLabelOffset; 
@property (nonatomic, assign) CGFloat innerAnnulusScaleLabelFontSize; 
@property (nonatomic, assign) CGFloat centerValueLabelFontSize;
@property (nonatomic, assign) CGFloat centerValueLabelXOffset;
@property (nonatomic, assign) CGFloat centerValueLabelYOffset;
@property (nonatomic, assign) CGFloat centerHintLabelFontSize;
@property (nonatomic, assign) CGFloat centerHintLabelXOffset;
@property (nonatomic, assign) CGFloat centerHintLabelYOffset;
@property (nonatomic, strong) UIButton *hotStatusButton; 
@property (nonatomic, assign) CGFloat hotStatusButtonWidth;
@property (nonatomic, assign) CGFloat hotStatusButtonHeight;
@property (nonatomic, assign) CGFloat hotStatusButtonXOffset;
@property (nonatomic, assign) CGFloat hotStatusButtonYOffset;
@property (nonatomic, strong) UIButton *minusButton; 
@property (nonatomic, strong) UIButton *addButton;   
@property (nonatomic, assign) CGFloat minusButtonWidth;
@property (nonatomic, assign) CGFloat minusButtonHeight;
@property (nonatomic, assign) CGFloat addButtonWidth;
@property (nonatomic, assign) CGFloat addButtonHeight;
@property (nonatomic, assign) CGFloat minusAndAddButtonAngleOffset;
@property (nonatomic, assign) CGFloat minusAndAddButtonRadiusOffset;
@property (nonatomic, assign) BOOL isStop; 
@property (nonatomic, assign) NSTimeInterval animationTimeInterval; 
@property (nonatomic, strong) NSMutableArray *scaleLabelArrayM; 
@end
@implementation CircleIndicatorScene
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup {
    [self setupDefaultDataThatIsNotRelatedToFrame];
    [self initializeUI];
}
- (void)layoutSubviews {
    [self setDataThatIsRelatedToFrameToCustomRatio];
    [self configureDataToFitSize];
    [self updateUI];
}
- (void)drawRect:(CGRect)rect {
    [self.layer1 removeFromSuperlayer];
    [self.layer2 removeFromSuperlayer];
    [self.layer3 removeFromSuperlayer];
    [self addLayer1];
    [self addLayer2];
    [self addLayer3];
}
- (void)initializeUI {
    self.centerValueLabel = [[UILabel alloc] init];
    [self addSubview:self.centerValueLabel];
    self.centerHintLabel = [[UILabel alloc] init];
    [self addSubview:self.centerHintLabel];
    self.hotStatusButton = [UIButton new];
    [self addSubview:self.hotStatusButton];
    [self.hotStatusButton setImage:[UIImage imageNamed:@"icon_heating"] forState:UIControlStateNormal];
    [self.hotStatusButton setImage:[UIImage imageNamed:@"icon_heating"] forState:UIControlStateSelected];
    self.minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.minusButton];
    [self.minusButton setImage:[UIImage imageNamed:@"btn_less"] forState:UIControlStateNormal];
    [self.minusButton setImage:[UIImage imageNamed:@"btn_less_close"] forState:UIControlStateDisabled];
    [self.minusButton addTarget:self action:@selector(minusButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.addButton];
    [self.addButton setImage:[UIImage imageNamed:@"btn_plus"] forState:UIControlStateNormal];
    [self.addButton setImage:[UIImage imageNamed:@"btn_plus_close"] forState:UIControlStateDisabled];
    [self.addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)updateUI {
    NSString *valueString;
    if (self.centerValue > 0) {
       valueString = [NSString stringWithFormat:@"%@%@", @(self.centerValue), @"分"];
        NSMutableAttributedString *stringM = [[NSMutableAttributedString alloc] initWithString:valueString];
        NSRange range = [valueString rangeOfString:@"分"];
        [stringM addAttribute:NSFontAttributeName value:DefaultFont(self.centerValueLabelFontSize) range:NSMakeRange(0, stringM.length - 2)]; 
        [stringM addAttribute:NSFontAttributeName value:DefaultFont(36.0 / 56.0 * self.centerValueLabelFontSize) range:NSMakeRange(range.location, 2)]; 
        self.centerValueLabel.attributedText = stringM;
    }else{
        valueString = @"";
        self.centerValueLabel.text = valueString;
    }
    [self.centerValueLabel sizeToFit];
    CGFloat fitSizeWidth = self.centerValueLabel.bounds.size.width;
    CGFloat fitSizeHeight = self.centerValueLabel.bounds.size.height;
    self.centerValueLabel.frame = CGRectMake(0, 0, fitSizeWidth, fitSizeHeight);
    self.centerValueLabel.textAlignment = NSTextAlignmentCenter;
    self.centerValueLabel.center = CGPointMake(self.circleCenter.x + self.centerValueLabelXOffset, self.circleCenter.y - self.centerValueLabelYOffset);
    self.centerHintLabel.font = DefaultFont(self.centerHintLabelFontSize);
    [self.centerHintLabel sizeToFit];
    CGFloat hintLabelFitSizeWidth = self.centerHintLabel.bounds.size.width;
    CGFloat hintLabelFitSizeHeight = self.centerHintLabel.bounds.size.height;
    self.centerHintLabel.frame = CGRectMake(0, 0, hintLabelFitSizeWidth, hintLabelFitSizeHeight);
    self.centerHintLabel.textAlignment = NSTextAlignmentCenter;
    self.centerHintLabel.center = CGPointMake(self.circleCenter.x + self.centerValueLabelXOffset, self.circleCenter.y - self.centerValueLabelYOffset);
    if (!self.enable) {
        self.hotStatusButton.selected = NO;
    }
    CGFloat hotStatusButtonWidth = self.hotStatusButtonWidth;
    CGFloat hotStatusButtonHeight = self.hotStatusButtonHeight;
    CGFloat hotStatusButtonX = self.circleCenter.x - hotStatusButtonWidth / 2 + self.hotStatusButtonXOffset;
    CGFloat hotStatusButtonY = self.circleCenter.y + hotStatusButtonHeight / 2 + self.hotStatusButtonYOffset;
    self.hotStatusButton.frame = CGRectMake(hotStatusButtonX, hotStatusButtonY, hotStatusButtonWidth, hotStatusButtonHeight);
    CGFloat minusButtonWidth = self.minusButtonWidth;
    CGFloat minusButtonHeight = self.minusButtonHeight;
    CGFloat minusButtonAngle = self.startAngle - self.minusAndAddButtonAngleOffset;
    CGFloat minusButtonCenterX = self.circleCenter.x + (self.outerAnnulusInnerCircleRadius + self.outerAnnulusRectangleHeight / 2 + self.minusAndAddButtonRadiusOffset) * cos(AngleToRadian(360 - minusButtonAngle));
    CGFloat minusButtonCenterY = self.circleCenter.y - (self.outerAnnulusInnerCircleRadius + self.outerAnnulusRectangleHeight / 2 + self.minusAndAddButtonRadiusOffset) * sin(AngleToRadian(360 - minusButtonAngle));
    self.minusButton.frame = CGRectMake(0, 0, minusButtonWidth, minusButtonHeight);
    self.minusButton.center = CGPointMake(minusButtonCenterX, minusButtonCenterY);
    self.minusButton.enabled = self.enable;
    CGFloat addButtonWidth = self.addButtonWidth;
    CGFloat addButtonHeight = self.addButtonHeight;
    CGFloat addButtonAngle = 180 - minusButtonAngle;
    CGFloat addButtonCenterX = self.circleCenter.x + (self.outerAnnulusInnerCircleRadius + self.outerAnnulusRectangleHeight / 2 + self.minusAndAddButtonRadiusOffset) * cos(AngleToRadian(360 - addButtonAngle));
    CGFloat addButtonCenterY = self.circleCenter.y - (self.outerAnnulusInnerCircleRadius + self.outerAnnulusRectangleHeight / 2 + self.minusAndAddButtonRadiusOffset) * sin(AngleToRadian(360 - addButtonAngle));
    self.addButton.frame = CGRectMake(0, 0, addButtonWidth, addButtonHeight);
    self.addButton.center = CGPointMake(addButtonCenterX, addButtonCenterY);
    self.addButton.enabled = self.enable;
}
- (void)setupDefaultDataThatIsNotRelatedToFrame {
    self.openAngle = 110.0;
    self.outerAnnulusLineCountToShow = 51;
    self.innerAnnulusValueToShowArray = @[@30, @40, @50, @60];;
    self.minValue = 30;
    self.maxValue = 60;
    self.centerHintLabel.text = @"已关机";
    _enable = YES;
    _isStop = NO;
}
- (void)setDataThatIsRelatedToFrameToCustomRatio {
    CGFloat circleCenterX = self.bounds.size.width / 2 * ApplyRatio(self.circleCenterX_ratio);
    CGFloat circleCenterY = 168.5 / 294 * self.bounds.size.height * ApplyRatio(self.circleCenterY_ratio);
    self.circleCenter = CGPointMake(circleCenterX, circleCenterY);
    self.outerAnnulusInnerCircleRadius = 225.0 * 0.5 * ApplyRatio(self.outerAnnulusInnerCircleRadius_ratio);
    self.innerAnnulusInnerCircleRadius = 192.0 * 0.5 * ApplyRatio(self.innerAnnulusInnerCircleRadius_ratio);
    self.outerAnnulusRectangleWidht = 3.0 * ApplyRatio(self.outerAnnulusRectangleWidht_ratio);
    self.outerAnnulusRectangleHeight = 27.0 * ApplyRatio(self.outerAnnulusRectangleHeight_ratio);
    self.innerAnnulusRectangleWidht = 2.5 * ApplyRatio(self.innerAnnulusRectangleWidht_ratio);
    self.innerAnnulusRectangleHeight = 4.5 * ApplyRatio(self.innerAnnulusRectangleHeight_ratio);
    self.innerAnnulusScaleRectangleWidht = 2.5 * ApplyRatio(self.innerAnnulusScaleRectangleWidht_ratio);
    self.innerAnnulusScaleRectangleHeight = 10.5 * ApplyRatio(self.innerAnnulusScaleRectangleHeight_ratio);
    self.dotRadius = 4.0 * ApplyRatio(self.dotRadius_ratio);
    self.outerAnnulusIndicatorLabelFontSize = 13.0 * ApplyRatio(self.outerAnnulusIndicatorLabelFontSize_ratio);
    self.outerAnnulusIndicatorLabelOffset = 13.0 * ApplyRatio(self.outerAnnulusIndicatorLabelOffset_ratio);
    self.innerAnnulusScaleLabelFontSize = 13.0 * ApplyRatio(self.innerAnnulusScaleLabelFontSize_ratio);
    self.innerAnnulusScaleLabelOffset = 4.0 * ApplyRatio(self.innerAnnulusScaleLabelOffset_ratio);
    self.centerValueLabelFontSize = 56.0 * ApplyRatio(self.centerValueLabelFontSize_ratio);
    self.centerValueLabelXOffset = 5.0 * ApplyRatio(self.centerValueLabelXOffset_ratio);
    self.centerValueLabelYOffset = 11.0 * ApplyRatio(self.centerValueLabelYOffset_ratio);
    self.centerHintLabelFontSize = 30.0 * ApplyRatio(self.centerHintLabelFontSize_ratio);
    self.centerValueLabelXOffset = 5.0 * ApplyRatio(self.centerValueLabelXOffset_ratio);
    self.centerValueLabelYOffset = 11.0 * ApplyRatio(self.centerValueLabelYOffset_ratio);
    self.hotStatusButtonWidth = 17.0 * ApplyRatio(self.hotStatusButtonWidth_ratio);
    self.hotStatusButtonHeight = 22.0 * ApplyRatio(self.hotStatusButtonHeight_ratio);
    self.hotStatusButtonXOffset = 0 * ApplyRatio(self.hotStatusButtonXOffset_ratio);
    self.hotStatusButtonYOffset = 18.0 * ApplyRatio(self.hotStatusButtonYOffset_ratio);
    self.minusButtonWidth = 52.0 * ApplyRatio(self.minusButtonWidth_ratio);
    self.minusButtonHeight = 52.0 * ApplyRatio(self.minusButtonHeight_ratio);
    self.addButtonWidth = 52.0 * ApplyRatio(self.addButtonWidth_ratio);
    self.addButtonHeight = 52.0 * ApplyRatio(self.addButtonHeight_ratio);
    self.minusAndAddButtonAngleOffset = 16.0 * ApplyRatio(self.minusAndAddButtonAngleOffset_ratio);
    self.minusAndAddButtonRadiusOffset = 0.5 * ApplyRatio(self.minusAndAddButtonRadiusOffset_ratio);
    [self calculateDataAccordingDynamicValue];
}
- (void)configureDataToFitSize {
    self.outerAnnulusInnerCircleRadius = FitValueBaseOnWidth(self.outerAnnulusInnerCircleRadius);
    self.innerAnnulusInnerCircleRadius = FitValueBaseOnWidth(self.innerAnnulusInnerCircleRadius);
    self.outerAnnulusRectangleWidht = FitValueBaseOnWidth(self.outerAnnulusRectangleWidht);
    self.outerAnnulusRectangleHeight = FitValueBaseOnWidth(self.outerAnnulusRectangleHeight);
    self.innerAnnulusRectangleWidht = FitValueBaseOnWidth(self.innerAnnulusRectangleWidht);
    self.innerAnnulusRectangleHeight = FitValueBaseOnWidth(self.innerAnnulusRectangleHeight);
    self.innerAnnulusScaleRectangleWidht = FitValueBaseOnWidth(self.innerAnnulusScaleRectangleWidht);
    self.innerAnnulusScaleRectangleHeight = FitValueBaseOnWidth(self.innerAnnulusScaleRectangleHeight);
    self.dotRadius = FitValueBaseOnWidth(self.dotRadius);
    self.outerAnnulusIndicatorLabelOffset = FitValueBaseOnWidth(self.outerAnnulusIndicatorLabelOffset);
    self.outerAnnulusIndicatorLabelFontSize = FitValueBaseOnWidth(self.outerAnnulusIndicatorLabelFontSize);
    self.innerAnnulusScaleLabelOffset = FitValueBaseOnWidth(self.innerAnnulusScaleLabelOffset);
    self.innerAnnulusScaleLabelFontSize = FitValueBaseOnWidth(self.innerAnnulusScaleLabelFontSize);
    self.centerValueLabelFontSize = FitValueBaseOnWidth(self.centerValueLabelFontSize);
    self.centerHintLabelFontSize = FitValueBaseOnWidth(self.centerHintLabelFontSize);
    self.centerValueLabelXOffset = FitValueBaseOnWidth(self.centerValueLabelXOffset);
    self.centerValueLabelYOffset = FitValueBaseOnWidth(self.centerValueLabelYOffset);
    self.centerHintLabelFontSize = FitValueBaseOnWidth(self.centerHintLabelFontSize);
    self.centerValueLabelXOffset = FitValueBaseOnWidth(self.centerValueLabelXOffset);
    self.centerValueLabelYOffset = FitValueBaseOnWidth(self.centerValueLabelYOffset);
    self.hotStatusButtonWidth = FitValueBaseOnWidth(self.hotStatusButtonWidth);
    self.hotStatusButtonHeight = FitValueBaseOnWidth(self.hotStatusButtonHeight);
    self.hotStatusButtonXOffset = FitValueBaseOnWidth(self.hotStatusButtonXOffset);
    self.hotStatusButtonYOffset = FitValueBaseOnWidth(self.hotStatusButtonYOffset);
    self.minusButtonWidth = FitValueBaseOnWidth(self.minusButtonWidth);
    self.minusButtonHeight = FitValueBaseOnWidth(self.minusButtonHeight);
    self.addButtonWidth = FitValueBaseOnWidth(self.addButtonWidth);
    self.addButtonHeight = FitValueBaseOnWidth(self.addButtonHeight);
    self.minusAndAddButtonAngleOffset = FitValueBaseOnWidth(self.minusAndAddButtonAngleOffset);
    self.minusAndAddButtonRadiusOffset = FitValueBaseOnWidth(self.minusAndAddButtonRadiusOffset);
    [self calculateDataAccordingDynamicValue];
}
- (void)calculateDataAccordingDynamicValue {
    if (self.maxValue < self.minValue) {
        return;
    }
    self.innerAnnulusLineCountToShow = self.maxValue - self.minValue + 1;
    self.startAngle = 90.0 + self.openAngle / 2.0;
    self.endAngle = 90.0 - self.openAngle / 2.0;
    self.outerAnnulusAngleEveryLine = (360.0 - self.openAngle) / (self.outerAnnulusLineCountToShow - 1);
    NSUInteger space = self.maxValue - self.minValue == 0 ? 1 : self.maxValue - self.minValue;
    self.innerAnnulusAngleEveryLine = (360.0 - self.openAngle) / space;
}
- (void)addLayer1 {
    CALayer *layer1 = [CALayer layer];
    self.layer1 = layer1;
    layer1.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self.layer addSublayer:layer1];
    layer1.backgroundColor = [UIColor colorWithRed:219.0/255.0 green:219.0/255.0 blue:219.0/255.0 alpha:255.0/255.0].CGColor;
    layer1.mask = [self maskLayerForLayer1];
}
- (void)addLayer2 {
    CAGradientLayer *layer2_GradientLayer = [CAGradientLayer layer];
    self.layer2 = layer2_GradientLayer;
    layer2_GradientLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self.layer addSublayer:layer2_GradientLayer];
    [layer2_GradientLayer setColors:@[(id)[UIColor colorWithRed:72.0/255.0 green:178.0/255.0 blue:220.0/255.0 alpha:255.0/255.0].CGColor,
                                      (id)[UIColor colorWithRed:222.0/255.0 green:215.0/255.0 blue:78.0/255.0 alpha:255.0/255.0].CGColor,
                                      (id)[UIColor colorWithRed:240.0/255.0 green:42.0/255.0 blue:36.0/255.0 alpha:255.0/255.0].CGColor]];
    [layer2_GradientLayer setLocations:@[@0.3, @0.5, @0.7]];
    [layer2_GradientLayer setStartPoint:CGPointMake(0, 0.5)];
    [layer2_GradientLayer setEndPoint:CGPointMake(1, 0.5)];
    layer2_GradientLayer.mask = [CALayer layer];
}
- (void)addLayer3 {
    CALayer *layer = [CALayer layer];
    self.layer3 = layer;
    layer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self.layer addSublayer:layer];
    layer.backgroundColor = [UIColor colorWithRed:219.0/255.0 green:219.0/255.0 blue:219.0/255.0 alpha:255.0/255.0].CGColor;
    layer.mask = [self maskLayerForLayer3];
}
- (void)shineWithTimeInterval:(NSTimeInterval)timeInterval pauseDuration:(NSTimeInterval)pauseDuration finalValue:(NSUInteger)finalValue finishBlock:(void(^)(void))finishBlock {
    [self.queue cancelAllOperations];
    if (!self.enable) {
        return;
    }
    NSMutableArray *operationArrayM = [self operationFromValue:(self.minValue - 1) toValue:self.maxValue timeInterval:timeInterval isShowAccessoryWhenFinished:NO];
    NSOperation *oprationPause = [NSBlockOperation blockOperationWithBlock:^{
        self.animationTimeInterval = timeInterval;
        [NSThread sleepForTimeInterval:pauseDuration];
    }];
    NSOperation *lastOperationGo = operationArrayM.lastObject;
    if (lastOperationGo) {
        [oprationPause addDependency:lastOperationGo];
    }
    [operationArrayM addObject:oprationPause];
    NSMutableArray *operationGoBackArrayM = [self operationFromValue:self.maxValue toValue:(self.minValue - 1) timeInterval:timeInterval isShowAccessoryWhenFinished:NO];
    NSOperation *firstGoBackOperation = operationGoBackArrayM.firstObject;
    [firstGoBackOperation addDependency:oprationPause];
    [operationArrayM addObjectsFromArray:operationGoBackArrayM];
    NSMutableArray *operationGoToFinalValueArrayM = [self operationFromValue:(self.minValue - 1) toValue:finalValue timeInterval:timeInterval isShowAccessoryWhenFinished:YES];
    NSOperation *firstOperationGoToFinalValue = operationGoToFinalValueArrayM.firstObject;
    NSOperation *lastOperationGoBack = operationArrayM.lastObject;
    if (lastOperationGoBack) {
        [firstOperationGoToFinalValue addDependency:lastOperationGoBack];
    }
    [operationArrayM addObjectsFromArray:operationGoToFinalValueArrayM];
    NSOperation *oprationFinishBlock = [NSBlockOperation blockOperationWithBlock:^{
        if (finishBlock) {
            finishBlock();
        }
    }];
    NSOperation *lastOperation2 = operationArrayM.lastObject;
    if (lastOperation2) {
        [oprationFinishBlock addDependency:lastOperation2];
    }
    [operationArrayM addObject:oprationFinishBlock];
    [self.queue addOperations:operationArrayM waitUntilFinished:NO];
}
- (void)changeIndicatorFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue isShowAccessoryWhenFinished:(BOOL)isShowAccessory duration:(CGFloat)duration  {
    NSUInteger fromLineNumber = [self lineNumberWithIndicatorValue:fromValue];
    NSUInteger toLineNumber = [self lineNumberWithIndicatorValue:toValue];
    int minus = (int)(toLineNumber - fromLineNumber);
    CGFloat durationTemp = duration / (abs(minus) + 1);
    NSOperation *lastOperation = nil;
    for (int i = 0; i <= abs(minus); i++) {
        int nextLineNumber = (int)fromLineNumber + (minus > 0 ? i : -i);
        NSBlockOperation *operation_AddNewLayer2 = [NSBlockOperation blockOperationWithBlock:^{
            self.animationTimeInterval = durationTemp;
            [NSThread sleepForTimeInterval:durationTemp];
            NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
            [mainQueue addOperationWithBlock:^{
                if (!self.isStop) {
                    self.layer2.mask = [self maskLayerForLayer2WithLineNumber:nextLineNumber];
                }
            }];
        }];
        if (lastOperation) {
            [operation_AddNewLayer2 addDependency:lastOperation];
        }
        [self.queue addOperation:operation_AddNewLayer2];
        lastOperation = operation_AddNewLayer2;
    }
    if (isShowAccessory) {
        _indicatorValue = toValue;
        NSBlockOperation *operation_ShowAccessory = [NSBlockOperation blockOperationWithBlock:^{
            NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
            [mainQueue addOperationWithBlock:^{
                [self showAccessoryOnLineWitLineNumber:toLineNumber];
            }];
        }];
        if (lastOperation) {
            [operation_ShowAccessory addDependency:lastOperation];
        }
        [self.queue addOperation:operation_ShowAccessory];
    }
}
- (NSMutableArray *)operationFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue timeInterval:(NSTimeInterval)timeInterval isShowAccessoryWhenFinished:(BOOL)isShowAccessory {
    if (self.isStop) {
        return [NSMutableArray array];
    }
    NSInteger fromLineNumber = [self lineNumberWithIndicatorValue:fromValue];
    NSInteger toLineNumber = [self lineNumberWithIndicatorValue:toValue];
    NSMutableArray *oprationArrayM = [NSMutableArray array];
    int minus = (int)(toLineNumber - fromLineNumber);
    NSOperation *lastOperation = nil;
    for (int i = 0; i <= abs(minus); i++) {
        int nextLineNumber = (int)fromLineNumber + (minus > 0 ? i : -i);
        NSBlockOperation *operation_AddNewLayer2 = [NSBlockOperation blockOperationWithBlock:^{
            self.animationTimeInterval = timeInterval;
            [NSThread sleepForTimeInterval:timeInterval];
            NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
            [mainQueue addOperationWithBlock:^{
                if (!self.isStop) {
                    self.layer2.mask = [self maskLayerForLayer2WithLineNumber:nextLineNumber];
                } else {
                }
            }];
        }];
        if (lastOperation) {
            [operation_AddNewLayer2 addDependency:lastOperation];
        }
        [oprationArrayM addObject:operation_AddNewLayer2];
        lastOperation = operation_AddNewLayer2;
    }
    if (isShowAccessory) {
        _indicatorValue = toValue;
        NSBlockOperation *operation_ShowAccessory = [NSBlockOperation blockOperationWithBlock:^{
            NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
            [mainQueue addOperationWithBlock:^{
                [self showAccessoryOnLineWitLineNumber:toLineNumber];
            }];
        }];
        if (lastOperation) {
            [operation_ShowAccessory addDependency:lastOperation];
        }
        [oprationArrayM addObject:operation_ShowAccessory];
    }
    return oprationArrayM;
}
- (NSArray *)calculateFourKeyPointForRectangleWithCircleCenter:(CGPoint)cirlceCenter innerCircleRadius:(CGFloat)innerCircleRadius rectangleWidht:(CGFloat)rectangleWidht rectangleHeight:(CGFloat)rectangleHeight angle:(CGFloat)angle {
    CGFloat cirlceCenterX = cirlceCenter.x;
    CGFloat cirlceCenterY = cirlceCenter.y;
    CGFloat tempAngle = 360 - angle;
    CGFloat tempRadian = AngleToRadian(tempAngle);
    CGFloat middlePointX_LeftLine = cirlceCenterX + innerCircleRadius * cos(tempRadian);
    CGFloat middlePointY_LeftLine = cirlceCenterY - innerCircleRadius * sin(tempRadian);
    CGFloat topLeftPointX = middlePointX_LeftLine - rectangleWidht / 2 * sin(tempRadian);
    CGFloat topLeftPointY = middlePointY_LeftLine - rectangleWidht / 2 * cos(tempRadian);
    NSValue *topLeftPointValue = [NSValue valueWithCGPoint:CGPointMake(topLeftPointX, topLeftPointY)];
    CGFloat topRightPointX = topLeftPointX + rectangleHeight * cos(tempRadian);
    CGFloat topRightPointY = topLeftPointY - rectangleHeight * sin(tempRadian);
    NSValue *topRightPointValue = [NSValue valueWithCGPoint:CGPointMake(topRightPointX, topRightPointY)];
    CGFloat bottomLeftPointX = middlePointX_LeftLine + rectangleWidht / 2 * sin(tempRadian);
    CGFloat bottomLeftPointY = middlePointY_LeftLine + rectangleWidht / 2 * cos(tempRadian);
    NSValue *bottomLeftPointValue = [NSValue valueWithCGPoint:CGPointMake(bottomLeftPointX, bottomLeftPointY)];
    CGFloat bottomRightPointX = bottomLeftPointX + rectangleHeight * cos(tempRadian);
    CGFloat bottomRightPointY = bottomLeftPointY - rectangleHeight * sin(tempRadian);
    NSValue *bottomRightPointValue = [NSValue valueWithCGPoint:CGPointMake(bottomRightPointX, bottomRightPointY)];
    NSArray *pointArray = @[topLeftPointValue, topRightPointValue, bottomRightPointValue, bottomLeftPointValue];
    return pointArray;
}
- (void)showAccessoryOnLineWitLineNumber:(NSUInteger)lineNumber {
    NSInteger minLineNumber = [self lineNumberWithIndicatorValue:self.minValue];
    NSInteger maxLineNumber = [self lineNumberWithIndicatorValue:self.maxValue];
    if (lineNumber < minLineNumber || lineNumber > maxLineNumber) {
        return;
    }
    CAShapeLayer *maskLayerForLayer2 = (CAShapeLayer *)self.layer2.mask;
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:maskLayerForLayer2.path];
    CGFloat angle = self.startAngle + lineNumber * self.outerAnnulusAngleEveryLine;
    CGFloat tempRadian = AngleToRadian(360 - angle);
    CGPoint innerCircleCenterInMaskLayer = [self.layer convertPoint:self.circleCenter toLayer:maskLayerForLayer2];
    CGFloat redDotCenterX = innerCircleCenterInMaskLayer.x + (self.outerAnnulusInnerCircleRadius + self.outerAnnulusRectangleHeight) * cos(tempRadian);
    CGFloat redDotCenterY = innerCircleCenterInMaskLayer.y - (self.outerAnnulusInnerCircleRadius + self.outerAnnulusRectangleHeight) * sin(tempRadian);
    CGPoint dotCircleCenter = CGPointMake(redDotCenterX, redDotCenterY);
    UIBezierPath *dotPath = [UIBezierPath bezierPathWithArcCenter:dotCircleCenter radius:self.dotRadius startAngle:AngleToRadian(0) endAngle:AngleToRadian(360) clockwise:YES];
    [path appendPath:dotPath];
    maskLayerForLayer2.path = path.CGPath;
    self.layer2.mask = maskLayerForLayer2;
    UILabel *indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 32, 20)];
    CGFloat indicatorLabelWidth = 32 / 13 * self.outerAnnulusIndicatorLabelFontSize;
    CGFloat indicatorLabelHeight = 20 / 13 * self.outerAnnulusIndicatorLabelFontSize;
    indicatorLabel.font = [UIFont systemFontOfSize:self.outerAnnulusIndicatorLabelFontSize];
    indicatorLabel.textAlignment = NSTextAlignmentCenter;
    indicatorLabel.text = [NSString stringWithFormat:@"%@分", @(self.indicatorValue)];
    indicatorLabel.center = CGPointMake(150, 150);
    [self addSubview:indicatorLabel];
    [maskLayerForLayer2 addSublayer:indicatorLabel.layer];
    CGFloat indicatorLabelCenterX = innerCircleCenterInMaskLayer.x + (self.outerAnnulusInnerCircleRadius + self.outerAnnulusRectangleHeight + self.outerAnnulusIndicatorLabelOffset) * cos(tempRadian) + indicatorLabelWidth / 2 * cos(AngleToRadian(angle));
    CGFloat indicatorLabelCenterY = innerCircleCenterInMaskLayer.y - (self.outerAnnulusInnerCircleRadius + self.outerAnnulusRectangleHeight + self.outerAnnulusIndicatorLabelOffset) * sin(tempRadian) + indicatorLabelHeight / 2 * sin(AngleToRadian(angle));
    indicatorLabel.center = CGPointMake(indicatorLabelCenterX, indicatorLabelCenterY);
}
- (NSInteger)lineNumberWithIndicatorValue:(CGFloat)indicatorValue {
    if (indicatorValue < self.minValue) {
        return -1;
    }
    if (indicatorValue > self.maxValue) {
        return self.outerAnnulusLineCountToShow - 1;
    }
    CGFloat valueEveryLine = (self.maxValue - self.minValue) / (CGFloat)(self.outerAnnulusLineCountToShow - 1);
    CGFloat quotientFloat = (CGFloat)(indicatorValue - self.minValue) / valueEveryLine;
    CGFloat remainder = quotientFloat - (int)quotientFloat;
    NSInteger numberReturn = remainder > (valueEveryLine / 2) ? ceil(quotientFloat) : floorf(quotientFloat);
    return numberReturn;
}
- (CAShapeLayer *)maskLayerForLayer1 {
    CAShapeLayer * maskLayer= [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, self.layer1.bounds.size.width, self.layer1.bounds.size.height);
    UIBezierPath *basePath = [UIBezierPath bezierPath];
    for (int i = 0; i < self.outerAnnulusLineCountToShow; i++) {
        CGFloat angleTemp = self.startAngle + i * self.outerAnnulusAngleEveryLine;
        NSArray *rectanglePointArray = [self calculateFourKeyPointForRectangleWithCircleCenter:self.circleCenter innerCircleRadius:self.outerAnnulusInnerCircleRadius rectangleWidht:self.outerAnnulusRectangleWidht rectangleHeight:self.outerAnnulusRectangleHeight angle:angleTemp];
        CGPoint topLeftPoint = ((NSValue *)rectanglePointArray[0]).CGPointValue;
        CGPoint topRightPoint = ((NSValue *)rectanglePointArray[1]).CGPointValue;
        CGPoint bottomRightPoint = ((NSValue *)rectanglePointArray[2]).CGPointValue;
        CGPoint bottomLeftPoint = ((NSValue *)rectanglePointArray[3]).CGPointValue;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:topLeftPoint];
        [path addLineToPoint:topRightPoint];
        [path addLineToPoint:bottomRightPoint];
        [path addLineToPoint:bottomLeftPoint];
        [path closePath];
        [basePath appendPath:path];
    }
    maskLayer.path = basePath.CGPath;
    return maskLayer;
}
- (CAShapeLayer *)maskLayerForLayer2WithLineNumber:(NSInteger)lineNumber {
    if (lineNumber < 0) {
        return [CAShapeLayer layer];
    }
    CAShapeLayer * maskLayer= [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, self.layer2.bounds.size.width, self.layer2.bounds.size.height);
    UIBezierPath *basePath = [UIBezierPath bezierPath];
    for (int i = 0; i <= lineNumber; i++) {
        CGFloat angleTemp = self.startAngle + i * self.outerAnnulusAngleEveryLine;
        NSArray *rectanglePointArray = [self calculateFourKeyPointForRectangleWithCircleCenter:self.circleCenter innerCircleRadius:self.outerAnnulusInnerCircleRadius rectangleWidht:self.outerAnnulusRectangleWidht rectangleHeight:self.outerAnnulusRectangleHeight angle:angleTemp];
        CGPoint topLeftPoint = ((NSValue *)rectanglePointArray[0]).CGPointValue;
        CGPoint topRightPoint = ((NSValue *)rectanglePointArray[1]).CGPointValue;
        CGPoint bottomRightPoint = ((NSValue *)rectanglePointArray[2]).CGPointValue;
        CGPoint bottomLeftPoint = ((NSValue *)rectanglePointArray[3]).CGPointValue;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:topLeftPoint];
        [path addLineToPoint:topRightPoint];
        [path addLineToPoint:bottomRightPoint];
        [path addLineToPoint:bottomLeftPoint];
        [path closePath];
        [basePath appendPath:path];
    }
    maskLayer.path = basePath.CGPath;
    return maskLayer;
}
- (CAShapeLayer *)maskLayerForLayer3 {
    CAShapeLayer * maskLayer= [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, self.layer3.bounds.size.width, self.layer3.bounds.size.height);
    UIBezierPath *basePath = [UIBezierPath bezierPath];
    for (int i = 0; i < self.innerAnnulusLineCountToShow; i++) {
        CGFloat angleTemp = self.startAngle + i * self.innerAnnulusAngleEveryLine;
        NSArray *rectangleFourKeyPointArray = nil;
        BOOL isScaleLine = NO;
        for (NSNumber *scaleValue in self.innerAnnulusValueToShowArray) {
            if ((i + self.minValue) == scaleValue.integerValue) {
                isScaleLine = YES;
                break;
            }
        }
        if (!isScaleLine) {
            rectangleFourKeyPointArray = [self calculateFourKeyPointForRectangleWithCircleCenter:self.circleCenter innerCircleRadius:self.innerAnnulusInnerCircleRadius rectangleWidht:self.innerAnnulusRectangleWidht rectangleHeight:self.innerAnnulusRectangleHeight angle:angleTemp];
        } else {
            CGFloat innerCircleRadius = self.innerAnnulusInnerCircleRadius - (self.innerAnnulusScaleRectangleHeight - self.innerAnnulusRectangleHeight);
            rectangleFourKeyPointArray = [self calculateFourKeyPointForRectangleWithCircleCenter:self.circleCenter innerCircleRadius:innerCircleRadius rectangleWidht:self.innerAnnulusScaleRectangleWidht rectangleHeight:self.innerAnnulusScaleRectangleHeight angle:angleTemp];
        }
        CGPoint topLeftPoint = ((NSValue *)rectangleFourKeyPointArray[0]).CGPointValue;
        CGPoint topRightPoint = ((NSValue *)rectangleFourKeyPointArray[1]).CGPointValue;
        CGPoint bottomRightPoint = ((NSValue *)rectangleFourKeyPointArray[2]).CGPointValue;
        CGPoint bottomLeftPoint = ((NSValue *)rectangleFourKeyPointArray[3]).CGPointValue;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:topLeftPoint];
        [path addLineToPoint:topRightPoint];
        [path addLineToPoint:bottomRightPoint];
        [path addLineToPoint:bottomLeftPoint];
        [path closePath];
        [basePath appendPath:path];
    }
    CGPoint innerCircleCenterInMaskLayer = [self.layer convertPoint:self.circleCenter toLayer:self.layer3];
    self.scaleLabelArrayM = [NSMutableArray array];
    for (int i = 0; i < self.innerAnnulusValueToShowArray.count; i++) {
        CGFloat value = self.innerAnnulusValueToShowArray[i].integerValue;
        if (value < self.minValue || value > self.maxValue) {
            continue;
        }
        UILabel *scaleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 18, 12)];
        scaleLabel.text = [NSString stringWithFormat:@"%@分", self.innerAnnulusValueToShowArray[i]];
        scaleLabel.font = [UIFont systemFontOfSize:self.innerAnnulusScaleLabelFontSize];
        scaleLabel.adjustsFontSizeToFitWidth = YES;
        scaleLabel.textAlignment = NSTextAlignmentCenter;
        [scaleLabel sizeToFit]; 
        CGFloat indicatorLabelWidth = scaleLabel.bounds.size.width;
        CGFloat indicatorLabelHeight = scaleLabel.bounds.size.height;
        scaleLabel.textAlignment = NSTextAlignmentCenter;
        scaleLabel.center = CGPointMake(150, 150);
        [self.scaleLabelArrayM addObject:scaleLabel];
        [maskLayer addSublayer:scaleLabel.layer]; 
        CGFloat scaleValue = ((NSNumber *)self.innerAnnulusValueToShowArray[i]).floatValue;
        CGFloat angle = self.startAngle + (scaleValue - self.minValue) * self.innerAnnulusAngleEveryLine;
        CGFloat tempRadian = AngleToRadian(360 - angle);
        CGFloat minus = self.innerAnnulusScaleRectangleHeight - self.innerAnnulusRectangleHeight;
        CGFloat indicatorLabelCenterX = innerCircleCenterInMaskLayer.x + (self.innerAnnulusInnerCircleRadius - minus - self.innerAnnulusScaleLabelOffset) * cos(tempRadian) - indicatorLabelWidth / 2 * cos(AngleToRadian(angle));
        CGFloat indicatorLabelCenterY = innerCircleCenterInMaskLayer.y - (self.innerAnnulusInnerCircleRadius - minus - self.innerAnnulusScaleLabelOffset) * sin(tempRadian) - indicatorLabelHeight / 2 * sin(AngleToRadian(angle));
        scaleLabel.center = CGPointMake(indicatorLabelCenterX, indicatorLabelCenterY);
    }
    maskLayer.path = basePath.CGPath;
    return maskLayer;
}
- (void)minusButtonClick {
    if (self.minusBlock) {
        self.minusBlock();
    }
}
- (void)addButtonClick {
    if (self.addBlock) {
        self.addBlock();
    }
}
- (void)clearIndicatorValue {
    self.isStop = YES;
    [self.queue cancelAllOperations];
    self.layer2.mask = [self maskLayerForLayer2WithLineNumber:-1];
    _indicatorValue = self.minValue - 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.animationTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isStop = NO;
    });
}
- (void)setIndicatorValue:(NSInteger)indicatorValue animated:(BOOL)animated {
    if (animated) {
        [self setIndicatorValue:indicatorValue];
    } else {
        [self.queue cancelAllOperations];
        NSInteger toLineNumber = [self lineNumberWithIndicatorValue:indicatorValue];
        self.layer2.mask = [self maskLayerForLayer2WithLineNumber:toLineNumber];
    }
}
#pragma mark - ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ Getter and Setter ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
- (NSOperationQueue *)queue {
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 1;
    }
    return _queue;
}
- (void)setIndicatorValue:(NSUInteger)indicatorValue {
    if (!self.enable) {
        return;
    }
    if (self.queue) {
        [self.queue cancelAllOperations];
    }
    if (indicatorValue > self.maxValue) {
        indicatorValue = self.maxValue;
    }
    NSUInteger oldIndicatorValue = _indicatorValue;
    _indicatorValue = indicatorValue;
    NSInteger fromLineNumber = [self lineNumberWithIndicatorValue:oldIndicatorValue];
    NSInteger toLineNumber = [self lineNumberWithIndicatorValue:indicatorValue];
    int minus = (int)(toLineNumber - fromLineNumber);
    CGFloat durationTemp = abs(minus) * 0.02;
    [self changeIndicatorFromValue:oldIndicatorValue toValue:indicatorValue isShowAccessoryWhenFinished:YES duration:durationTemp];
}
- (void)setCenterValue:(NSInteger)centerValue {
    _centerValue = centerValue;
    [self updateUI];
}
- (void)setEnable:(BOOL)enable {
    _enable = enable;
    if (enable == NO) {
        [self changeIndicatorFromValue:self.indicatorValue toValue:self.minValue - 1 isShowAccessoryWhenFinished:NO duration:0.02];
    }
}
- (void)setHotStatusOnOff:(BOOL)hotStatusOnOff {
    _hotStatusOnOff = hotStatusOnOff;
    self.hotStatusButton.hidden = hotStatusOnOff;
}
- (void)setInnerAnnulusValueToShowArray:(NSArray<NSNumber *> *)innerAnnulusValueToShowArray {
    _innerAnnulusValueToShowArray = innerAnnulusValueToShowArray;
    if (self.maxValue < self.minValue) {
        return;
    }
    [self calculateDataAccordingDynamicValue];
    [self.layer1 removeFromSuperlayer];
    [self.layer2 removeFromSuperlayer];
    [self.layer3 removeFromSuperlayer];
    [self addLayer1];
    [self addLayer2];
    [self addLayer3];
}
@end
