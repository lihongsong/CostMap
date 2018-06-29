//
//  ScrollDisplayViewController.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/14.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScrollDisplayViewController;
@protocol ScrollDisplayViewControllerDelegate <NSObject>
@optional
//当用户点击了某一页触发
- (void)scrollDisplayViewController:(ScrollDisplayViewController *)scrollDisplayViewController didSelectedIndex:(NSInteger)index;
//实时回传当前索引值
- (void)scrollDisplayViewController:(ScrollDisplayViewController *)scrollDisplayViewController currentIndex:(NSInteger)index;

@end
@interface ScrollDisplayViewController : UIViewController
@property(nonatomic,readonly) NSArray *controllers;
@property(nonatomic,readonly) UIPageViewController *pageVC;
//当前页数
@property(nonatomic) NSInteger currentPage;
@property(nonatomic, strong) id<ScrollDisplayViewControllerDelegate> delegate;
- (instancetype)initWithControllers:(NSArray *)controllers;
@end
