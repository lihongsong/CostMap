//
//  UIImage+HJMerge.h
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import <UIKit/UIKit.h>

@interface UIImage (HJMerge)

/**
 *  @brief  合并两个图片
 *
 *  @param firstImage  一个图片
 *  @param secondImage 二个图片
 *
 *  @return 合并后图片
 */
+ (UIImage*)hj_mergeImage:(UIImage *)firstImage withImage:(UIImage *)secondImage;


@end
