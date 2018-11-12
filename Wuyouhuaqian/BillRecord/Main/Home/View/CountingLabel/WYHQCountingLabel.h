#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WYHQLabelCountingMethod) {
    WYHQLabelCountingMethodEaseInOut,
    WYHQLabelCountingMethodEaseIn,
    WYHQLabelCountingMethodEaseOut,
    WYHQLabelCountingMethodLinear,
    WYHQLabelCountingMethodEaseInBounce,
    WYHQLabelCountingMethodEaseOutBounce
};

typedef NSString* (^WYHQCountingLabelFormatBlock)(CGFloat value);
typedef NSAttributedString* (^WYHQCountingLabelAttributedFormatBlock)(CGFloat value);

@interface WYHQCountingLabel : UILabel

@property (nonatomic, strong) NSString *format;
@property (nonatomic, assign) WYHQLabelCountingMethod method;
@property (nonatomic, assign) NSTimeInterval animationDuration;

@property (nonatomic, copy) WYHQCountingLabelFormatBlock formatBlock;
@property (nonatomic, copy) WYHQCountingLabelAttributedFormatBlock attributedFormatBlock;
@property (nonatomic, copy) void (^completionBlock)(void);

-(void)countFrom:(CGFloat)startValue to:(CGFloat)endValue;
-(void)countFrom:(CGFloat)startValue to:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

-(void)countFromCurrentValueTo:(CGFloat)endValue;
-(void)countFromCurrentValueTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

-(void)countFromZeroTo:(CGFloat)endValue;
-(void)countFromZeroTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

- (CGFloat)currentValue;

@end

