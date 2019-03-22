#import <QuartzCore/QuartzCore.h>
#import "YosKeepAccountsCountingLabel.h"
#if !__has_feature(objc_arc)
#error YosKeepAccountsCountingLabel is ARC only. Either turn on ARC for the project or use -fobjc-arc flag
#endif
#pragma mark - YosKeepAccountsLabelCounter
#ifndef kYosKeepAccountsLabelCounterRate
#define kYosKeepAccountsLabelCounterRate 3.0
#endif
@protocol YosKeepAccountsLabelCounter <NSObject>
- (CGFloat)update:(CGFloat)t;
@end
@interface YosKeepAccountsLabelCounterLinear : NSObject<YosKeepAccountsLabelCounter>
@end
@interface YosKeepAccountsLabelCounterEaseIn : NSObject<YosKeepAccountsLabelCounter>
@end
@interface YosKeepAccountsLabelCounterEaseOut : NSObject<YosKeepAccountsLabelCounter>
@end
@interface YosKeepAccountsLabelCounterEaseInOut : NSObject<YosKeepAccountsLabelCounter>
@end
@interface YosKeepAccountsLabelCounterEaseInBounce : NSObject<YosKeepAccountsLabelCounter>
@end
@interface YosKeepAccountsLabelCounterEaseOutBounce : NSObject<YosKeepAccountsLabelCounter>
@end
@implementation YosKeepAccountsLabelCounterLinear
-(CGFloat)update:(CGFloat)t
{
    return t;
}
@end
@implementation YosKeepAccountsLabelCounterEaseIn
-(CGFloat)update:(CGFloat)t
{
    return powf(t, kYosKeepAccountsLabelCounterRate);
}
@end
@implementation YosKeepAccountsLabelCounterEaseOut
-(CGFloat)update:(CGFloat)t{
    return 1.0-powf((1.0-t), kYosKeepAccountsLabelCounterRate);
}
@end
@implementation YosKeepAccountsLabelCounterEaseInOut
-(CGFloat) update: (CGFloat) t
{
    t *= 2;
    if (t < 1)
        return 0.5f * powf (t, kYosKeepAccountsLabelCounterRate);
    else
        return 0.5f * (2.0f - powf(2.0 - t, kYosKeepAccountsLabelCounterRate));
}
@end
@implementation YosKeepAccountsLabelCounterEaseInBounce
-(CGFloat) update: (CGFloat) t {
    if (t < 4.0 / 11.0) {
        return 1.0 - (powf(11.0 / 4.0, 2) * powf(t, 2)) - t;
    }
    if (t < 8.0 / 11.0) {
        return 1.0 - (3.0 / 4.0 + powf(11.0 / 4.0, 2) * powf(t - 6.0 / 11.0, 2)) - t;
    }
    if (t < 10.0 / 11.0) {
        return 1.0 - (15.0 /16.0 + powf(11.0 / 4.0, 2) * powf(t - 9.0 / 11.0, 2)) - t;
    }
    return 1.0 - (63.0 / 64.0 + powf(11.0 / 4.0, 2) * powf(t - 21.0 / 22.0, 2)) - t;
}
@end
@implementation YosKeepAccountsLabelCounterEaseOutBounce
-(CGFloat) update: (CGFloat) t {
    if (t < 4.0 / 11.0) {
        return powf(11.0 / 4.0, 2) * powf(t, 2);
    }
    if (t < 8.0 / 11.0) {
        return 3.0 / 4.0 + powf(11.0 / 4.0, 2) * powf(t - 6.0 / 11.0, 2);
    }
    if (t < 10.0 / 11.0) {
        return 15.0 /16.0 + powf(11.0 / 4.0, 2) * powf(t - 9.0 / 11.0, 2);
    }
    return 63.0 / 64.0 + powf(11.0 / 4.0, 2) * powf(t - 21.0 / 22.0, 2);
}
@end
#pragma mark - YosKeepAccountsCountingLabel
@interface YosKeepAccountsCountingLabel ()
@property CGFloat startingValue;
@property CGFloat destinationValue;
@property NSTimeInterval progress;
@property NSTimeInterval lastUpdate;
@property NSTimeInterval totalTime;
@property CGFloat easingRate;
@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, strong) id<YosKeepAccountsLabelCounter> counter;
@end
@implementation YosKeepAccountsCountingLabel
-(void)countFrom:(CGFloat)value to:(CGFloat)endValue {
    if (self.animationDuration == 0.0f) {
        self.animationDuration = 2.0f;
    }
    [self countFrom:value to:endValue withDuration:self.animationDuration];
}
-(void)countFrom:(CGFloat)startValue to:(CGFloat)endValue withDuration:(NSTimeInterval)duration {
    self.startingValue = startValue;
    self.destinationValue = endValue;
    [self.timer invalidate];
    self.timer = nil;
    if(self.format == nil) {
        self.format = @"%f";
    }
    if (duration == 0.0) {
        [self setTextValue:endValue];
        [self runCompletionBlock];
        return;
    }
    self.easingRate = 3.0f;
    self.progress = 0;
    self.totalTime = duration;
    self.lastUpdate = [NSDate timeIntervalSinceReferenceDate];
    switch(self.method)
    {
        case YosKeepAccountsLabelCountingMethodLinear:
            self.counter = [[YosKeepAccountsLabelCounterLinear alloc] init];
            break;
        case YosKeepAccountsLabelCountingMethodEaseIn:
            self.counter = [[YosKeepAccountsLabelCounterEaseIn alloc] init];
            break;
        case YosKeepAccountsLabelCountingMethodEaseOut:
            self.counter = [[YosKeepAccountsLabelCounterEaseOut alloc] init];
            break;
        case YosKeepAccountsLabelCountingMethodEaseInOut:
            self.counter = [[YosKeepAccountsLabelCounterEaseInOut alloc] init];
            break;
        case YosKeepAccountsLabelCountingMethodEaseOutBounce:
            self.counter = [[YosKeepAccountsLabelCounterEaseOutBounce alloc] init];
            break;
        case YosKeepAccountsLabelCountingMethodEaseInBounce:
            self.counter = [[YosKeepAccountsLabelCounterEaseInBounce alloc] init];
            break;
    }
    CADisplayLink *timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateValue:)];
    timer.frameInterval = 2;
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:UITrackingRunLoopMode];
    self.timer = timer;
}
- (void)countFromCurrentValueTo:(CGFloat)endValue {
    [self countFrom:[self currentValue] to:endValue];
}
- (void)countFromCurrentValueTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration {
    [self countFrom:[self currentValue] to:endValue withDuration:duration];
}
- (void)countFromZeroTo:(CGFloat)endValue {
    [self countFrom:0.0f to:endValue];
}
- (void)countFromZeroTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration {
    [self countFrom:0.0f to:endValue withDuration:duration];
}
- (void)updateValue:(NSTimer *)timer {
    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    self.progress += now - self.lastUpdate;
    self.lastUpdate = now;
    if (self.progress >= self.totalTime) {
        [self.timer invalidate];
        self.timer = nil;
        self.progress = self.totalTime;
    }
    [self setTextValue:[self currentValue]];
    if (self.progress == self.totalTime) {
        [self runCompletionBlock];
    }
}
- (void)setTextValue:(CGFloat)value
{
    if (self.attributedFormatBlock != nil) {
        self.attributedText = self.attributedFormatBlock(value);
    }
    else if(self.formatBlock != nil)
    {
        self.text = self.formatBlock(value);
    }
    else
    {
        if([self.format rangeOfString:@"%(.*)d" options:NSRegularExpressionSearch].location != NSNotFound || [self.format rangeOfString:@"%(.*)i"].location != NSNotFound )
        {
            self.text = [NSString stringWithFormat:self.format,(int)value];
        }
        else
        {
            self.text = [NSString stringWithFormat:self.format,value];
        }
    }
}
- (void)setFormat:(NSString *)format {
    _format = format;
    [self setTextValue:self.currentValue];
}
- (void)runCompletionBlock {
    if (self.completionBlock) {
        self.completionBlock();
        self.completionBlock = nil;
    }
}
- (CGFloat)currentValue {
    if (self.progress >= self.totalTime) {
        return self.destinationValue;
    }
    CGFloat percent = self.progress / self.totalTime;
    CGFloat updateVal = [self.counter update:percent];
    return self.startingValue + (updateVal * (self.destinationValue - self.startingValue));
}
@end
