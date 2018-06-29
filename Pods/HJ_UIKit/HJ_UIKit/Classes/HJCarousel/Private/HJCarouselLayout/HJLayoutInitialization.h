//
//  HJLayoutInitialization.h
//  HJCarousel
//
//  Created by yoser on 2017/12/27.
//  Copyright © 2017年 yoser. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HJLayoutInitialization <NSObject>

/**
 Layout的初始化方法

 @param itemSize 每个 item 的大小
 @param lineSpacing item 之间的间隔
 @param sectionInset 整个样式的边距
 @return Layout 的实例
 */
+ (UICollectionViewLayout *)layoutWithItemSize:(CGSize)itemSize
                                   lineSpacing:(CGFloat)lineSpacing
                                  sectionInset:(UIEdgeInsets)sectionInset;
@end
