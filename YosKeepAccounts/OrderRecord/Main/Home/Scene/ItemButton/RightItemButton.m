#import "RightItemButton.h"
@implementation RightItemButton
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(19.5, 0, self.frame.size.width- 14.5, self.frame.size.height);
}
- (CGRect)imageRectForContentRect:(CGRect)bounds{
    return CGRectMake(0, (self.frame.size.height-14.5)/2, 14.5, 14.5);
}
@end
