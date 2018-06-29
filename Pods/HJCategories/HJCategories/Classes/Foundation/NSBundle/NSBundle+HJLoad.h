//
//  NSBundle+HJLoad.h
//  HJCategories
//
//  Created by yoser on 2018/1/4.
//

#import <Foundation/Foundation.h>

@interface NSBundle (HJLoad)

NS_ASSUME_NONNULL_BEGIN

/**
 通过 nib 的名称获取到 view

 @param className 类名
 @return view 的实例
 */
+ (nullable UIView *)hj_loadNibView:(NSString *)className;

/**
 通过 nib 的名称获取到 view

 @param className 类名
 @param bundle 在传入的 bundle 下进行扫描
 @return view 的实例
 */
+ (nullable UIView *)hj_loadNibView:(NSString *)className bundle:(NSBundle *)bundle;

/**
 通过 framework 的名称获取到 bundle

 @param frameworkName framework的名称
 @return bundle 的实例
 */
+ (NSBundle *)hj_loadFramework:(NSString *)frameworkName;

/**
 获取 mainbundle 目录下的子 bundle

 @param subBundleName  bundle 名称
 @return bundle 实例
 */
+ (NSBundle *)hj_loadSubBundle:(NSString *)subBundleName;

NS_ASSUME_NONNULL_END

@end
