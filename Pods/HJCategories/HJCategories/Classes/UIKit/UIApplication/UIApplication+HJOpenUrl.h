//
//  UIApplication+HJOpenUrl.h
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import <UIKit/UIKit.h>

@interface UIApplication (HJOpenUrl)

NS_ASSUME_NONNULL_BEGIN

/**
 openURL 兼容 ios2 以上

 @param url url地址
 @param options 参数
 @param completion 完成回调
 */
+ (void)hj_openURL:(NSURL *)url
           options:(NSDictionary<NSString *, id> *)options
 completionHandler:(void (^ __nullable)(BOOL success))completion;

NS_ASSUME_NONNULL_END

@end
