//
//  HJCarousel.h
//  HJCarousel
//
//  Created by yoser on 2017/12/26.
//  Copyright © 2017年 yoser. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HJCarousel-define.h"

#import "HJCarouselDelegate.h"

#import "HJCarouselDataSource.h"

#import "HJCarouselItemModel.h"

#import "HJCarouselCell.h"

@interface HJCarousel : UIView

/**
 唯一初始化方法

 @param maker 可以在 maker 里面设置属性
 @return HJCarousel 实例
 */
+ (instancetype)carouselWithMaker:(HJCarouselMaker)maker;

/**
 是否开启打印输出 默认为 YES
 */
@property (assign, nonatomic) BOOL enableLog;

/**
 是否开启动画 默认为 YES
 */
@property (assign, nonatomic, getter=isAnimated) BOOL animated;

/**
 阴影的颜色
 */
@property (strong, nonatomic) UIColor *shadowColor;

/**
 阴影的宽度
 */
@property (assign, nonatomic) CGFloat shadowWidth;

/**
 阴影的方向
 */
@property (assign, nonatomic) HJCarouselShadowDirection shadowDirection;

/**
 是否在滚动状态
 */
@property (assign, nonatomic, readonly) BOOL isRun;

/**
 每个 item 的间距 默认为 0
 */
@property (assign, nonatomic) CGFloat minimumItemSpacing;

/**
 每个 item 的大小 (如果提供了自定义的 Layout 并且提供了每个 item 的 size 则不需要设置此数值)
 */
@property (assign, nonatomic) CGSize itemSize;

/**
 整个视图的边距
 */
@property (assign, nonatomic) UIEdgeInsets sectionInset;

/**
 自动滚动的时间间隙 默认 1.0f
 */
@property (assign, nonatomic) NSTimeInterval duration;

/**
 每个 item 的圆角 默认为 0.0f
 */
@property (assign, nonatomic) CGFloat cornerRadius;

/**
 每个 item 的内边距宽
 */
@property (assign, nonatomic) CGFloat borderWidth;

/**
 每个 item 的内边距颜色
 */
@property (strong, nonatomic) UIColor *borderColor;

/**
 pageControl 未选中的颜色 默认 whiteColor
 */
@property (strong, nonatomic) UIColor *pageControlColor;

/**
 pageControl 选中的颜色 默认 BlackColor
 */
@property (strong, nonatomic) UIColor *pageControlSeletedColor;

/**
 pageControl 边框的颜色 默认 ClearColor
 */
@property (strong, nonatomic) UIColor *pageControlBorderColor;

/**
 pageControl 边框的宽度 默认 1.0f
 */
@property (assign, nonatomic) CGFloat pageControlBorderWidth;

/**
 pageControl 未选中边框的颜色 默认 ClearColor
 */
@property (strong, nonatomic) UIColor *pageControlSeletedBorderColor;

/**
 pageControl 每个 item 的半径 默认为 5.0f
 */
@property (assign, nonatomic) CGFloat pageControlRadius;

/**
 pageControl 每个 item 的间距 默认为 5.0f
 */
@property (assign, nonatomic) CGFloat pageControlItemSpacing;

/**
 pageControl 距离 视图 底部的间距 默认为 5.0f
 */
@property (assign, nonatomic) CGFloat pageControlBottomSpacing;

/**
 相关 Item 的代理方法
 */
@property (weak, nonatomic) id<HJCarouselDelegate> delegate;

/**
 相关 PageControl 设置的代理方法
 */
@property (weak, nonatomic) id<HJCarouselDataSource>dataSource;

/**
 滚动方向 (暂时不支持 默认水平滚动)
 */
@property (assign, nonatomic) HJCarouselDirectionScrollDirection scrollDirection;

/**
 数据源
 */
@property (strong, nonatomic) NSArray <HJCarouselItemModel *> *source;

/**
 数据源类型
 */
@property (assign, nonatomic) HJCarouselContentType sourceType;

/**
 占位图--如果source的内容是网络请求的图片可以设置
 */
@property (strong, nonatomic) UIImage *imagePlaceHolder;

/**
 展示样式类型 Default -> HJCarouselLinear （慢慢填坑）
 */
@property (assign, nonatomic) HJCarouselType carouselType;

/**
 滚动的手感 Default -> HJCarouselScrollTypeViscosit 粘性滚动
 */
@property (assign, nonatomic) HJCarouselScrollType scrollType;

/**
 自动滚动开始
 */
- (void)run;

/**
 自动滚动暂停
 */
- (void)stop;

/**
 滚动到指定的页面

 @param pageIndex 页面的位置
 */
- (void)scrollToPage:(NSInteger)pageIndex;

@end


