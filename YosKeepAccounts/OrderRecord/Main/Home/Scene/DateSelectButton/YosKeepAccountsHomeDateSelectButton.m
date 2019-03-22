#import "YosKeepAccountsHomeDateSelectButton.h"
@implementation YosKeepAccountsHomeDateSelectButton
#pragma mark - Life Cycle
#pragma mark - Getter & Setter Methods
#pragma mark - Public Method
#pragma mark - Private Method
#pragma mark - Notification Method
#pragma mark - Event & Target Methods
#pragma mark - Super Method
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat w = 10;
    CGFloat h = 6;
    CGFloat x = contentRect.size.width - w;
    CGFloat y = (contentRect.size.height - h) * 0.5;
    return CGRectMake(x, y, w, h);
}
@end
