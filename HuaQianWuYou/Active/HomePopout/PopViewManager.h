//
//  PopViewManager.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/4.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicDataModel.h"
@protocol PopViewManagerDelegate <NSObject>

- (void)didSelectedContent:(BasicDataModel *)dataModel popType:(AdvertisingType)type;

@end

@interface PopViewManager : NSObject

@property (nonatomic, strong) id<PopViewManagerDelegate>  delegate;

+ (nonnull instancetype)sharedInstance;

/**
 显示弹款

 @param type 弹框类型 （首页弹框 - 悬浮弹框）
 @param controller 显示的Controller
 */
+ (void)showType:(AdvertisingType)type fromVC:(UIViewController *)controller;

+ (void)isHiddenCustomView:(BOOL)isHidden withType:(AdvertisingType)type;
    
@end
