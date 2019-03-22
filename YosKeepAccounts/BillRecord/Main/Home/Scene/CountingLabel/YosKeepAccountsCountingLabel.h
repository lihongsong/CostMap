#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, YosKeepAccountsLabelCountingMethod) {
    YosKeepAccountsLabelCountingMethodEaseInOut,
    YosKeepAccountsLabelCountingMethodEaseIn,
    YosKeepAccountsLabelCountingMethodEaseOut,
    YosKeepAccountsLabelCountingMethodLinear,
    YosKeepAccountsLabelCountingMethodEaseInBounce,
    YosKeepAccountsLabelCountingMethodEaseOutBounce
};
typedef NSString* (^YosKeepAccountsCountingLabelFormatBlock)(CGFloat value);
typedef NSAttributedString* (^YosKeepAccountsCountingLabelAttributedFormatBlock)(CGFloat value);
@interface YosKeepAccountsCountingLabel : UILabel
@property (nonatomic, strong) NSString *format;
@property (nonatomic, assign) YosKeepAccountsLabelCountingMethod method;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, copy) YosKeepAccountsCountingLabelFormatBlock formatBlock;
@property (nonatomic, copy) YosKeepAccountsCountingLabelAttributedFormatBlock attributedFormatBlock;
@property (nonatomic, copy) void (^completionBlock)(void);
-(void)countFrom:(CGFloat)startValue to:(CGFloat)endValue;
-(void)countFrom:(CGFloat)startValue to:(CGFloat)endValue withDuration:(NSTimeInterval)duration;
-(void)countFromCurrentValueTo:(CGFloat)endValue;
-(void)countFromCurrentValueTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration;
-(void)countFromZeroTo:(CGFloat)endValue;
-(void)countFromZeroTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration;
- (CGFloat)currentValue;
@end
