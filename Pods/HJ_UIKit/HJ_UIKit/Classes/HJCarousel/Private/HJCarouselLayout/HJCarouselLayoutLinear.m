//
//  HJCarouselLayoutLinear.m
//  HJCarousel
//
//  Created by yoser on 2017/12/27.
//  Copyright © 2017年 yoser. All rights reserved.
//

#import "HJCarouselLayoutLinear.h"

@implementation HJCarouselLayoutLinear

+ (UICollectionViewLayout *)layoutWithItemSize:(CGSize)itemSize
                                   lineSpacing:(CGFloat)lineSpacing
                                  sectionInset:(UIEdgeInsets)sectionInset{
    HJCarouselLayoutLinear *linear = [HJCarouselLayoutLinear new];
    linear.itemSize = itemSize;
    linear.minimumLineSpacing = lineSpacing;
    linear.sectionInset = sectionInset;
    linear.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return linear;
}

@end
