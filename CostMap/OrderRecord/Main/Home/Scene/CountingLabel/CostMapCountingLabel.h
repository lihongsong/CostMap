#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CostMapLabelCountingMethod) {
    CostMapLabelCountingMethodEaseInOut,
    CostMapLabelCountingMethodEaseIn,
    CostMapLabelCountingMethodEaseOut,
    CostMapLabelCountingMethodLinear,
    CostMapLabelCountingMethodEaseInBounce,
    CostMapLabelCountingMethodEaseOutBounce
};
typedef NSString* (^CostMapCountingLabelFormatBlock)(CGFloat value);
typedef NSAttributedString* (^CostMapCountingLabelAttributedFormatBlock)(CGFloat value);
@interface CostMapCountingLabel : UILabel
@property (nonatomic, strong) NSString *format;
@property (nonatomic, assign) CostMapLabelCountingMethod method;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, copy) CostMapCountingLabelFormatBlock formatBlock;
@property (nonatomic, copy) CostMapCountingLabelAttributedFormatBlock attributedFormatBlock;
@property (nonatomic, copy) void (^completionBlock)(void);
-(void)countFrom:(CGFloat)startValue to:(CGFloat)endValue;
-(void)countFrom:(CGFloat)startValue to:(CGFloat)endValue withDuration:(NSTimeInterval)duration;
-(void)countFromCurrentValueTo:(CGFloat)endValue;
-(void)countFromCurrentValueTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration;
-(void)countFromZeroTo:(CGFloat)endValue;
-(void)countFromZeroTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration;
- (CGFloat)currentValue;
@end
