//
//  HJCarousel-define.h
//  HJCarousel
//
//  Created by yoser on 2017/12/26.
//  Copyright © 2017年 yoser. All rights reserved.
//

#ifndef HJCarousel_define_h
#define HJCarousel_define_h

@class HJCarousel;

typedef void (^HJCarouselMaker)(HJCarousel *maker);

typedef NS_ENUM(NSInteger, HJCarouselType) {
    
    // 直线型
    HJCarouselTypeLinear = 0,
    
    // 旋转型
//    HJCarouselTypeRotary,
    
    // 反向旋转
//    HJCarouselTypeInvertedRotary,
    
    // 圆柱
    HJCarouselTypeCylinder,
    
    // 反向圆柱
//    HJCarouselTypeInvertedCylinder,
    
    // 车轮
    HJCarouselTypeWheel,
    
    // 反向车轮
//    HJCarouselTypeInvertedWheel,
    
    // 封面流
//    HJCarouselTypeCoverFlow,
    
    // 封面流2
//    HJCarouselTypeCoverFlow2,
    
    // 时间机器
//    HJCarouselTypeTimeMachine,
    
    // 反向时光机器
//    HJCarouselTypeInvertedTimeMachine,
    
    // 局部缩小
    HJCarouselTypeSubcontract,
    
    // 用户自定义
    HJCarouselTypeCustom
};

typedef NS_ENUM(NSInteger, HJCarouselContentType) {
    
    // 内容未知
    HJCarouselContentTypeUnknow = 0,
    
    // 内容为Image类型
    HJCarouselContentTypeImage,
    
    // 内容为ImageUrl类型
    HJCarouselContentTypeUrl,
    
    // 内容为本地ImageName类型
    HJCarouselContentTypeImageName
};

typedef NS_ENUM(NSInteger, HJCarouselShadowDirection) {
    
    // 左边
    HJCarouselShadowDirectionLeft = 0,
    
    // 下边
    HJCarouselShadowDirectionBottom,
    
    // 右边
    HJCarouselShadowDirectionRight,
    
    // 上边
    HJCarouselShadowDirectionTop,
    
    // 全部
    HJCarouselShadowDirectionAll
};


typedef NS_ENUM(NSInteger, HJCarouselDirectionScrollDirection) {
    
    // 水平滚动
    HJCarouselDirectionScrollDirectionHorizontal,
    
    // 垂直滚动
    HJCarouselDirectionScrollDirectionVertical
};

typedef NS_ENUM(NSInteger, HJCarouselScrollType) {
    
    // 粘性滚动
    HJCarouselScrollTypeViscosit,
    
    // 惯性滚动
    HJCarouselScrollTypeInertia,
};


#endif /* HJCarousel_define_h */
