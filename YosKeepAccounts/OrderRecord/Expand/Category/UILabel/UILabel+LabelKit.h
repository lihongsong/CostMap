#import <UIKit/UIKit.h>
@interface UILabel (LabelKit)
- (CGRect)autosize;
- (CGRect)autosizeWithMaxWidth:(CGFloat)maxWidth;
- (CGRect)autosizeWithMaxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight;
- (void)addStrikeThrough;
- (void)addStrikeThroughWithTag:(NSInteger)tag;
- (void)addStrikethroughWithColor:(UIColor *)color midHeight:(CGFloat)midHeight tag:(NSInteger)tag;
- (void)removeStrikeThroughWithTag:(NSInteger)tag;
@end
