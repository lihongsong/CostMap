//
//  HJCarouselItemModel.h
//  HJ_UIKit
//
//  Created by yoser on 2018/3/6.
//

#import <Foundation/Foundation.h>

#import "HJCarousel-define.h"

@interface HJCarouselItemModel : NSObject

/**
 数据源
 */
@property (strong, nonatomic) id source;

/**
 数据源类型
 */
@property (assign, nonatomic) HJCarouselContentType sourceType;

/**
 自动滚动状态下的停留时间
 */
//@property (assign, nonatomic) NSTimeInterval stayDuration;

/**
 占位图
 */
@property (strong, nonatomic) UIImage *imagePlaceHolder;

@end
