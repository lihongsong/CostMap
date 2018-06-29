//
//  UIImage+HJCompress.m
//  HJCategories
//
//  Created by yoser on 2018/4/28.
//

#import "UIImage+HJCompress.h"

@interface UIImageCompressTargetInfo: NSObject

@property (assign, nonatomic) CGSize size;

@property (assign, nonatomic) CGFloat storage;

@end

@implementation UIImageCompressTargetInfo

+ (instancetype)targetInfoWithStorage:(CGFloat)storage size:(CGSize)size {
    return [[UIImageCompressTargetInfo alloc] initWithStorage:storage size:size];
}

- (instancetype)initWithStorage:(CGFloat)storage size:(CGSize)size {
    if (self = [super init]) {
        self.size = size;
        self.storage = storage;
    }
    return self;
}

@end


@implementation UIImage (HJCompress)

+ (NSData *)hj_compressWithData:(NSData *)data {
    
    UIImage *image = [UIImage imageWithData:data];
    
    if (!image) {
        return data;
    }
    
    return [image hj_compress];
}

+ (NSData *)hj_compressWithData:(NSData *)data quality:(CGFloat)quality {
    
    UIImage *image = [UIImage imageWithData:data];
    
    if (!image) {
        return data;
    }
    return [image hj_compressByQuality:quality];
}

+ (NSData *)hj_compressWithData:(NSData *)data storage:(CGFloat)storage {
    
    if (storage > data.length / 1024) {
        return data;
    }
    
    UIImage *image = [UIImage imageWithData:data];
    
    if (!image) {
        return data;
    }
    
    return [image hj_compressByStorage:storage];
}

+ (NSData *)hj_compressWithData:(NSData *)data thumbSize:(CGSize)thumbSize {
    
    UIImage *image = [UIImage imageWithData:data];
    
    if (!image) {
        return data;
    }
    
    return [image hj_compressByThumbSize:thumbSize];
}

+ (NSData *)hj_compressWithData:(NSData *)data
                        storage:(CGFloat)storage
                      thumbSize:(CGSize)thumbSize {
    if (storage > data.length / 1024) {
        return data;
    }
    
    UIImage *image = [UIImage imageWithData:data];
    
    if (!image) {
        return data;
    }
    
    return [image hj_compressByStorage:storage thumbSize:thumbSize];
}


- (NSData *)hj_compressByStorage:(CGFloat)storage thumbSize:(CGSize)thumbSize {
    
    if (storage <= 0) {
        return UIImageJPEGRepresentation(self, 1.0f);
    }
    
    if (CGSizeEqualToSize(thumbSize, CGSizeZero)) {
        return UIImageJPEGRepresentation(self, 1.0f);
    }
    
    return [self compressByStorage:storage thumbSize:thumbSize quality:0.0f];
}

- (NSData *)hj_compress {
//    最高质量压缩系数为0.5 
    return [self compressByStorage:0 thumbSize:CGSizeZero quality:0.5f];
}

- (NSData *)hj_compressByQuality:(CGFloat)quality {
    
    if (quality < 0 || quality > 1) {
        return UIImageJPEGRepresentation(self, 1.0f);
    }
    
    UIImage *originImage = [self fixOrientation];
    
    NSData *imageData = UIImageJPEGRepresentation(originImage, quality);
    return imageData;
}

- (NSData *)hj_compressByThumbSize:(CGSize)thumbSize {
    
    if (CGSizeEqualToSize(CGSizeZero, thumbSize)) {
        return UIImageJPEGRepresentation(self, 1.0f);
    }
    
    UIImage *originImage = [self fixOrientation];
    
    return UIImageJPEGRepresentation([originImage resizeImageThumbSize:thumbSize], 1.0f);
}

- (NSData *)hj_compressByStorage:(CGFloat)storage {
    
    if (storage <= 0) {
        return UIImageJPEGRepresentation(self, 1.0f);
    }
    
    return [self compressByStorage:storage thumbSize:CGSizeZero quality:0.0f];
}


/**
 获取到期望压缩方案

 @return 压缩期望数据
 */
- (UIImageCompressTargetInfo *)compressImageTargetInfo {
    
    double storage;
    NSData *imageData = UIImageJPEGRepresentation(self, 1);
    
    int fixelW = (int)self.size.width;
    int fixelH = (int)self.size.height;
    int thumbW = fixelW % 2  == 1 ? fixelW + 1 : fixelW;
    int thumbH = fixelH % 2  == 1 ? fixelH + 1 : fixelH;
    
    double scale = ((double)fixelW/fixelH);
    
    if (scale <= 1 && scale > 0.5625) {
        
        if (fixelH < 1664) {
            if (imageData.length/1024.0 < 150) {
                return nil;
            }
            storage = (fixelW * fixelH) / pow(1664, 2) * 150;
            storage = storage < 60 ? 60 : storage;
        }
        else if (fixelH >= 1664 && fixelH < 4990) {
            thumbW = fixelW / 2;
            thumbH = fixelH / 2;
            storage = (thumbH * thumbW) / pow(2495, 2) * 300;
            storage = storage < 60 ? 60 : storage;
        }
        else if (fixelH >= 4990 && fixelH < 10240) {
            thumbW = fixelW / 4;
            thumbH = fixelH / 4;
            storage = (thumbW * thumbH) / pow(2560, 2) * 300;
            storage = storage < 100 ? 100 : storage;
        }
        else {
            int multiple = fixelH / 1280 == 0 ? 1 : fixelH / 1280;
            thumbW = fixelW / multiple;
            thumbH = fixelH / multiple;
            storage = (thumbW * thumbH) / pow(2560, 2) * 300;
            storage = storage < 100 ? 100 : storage;
        }
    }
    else if (scale <= 0.5625 && scale > 0.5) {
        
        if (fixelH < 1280 && imageData.length/1024 < 200) {
            return nil;
        }
        int multiple = fixelH / 1280 == 0 ? 1 : fixelH / 1280;
        thumbW = fixelW / multiple;
        thumbH = fixelH / multiple;
        storage = (thumbW * thumbH) / (1440.0 * 2560.0) * 400;
        storage = storage < 100 ? 100 : storage;
    }
    else {
        int multiple = (int)ceil(fixelH / (1280.0 / scale));
        thumbW = fixelW / multiple;
        thumbH = fixelH / multiple;
        storage = ((thumbW * thumbH) / (1280.0 * (1280 / scale))) * 600;
        storage = storage < 100 ? 100 : storage;
    }
    return [UIImageCompressTargetInfo targetInfoWithStorage:storage
                                                       size:CGSizeMake(thumbW, thumbH)];
}

- (NSData *)compressByStorage:(NSUInteger)storage
                        thumbSize:(CGSize)thumbSize
                          quality:(CGFloat)quality {
    
    UIImageCompressTargetInfo *info = [self compressImageTargetInfo];
    
    if (storage <= 0.0f) {
        storage = info.storage;
    }
    
    if (CGSizeEqualToSize(thumbSize, CGSizeZero)) {
        thumbSize = info.size;
    }
    
    UIImage *resizeImage;
    if (info) {
        resizeImage = [self resizeImageThumbSize:thumbSize];
    } else {
        resizeImage = self;
    }

    NSData *resizeImageData = UIImageJPEGRepresentation(resizeImage, 1.0f);
    
    // 如果已经满足 不需要进行质量压缩
    if (resizeImageData.length / 1024 < storage) {
        return resizeImageData;
    }
    
    NSData *imageData;
    if (quality > 0.0f && quality <= 1.0f) {
        imageData = UIImageJPEGRepresentation(resizeImage, quality);
    } else {
        imageData = [resizeImage compressDataQualityWithTargetStorage:storage];
    }
    
    return imageData;
}

/**
 通过质量系数进行压缩

 @param storage 期望值
 @return 图片数据
 */
- (NSData *)compressDataQualityWithTargetStorage:(CGFloat)storage {
    
    CGFloat qualityCompress = 1.0f;
    
    UIImage *originImage = [self fixOrientation];
    
    NSData *imageData = UIImageJPEGRepresentation(originImage, qualityCompress);
    
    NSUInteger lenght = imageData.length;
    
    if (storage <= 0) {
        return UIImageJPEGRepresentation(originImage, 0.5f);
    }
    
    while (lenght / 1024 > storage && qualityCompress > 0.05) {
        
        qualityCompress -= 0.05;
        imageData    = UIImageJPEGRepresentation(originImage, qualityCompress);
        lenght     = imageData.length;
    }
    
    return imageData;
}


/**
 压缩图片尺寸

 @param thumbSize 压缩后的尺寸
 @return 图片
 */
- (UIImage *)resizeImageThumbSize:(CGSize)thumbSize {
    
    int outW = (int)self.size.width;
    int outH = (int)self.size.height;
    
    int width = (int)thumbSize.width;
    int height = (int)thumbSize.height;
    
    int inSampleSize = 1;
    
    if (outW > width || outH > height) {
        int halfW = outW / 2;
        int halfH = outH / 2;
        
        while ((halfH / inSampleSize) > height && (halfW / inSampleSize) > width) {
            inSampleSize *= 2;
        }
    }
    int heightRatio = (int)ceil(outH / (float) height);
    int widthRatio  = (int)ceil(outW / (float) width);
    
    if (heightRatio > 1 || widthRatio > 1) {
        
        inSampleSize = heightRatio > widthRatio ? heightRatio : widthRatio;
    }
    CGSize tempThumbSize = CGSizeMake((NSUInteger)((CGFloat)outW/inSampleSize), (NSUInteger)((CGFloat)outH/inSampleSize));
    
    UIGraphicsBeginImageContext(tempThumbSize);
    
    [self drawInRect:CGRectMake(0, 0, tempThumbSize.width, tempThumbSize.height)];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}

/**
 修正图片的方向

 @return 修正后的图片
 */
- (UIImage *)fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
