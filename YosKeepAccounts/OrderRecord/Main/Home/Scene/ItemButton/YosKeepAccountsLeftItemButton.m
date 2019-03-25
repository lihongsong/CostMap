#import "YosKeepAccountsLeftItemButton.h"
@implementation YosKeepAccountsLeftItemButton
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(17.5, 0, self.frame.size.width - 12.5, self.frame.size.height);
}
- (CGRect)imageRectForContentRect:(CGRect)bounds{
    return CGRectMake(0, (self.frame.size.height-16)/2, 12.5, 16);
}
@end
