//
//  HJCarouselDelegate.h
//  HJCarousel
//
//  Created by yoser on 2017/12/26.
//  Copyright © 2017年 yoser. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HJCarouselCell;

@protocol HJCarouselDelegate <NSObject>

@optional
/**
 Item 将会显示的回调 （可以对cell做一些定制化的东西）

 @param cell Item
 @param index Item 的位置
 */
- (void)carouselWillDisplayItem:(HJCarouselCell *)cell atIndex:(NSInteger)index;

/**
 Item 被选中时候的回调

 @param cell Item
 @param index Item 的位置
 */
- (void)carouselDidSelectedItem:(HJCarouselCell *)cell atIndex:(NSInteger)index;

/**
 Item 滑动到视图中心的回调

 @param index Item 的位置
 */
- (void)carouselDidDisplayItemAtIndex:(NSInteger)index;

@end
