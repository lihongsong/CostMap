#import "GetImagePath.h"
@implementation GetImagePath
+(UIImage *)getImagePath:(NSString *)imageName{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    return image;
}
@end
