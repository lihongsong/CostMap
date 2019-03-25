#import "YosKeepAccountsButton.h"
#import "UIColor+YKAAddColor.h"
@implementation YosKeepAccountsButton
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, -0.5, self.frame.size.width/2.0 + 20, self.frame.size.height);
}
- (CGRect)imageRectForContentRect:(CGRect)bounds{
    return CGRectMake(self.frame.size.width/2.0 + 30, (self.frame.size.height-7)/2 - 0.5 , 14, 7);
}
@end
