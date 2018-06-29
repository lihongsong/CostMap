//
//  UIImage+HJRemoteSize.h
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import <UIKit/UIKit.h>

typedef void (^HJUIImageSizeRequestCompleted) (NSURL* imgURL, CGSize size);

@interface UIImage (HJRemoteSize)

/**
 *  @brief 获取远程图片的大小
 *
 *  @param imgURL     图片url
 *  @param completion 完成回调
 */
+ (void)hj_requestSizeNoHeader:(NSURL*)imgURL completion:(HJUIImageSizeRequestCompleted)completion;

@end
