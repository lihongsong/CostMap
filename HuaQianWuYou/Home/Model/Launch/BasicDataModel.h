//
//  BasicDataModel.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/2.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "BaseModel.h"
#import "BasicDataProtocol.h"
typedef NS_ENUM(NSInteger, AdvertisingType) {
    AdvertisingTypeStartPage,//启动图
    AdvertisingTypeAlert,//弹窗
    AdvertisingTypeSuspensionWindow //悬浮窗
};

@interface BasicDataInfo:NSObject<BasicDataProtocol>

NS_ASSUME_NONNULL_BEGIN

/*
 
 action    支持native的页面标识    string
 imageUrl    图片url    string
 needLogin    是否需要登录    boolean
 openType    打开方式    number
 redirectUrl    重定向url    string
 */

/************************************************************************************
 ************************************************************************************/
@property(nonatomic,copy)NSString *action;
@property(nonatomic,copy)NSString *imageUrl;
@property(nonatomic,assign)BOOL needLogin;
// 1：app内webview 2：native 3：外部浏览器
@property(nonatomic,strong)NSNumber *openType;
@property(nonatomic,copy)NSString *redirectUrl;

NS_ASSUME_NONNULL_END

@end

NS_ASSUME_NONNULL_BEGIN
@interface BasicDataModel : NSObject
@property(nonatomic, strong) NSArray<BasicDataInfo*> *acitveList;
@property(nonatomic,strong)NSNumber *versionStamp;

+ (void)cacheToLoacl:(BasicDataModel *)model withType:(AdvertisingType)type;

+ (BasicDataModel *)getCacheModel:(AdvertisingType)type;
@end

NS_ASSUME_NONNULL_END
