#import "YosKeepAccountsHomeDateSelectButton.h"
@implementation YosKeepAccountsHomeDateSelectButton


- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat w = 10;
    CGFloat h = 6;
    CGFloat x = contentRect.size.width - w;
    CGFloat y = (contentRect.size.height - h) * 0.5;
    return CGRectMake(x, y, w, h);
}
@end
