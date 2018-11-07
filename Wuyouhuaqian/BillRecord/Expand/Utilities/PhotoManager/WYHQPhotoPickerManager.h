//
//  WYHQPhotoPickerManager.h
//  Wuyouhuaqian
//
//  Created by yoser on 2018/11/7.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^WYHQPhotoPickerBlock) ( UIImage * _Nullable image, NSError *error);

@interface WYHQPhotoPickerManager : NSObject

+ (instancetype)share;

/**
 弹窗选择相册或者相机

 @param viewCotroller 从什么控制器弹出
 */
- (void)photoPickerFromViewController:(UIViewController *)viewCotroller result:(WYHQPhotoPickerBlock)result;

@end

NS_ASSUME_NONNULL_END
