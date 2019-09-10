#import <Foundation/Foundation.h>
@interface NSString (LabelKit)
- (CGRect)autosizeWithFont:(UIFont*)font;
- (CGRect)autosizeWithFont:(UIFont*)font maxWidth:(CGFloat)maxWidth;
- (CGRect)autosizeWithFont:(UIFont*)font maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight;
@end
