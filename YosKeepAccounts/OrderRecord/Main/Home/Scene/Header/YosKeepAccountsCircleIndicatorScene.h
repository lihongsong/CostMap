#import <UIKit/UIKit.h>
@interface YosKeepAccountsCircleIndicatorScene : UIView
@property (nonatomic, assign) CGPoint circleCenter; 
@property (nonatomic, assign) CGFloat radius; 
@property (nonatomic, assign) NSUInteger outerAnnulusLineCountToShow; 
@property (nonatomic, assign) CGFloat openAngle; 
@property (nonatomic, assign) NSUInteger minValue; 
@property (nonatomic, assign) NSUInteger maxValue;  
@property (nonatomic, assign) NSUInteger indicatorValue; 
@property (nonatomic, assign) BOOL enable; 
@property (nonatomic, assign) NSInteger centerValue; 
@property (nonatomic, strong) UILabel *centerValueLabel; 
@property (nonatomic, strong) UILabel *centerHintLabel;  
@property (nonatomic, strong) NSArray<NSNumber *> *innerAnnulusValueToShowArray; 
@property (nonatomic, assign) BOOL hotStatusOnOff;
#pragma mark - ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ 内部元素位置或尺寸比例 ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
@property (nonatomic, assign) CGFloat circleCenterX_ratio; 
@property (nonatomic, assign) CGFloat circleCenterY_ratio; 
@property (nonatomic, assign) CGFloat outerAnnulusInnerCircleRadius_ratio; 
@property (nonatomic, assign) CGFloat innerAnnulusInnerCircleRadius_ratio; 
@property (nonatomic, assign) CGFloat outerAnnulusRectangleWidht_ratio; 
@property (nonatomic, assign) CGFloat outerAnnulusRectangleHeight_ratio; 
@property (nonatomic, assign) CGFloat innerAnnulusRectangleWidht_ratio; 
@property (nonatomic, assign) CGFloat innerAnnulusRectangleHeight_ratio; 
@property (nonatomic, assign) CGFloat innerAnnulusScaleRectangleWidht_ratio; 
@property (nonatomic, assign) CGFloat innerAnnulusScaleRectangleHeight_ratio; 
@property (nonatomic, assign) CGFloat dotRadius_ratio; 
@property (nonatomic, assign) CGFloat outerAnnulusIndicatorLabelOffset_ratio; 
@property (nonatomic, assign) CGFloat outerAnnulusIndicatorLabelFontSize_ratio; 
@property (nonatomic, assign) CGFloat innerAnnulusScaleLabelOffset_ratio; 
@property (nonatomic, assign) CGFloat innerAnnulusScaleLabelFontSize_ratio; 
@property (nonatomic, assign) CGFloat centerValueLabelFontSize_ratio;
@property (nonatomic, assign) CGFloat centerHintLabelFontSize_ratio;
@property (nonatomic, assign) CGFloat centerValueLabelXOffset_ratio;
@property (nonatomic, assign) CGFloat centerValueLabelYOffset_ratio;
@property (nonatomic, assign) CGFloat centerHintLabelXOffset_ratio;
@property (nonatomic, assign) CGFloat centerHintLabelYOffset_ratio;
@property (nonatomic, assign) CGFloat hotStatusButtonWidth_ratio; 
@property (nonatomic, assign) CGFloat hotStatusButtonHeight_ratio; 
@property (nonatomic, assign) CGFloat hotStatusButtonXOffset_ratio;
@property (nonatomic, assign) CGFloat hotStatusButtonYOffset_ratio;
@property (nonatomic, assign) CGFloat minusButtonWidth_ratio;
@property (nonatomic, assign) CGFloat minusButtonHeight_ratio;
@property (nonatomic, assign) CGFloat addButtonWidth_ratio;
@property (nonatomic, assign) CGFloat addButtonHeight_ratio;
@property (nonatomic, assign) CGFloat minusAndAddButtonAngleOffset_ratio;
@property (nonatomic, assign) CGFloat minusAndAddButtonRadiusOffset_ratio;
#pragma mark - ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ end ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
@property (nonatomic, copy) void(^minusBlock)(void);
@property (nonatomic, copy) void(^addBlock)(void);
- (void)shineWithTimeInterval:(NSTimeInterval)timeInterval pauseDuration:(NSTimeInterval)pauseDuration finalValue:(NSUInteger)finalValue finishBlock:(void(^)(void))finishBlock;
- (void)clearIndicatorValue;
- (void)setIndicatorValue:(NSInteger)indicatorValue animated:(BOOL)animated;
@end
