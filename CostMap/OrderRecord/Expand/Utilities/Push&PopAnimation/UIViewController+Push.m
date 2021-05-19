#import "UIViewController+Push.h"
#import "objc/runtime.h"
static NSString *kAnimateRect = @"kAnimateRect";
@implementation UIViewController (CostMapPush)
- (void)setAnimateRect:(CGRect)animateRect {
    objc_setAssociatedObject(self, &kAnimateRect, [NSValue valueWithCGRect:animateRect], OBJC_ASSOCIATION_RETAIN);
}
- (CGRect)animateRect {
    return [objc_getAssociatedObject(self, &kAnimateRect) CGRectValue];
}
@end
