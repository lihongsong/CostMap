//
//  UIImage+HJCompress.h
//  HJCategories
//
//  Created by yoser on 2018/4/28.
//

#import <UIKit/UIKit.h>

@interface UIImage (HJCompress)

/**
 图片容量压缩到传入的质量系数 （不尺寸压缩）

 @param data 图像原始数据
 @param quality 质量系数 0 ~ 1.0f
 @return 图片
 */
+ (NSData *)hj_compressWithData:(NSData *)data
                        quality:(CGFloat)quality;

/**
 图片容量使用传入尺寸进行压缩（不质量压缩）
 
 @param data 图像原始数据
 @param thumbSize 是否改变图片尺寸
 @return 图片
 */
+ (NSData *)hj_compressWithData:(NSData *)data
                      thumbSize:(CGSize)thumbSize;

/**
 图片尺寸比例压缩到固定尺寸以下，图片容量压缩到固定容量（单位 KB）以下 (定制尺寸压缩 & 自动进行质量压缩)
 
 @param data 图像原始数据
 @param storage 期望压缩后图片容量
 @param thumbSize 固定尺寸
 @return 图片
 */
+ (NSData *)hj_compressWithData:(NSData *)data
                        storage:(CGFloat)storage
                      thumbSize:(CGSize)thumbSize;

/**
 图片容量压缩到固定容量（单位 KB）以下 (自动进行尺寸压缩 & 自动进行质量压缩)
 
 @param data 图像原始数据
 @param storage 期望压缩后图片容量
 @return 图片
 */
+ (NSData *)hj_compressWithData:(NSData *)data
                        storage:(CGFloat)storage;

/**
 图片压缩到最佳压缩质量 （计算最佳固定容量 自动进行尺寸压缩 & 自动进行质量压缩）
 
 @param data 图像原始数据
 @return 图片
 */
+ (NSData *)hj_compressWithData:(NSData *)data;

/**
 图片容量压缩到传入的质量系数 （不尺寸压缩）

 @param quality 质量系数 0 ~ 1.0f
 @return 图片
 */
- (NSData *)hj_compressByQuality:(CGFloat)quality;

/**
 图片容量使用传入尺寸进行压缩（不质量压缩）

 @param thumbSize 是否改变图片尺寸
 @return 图片
 */
- (NSData *)hj_compressByThumbSize:(CGSize)thumbSize;

/**
 图片尺寸比例压缩到固定尺寸以下，图片容量压缩到固定容量（单位 KB）以下 (定制尺寸压缩 & 自动进行质量压缩)

 @param storage 期望压缩后图片容量
 @param thumbSize 固定尺寸
 @return 图片
 */
- (NSData *)hj_compressByStorage:(CGFloat)storage thumbSize:(CGSize)thumbSize;

/**
 图片容量压缩到固定容量（单位 KB）以下 (自动进行尺寸压缩 & 自动进行质量压缩)

 @param storage 期望压缩后图片容量
 @return 图片
 */
- (NSData *)hj_compressByStorage:(CGFloat)storage;

/**
 图片压缩到最佳压缩质量 （计算最佳固定容量 自动进行尺寸压缩 & 自动进行质量压缩）

 @return 图片
 */
- (NSData *)hj_compress;

@end
