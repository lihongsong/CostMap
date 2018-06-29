//
//  UIImage+HJFXImage.h
//  HJCategories
//
//  Created by yoser on 2017/12/15.
//

#import <UIKit/UIKit.h>

@interface UIImage (HJFXImage)

/**
 裁剪图片

 @param rect 图片上的尺寸
 @return 裁剪后的图片
 */
- (UIImage *)hj_imageCroppedToRect:(CGRect)rect;

/**
 对图片进行缩放

 @param size 缩放的大小
 @return 缩放后的图片
 */
- (UIImage *)hj_imageScaledToSize:(CGSize)size;

/**
 使用ScaledToFit样式对图片进行缩放 (等比例填充)

 @param size 缩放的大小
 @return 缩放后的图片
 */
- (UIImage *)hj_imageScaledToFitSize:(CGSize)size;

/**
 使用ScaledToFill样式对图片进行缩放 (等比例充满)

 @param size 缩放的大小
 @return 缩放后的图片
 */
- (UIImage *)hj_imageScaledToFillSize:(CGSize)size;



- (UIImage *)hj_reflectedImageWithScale:(CGFloat)scale;


- (UIImage *)hj_imageWithReflectionWithScale:(CGFloat)scale gap:(CGFloat)gap alpha:(CGFloat)alpha;


- (UIImage *)hj_imageWithShadowColor:(UIColor *)color offset:(CGSize)offset blur:(CGFloat)blur;


/**
 对图片进行圆角裁剪处理

 @param radius 圆角值
 @return 处理后的图片
 */
- (UIImage *)hj_imageWithCornerRadius:(CGFloat)radius;

/**
 对图片进行透明度处理

 @param alpha 透明度值
 @return 处理后的图片
 */
- (UIImage *)hj_imageWithAlpha:(CGFloat)alpha;


/**
 对图片进行mask裁剪

 @param maskImage 提供mask的图片
 @return 处理后的图片
 */
- (UIImage *)hj_imageWithMask:(UIImage *)maskImage;

/**
 通过alpha通道对图片进行mask裁剪

 @return 处理后的图片
 */
- (UIImage *)hj_maskImageFromImageAlpha;


@end
