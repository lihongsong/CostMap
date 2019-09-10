#import "CostMapGetImagePath.h"
@implementation CostMapGetImagePath
+(UIImage *)CostMapGetImagePath:(NSString *)imageName{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    return image;
}
@end
