//
//  UIImage+HJFXImage.m
//  HJCategories
//
//  Created by yoser on 2017/12/15.
//

#import "UIImage+HJFXImage.h"

@implementation UIImage (HJFXImage)

- (UIImage *)hj_imageCroppedToRect:(CGRect)rect
{
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    
    //draw
    [self drawAtPoint:CGPointMake(-rect.origin.x, -rect.origin.y)];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}

- (UIImage *)hj_imageScaledToSize:(CGSize)size
{
    //avoid redundant drawing
    if (CGSizeEqualToSize(self.size, size))
    {
        return self;
    }
    
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    //draw
    [self drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}

- (UIImage *)hj_imageScaledToFitSize:(CGSize)size
{
    //calculate rect
    CGFloat aspect = self.size.width / self.size.height;
    if (size.width / aspect <= size.height)
    {
        return [self hj_imageScaledToSize:CGSizeMake(size.width, size.width / aspect)];
    }
    else
    {
        return [self hj_imageScaledToSize:CGSizeMake(size.height * aspect, size.height)];
    }
}

- (UIImage *)hj_imageScaledToFillSize:(CGSize)size
{
    if (CGSizeEqualToSize(self.size, size))
    {
        return self;
    }
    //calculate rect
    CGFloat aspect = self.size.width / self.size.height;
    if (size.width / aspect >= size.height)
    {
        return [self hj_imageScaledToSize:CGSizeMake(size.width, size.width / aspect)];
    }
    else
    {
        return [self hj_imageScaledToSize:CGSizeMake(size.height * aspect, size.height)];
    }
}

+ (CGImageRef)hj_gradientMask
{
    static CGImageRef sharedMask = NULL;
    if (sharedMask == NULL)
    {
        //create gradient mask
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 256), YES, 0.0);
        CGContextRef gradientContext = UIGraphicsGetCurrentContext();
        CGFloat colors[] = {0.0, 1.0, 1.0, 1.0};
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
        CGPoint gradientStartPoint = CGPointMake(0, 0);
        CGPoint gradientEndPoint = CGPointMake(0, 256);
        CGContextDrawLinearGradient(gradientContext, gradient, gradientStartPoint,
                                    gradientEndPoint, kCGGradientDrawsAfterEndLocation);
        sharedMask = CGBitmapContextCreateImage(gradientContext);
        CGGradientRelease(gradient);
        CGColorSpaceRelease(colorSpace);
        UIGraphicsEndImageContext();
    }
    return sharedMask;
}

- (UIImage *)hj_reflectedImageWithScale:(CGFloat)scale
{
    //get reflection dimensions
    CGFloat height = ceil(self.size.height * scale);
    CGSize size = CGSizeMake(self.size.width, height);
    CGRect bounds = CGRectMake(0.0f, 0.0f, size.width, size.height);
    
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //clip to gradient
    CGContextClipToMask(context, bounds, [[self class] hj_gradientMask]);
    
    //draw reflected image
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGContextTranslateCTM(context, 0.0f, -self.size.height);
    [self drawInRect:CGRectMake(0.0f, 0.0f, self.size.width, self.size.height)];
    
    //capture resultant image
    UIImage *reflection = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return reflection image
    return reflection;
}

- (UIImage *)hj_imageWithReflectionWithScale:(CGFloat)scale gap:(CGFloat)gap alpha:(CGFloat)alpha
{
    //get reflected image
    UIImage *reflection = [self hj_reflectedImageWithScale:scale];
    CGFloat reflectionOffset = reflection.size.height + gap;
    
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.size.width, self.size.height + reflectionOffset * 2.0f), NO, 0.0f);
    
    //draw reflection
    [reflection drawAtPoint:CGPointMake(0.0f, reflectionOffset + self.size.height + gap) blendMode:kCGBlendModeNormal alpha:alpha];
    
    //draw image
    [self drawAtPoint:CGPointMake(0.0f, reflectionOffset)];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}

- (UIImage *)hj_imageWithShadowColor:(UIColor *)color offset:(CGSize)offset blur:(CGFloat)blur
{
    //get size
    //CGSize border = CGSizeMake(fabsf(offset.width) + blur, fabsf(offset.height) + blur);
    CGSize border = CGSizeMake(fabs(offset.width) + blur, fabs(offset.height) + blur);
    
    CGSize size = CGSizeMake(self.size.width + border.width * 2.0f, self.size.height + border.height * 2.0f);
    
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //set up shadow
    CGContextSetShadowWithColor(context, offset, blur, color.CGColor);
    
    //draw with shadow
    [self drawAtPoint:CGPointMake(border.width, border.height)];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}

- (UIImage *)hj_imageWithCornerRadius:(CGFloat)radius
{
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //clip image
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0.0f, radius);
    CGContextAddLineToPoint(context, 0.0f, self.size.height - radius);
    CGContextAddArc(context, radius, self.size.height - radius, radius, M_PI, M_PI / 2.0f, 1);
    CGContextAddLineToPoint(context, self.size.width - radius, self.size.height);
    CGContextAddArc(context, self.size.width - radius, self.size.height - radius, radius, M_PI / 2.0f, 0.0f, 1);
    CGContextAddLineToPoint(context, self.size.width, radius);
    CGContextAddArc(context, self.size.width - radius, radius, radius, 0.0f, -M_PI / 2.0f, 1);
    CGContextAddLineToPoint(context, radius, 0.0f);
    CGContextAddArc(context, radius, radius, radius, -M_PI / 2.0f, M_PI, 1);
    CGContextClip(context);
    
    //draw image
    [self drawAtPoint:CGPointZero];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}

- (UIImage *)hj_imageWithAlpha:(CGFloat)alpha
{
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    //draw with alpha
    [self drawAtPoint:CGPointZero blendMode:kCGBlendModeNormal alpha:alpha];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}

- (UIImage *)hj_imageWithMask:(UIImage *)maskImage;
{
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //apply mask
    CGContextClipToMask(context, CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), maskImage.CGImage);
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    //draw image
    CGContextDrawImage(context, rect, self.CGImage);
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}

- (UIImage *)hj_maskImageFromImageAlpha
{
    //get dimensions
    NSInteger width = CGImageGetWidth(self.CGImage);
    NSInteger height = CGImageGetHeight(self.CGImage);
    
    //create alpha image
    NSInteger bytesPerRow = ((width + 3) / 4) * 4;
    void *data = calloc(bytesPerRow * height, sizeof(unsigned char *));
    CGContextRef context = CGBitmapContextCreate(data, width, height, 8, bytesPerRow, NULL, kCGImageAlphaOnly);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, width, height), self.CGImage);
    
    //invert alpha pixels
    for (int y = 0; y < height; y++)
    {
        for (int x = 0; x < width; x++)
        {
            NSInteger index = y * bytesPerRow + x;
            ((unsigned char *)data)[index] = 255 - ((unsigned char *)data)[index];
        }
    }
    
    //create mask image
    CGImageRef maskRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    UIImage *mask = [UIImage imageWithCGImage:maskRef];
    CGImageRelease(maskRef);
    free(data);
    
    //return image
    return mask;
}

@end
