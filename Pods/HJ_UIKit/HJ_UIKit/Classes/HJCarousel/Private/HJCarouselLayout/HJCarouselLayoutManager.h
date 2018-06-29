//
//  HJCarouselLayoutManager.h
//  HJCarousel
//
//  Created by yoser on 2017/12/26.
//  Copyright © 2017年 yoser. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HJCarousel-define.h"

@interface HJCarouselLayoutManager : NSObject

+ (instancetype)shared;

+ (void)registerCustomerLayout:(Class)layoutClass;

+ (UICollectionViewLayout *)layoutWithType:(HJCarouselType)type
                                  itemSize:(CGSize)itemSize
                               lineSpacing:(CGFloat)lineSpacing
                              sectionInset:(UIEdgeInsets)sectionInset;

@end
