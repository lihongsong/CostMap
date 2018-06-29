//
//  UIImage+HJGIF.h
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import <UIKit/UIKit.h>

@interface UIImage (HJGIF)

/**
 根据 GIF 文件名生成 GIF image

 @param name GIF 文件名
 @return GIF image
 */
+ (UIImage *)jk_animatedGIFNamed:(NSString *)name;

/**
 根据 GIF Data 数据生成 GIF image

 @param data GIF Data
 @return GIF image
 */
+ (UIImage *)jk_animatedGIFWithData:(NSData *)data;

/**
 将 GIF image 进行 size 规格的缩放裁剪

 @param size 裁剪的最终大小
 @return 裁剪后的图片
 */
- (UIImage *)jk_animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end
