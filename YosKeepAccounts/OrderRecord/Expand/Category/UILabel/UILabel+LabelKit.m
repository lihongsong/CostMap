#import "UILabel+LabelKit.h"
#import "NSString+LabelKit.h"
#import "UIView+SceneKit.h"
@implementation UILabel (LabelKit)
- (CGRect)autosize{
    NSString *text = self.attributedText.length ? self.attributedText.string : self.text;
    CGRect bounds = [text autosizeWithFont:self.font];
    self.size = bounds.size;
    return self.frame;
}
- (CGRect)autosizeWithMaxWidth:(CGFloat)maxWidth{
    if (maxWidth == 0) return [self autosize];
    NSString *text = self.attributedText.length ? self.attributedText.string : self.text;
    CGRect bounds = [text autosizeWithFont:self.font maxWidth:maxWidth];
    self.size = bounds.size;
    self.numberOfLines = 0;
    return self.frame;
}
- (CGRect)autosizeWithMaxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight{
    if (maxHeight == 0) return [self autosizeWithMaxWidth:maxWidth];
    NSString *text = self.attributedText.length ? self.attributedText.string : self.text;
    CGRect bounds = [text autosizeWithFont:self.font maxWidth:maxWidth maxHeight:maxHeight];
    self.size = bounds.size;
    self.numberOfLines = 0;
    return self.frame;
}
- (void)addStrikeThrough {
    [self addStrikeThroughWithTag:0];
}
- (void)addStrikeThroughWithTag:(NSInteger)tag {
    [self removeStrikeThroughWithTag:tag];
    [self addStrikethroughWithColor:self.textColor midHeight:self.halfHeight tag:tag];
}
- (void)addStrikethroughWithColor:(UIColor *)color midHeight:(CGFloat)midHeight tag:(NSInteger)tag {
    UIView *strikeThrough = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 1)];
    strikeThrough.backgroundColor = color;
    strikeThrough.tag = tag;
    [strikeThrough setMidY:midHeight];
    [self addSubview:strikeThrough];
}
- (void)removeStrikeThroughWithTag:(NSInteger)tag {
    UIView *strikeThrough = [self viewWithTag:tag];
    [strikeThrough removeFromSuperview];
}
@end
