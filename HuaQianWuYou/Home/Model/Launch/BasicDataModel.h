//
//  BasicDataModel.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/2.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "BaseModel.h"
#import "HQWYActionHandlerProtocol.h"
typedef NS_ENUM(NSInteger, AdvertisingType) {
    AdvertisingTypeStartPage,//启动图
    AdvertisingTypeAlert,//弹窗
    AdvertisingTypeSuspensionWindow //悬浮窗
};

@interface BasicDataInfo:NSObject<HQWYActionHandlerProtocol>

NS_ASSUME_NONNULL_BEGIN
/************************************************************************************
 ************************************************************************************/
/* type=2 有值 H5跳转页面地址 */
@property (nonatomic, copy) NSString  *address;

/* 广告图片存储路径 */
@property (nonatomic, copy) NSString  *imgUrl;
    
/* 产品名称 */
@property (nonatomic, copy) NSString  *productName;
    
/* 产品id */
@property (nonatomic, strong) NSNumber  *productId;
    
/* 产品分类中的排序 */
@property (nonatomic, strong) NSNumber   *sort;
    
/* 1：请求分类列表 2：请求H5页面 */
@property (nonatomic, strong) NSNumber   *type;

NS_ASSUME_NONNULL_END

@end

NS_ASSUME_NONNULL_BEGIN
@interface BasicDataModel : NSObject
@property(nonatomic, strong) BasicDataInfo *AdvertisingVO;

+ (void)cacheToLoacl:(BasicDataModel *)model withType:(AdvertisingType)type;

+ (BasicDataModel *)getCacheModel:(AdvertisingType)type;
@end

NS_ASSUME_NONNULL_END
