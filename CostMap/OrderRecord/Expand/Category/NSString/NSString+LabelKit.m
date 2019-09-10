#import "NSString+LabelKit.h"
@implementation NSString (LabelKit)
- (CGRect)autosizeWithFont:(UIFont *)font{
    CGRect bounds = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return bounds;
}
- (CGRect)autosizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth{
    if (maxWidth == 0) return [self autosizeWithFont:font];
    CGRect bounds = [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    bounds.size.width = maxWidth;
    return bounds;
}
- (CGRect)autosizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight{
    if (maxHeight == 0) [self autosizeWithFont:font maxWidth:maxHeight];
    CGRect bounds = [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    bounds.size.width = maxWidth;
    bounds.size.height = MIN(CGRectGetHeight(bounds), maxHeight);
    return bounds;
}
@end
