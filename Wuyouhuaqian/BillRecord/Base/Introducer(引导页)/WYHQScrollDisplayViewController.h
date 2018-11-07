//
//  ScrollDisplayViewController.h
// WuYouQianBao
//
//  Created by jasonzhang on 2018/5/14.
//  Copyright © 2018年 jasonzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYHQScrollDisplayViewController;
@protocol WYHQScrollDisplayViewControllerDelegate <NSObject>
@optional
//当用户点击了某一页触发
- (void)scrollDisplayViewController:(WYHQScrollDisplayViewController *)scrollDisplayViewController didSelectedIndex:(NSInteger)index;
//实时回传当前索引值
- (void)scrollDisplayViewController:(WYHQScrollDisplayViewController *)scrollDisplayViewController currentIndex:(NSInteger)index;

@end
@interface WYHQScrollDisplayViewController : UIViewController
@property(nonatomic,readonly) NSArray *controllers;
@property(nonatomic,readonly) UIPageViewController *pageVC;
//当前页数
@property(nonatomic) NSInteger currentPage;
@property(nonatomic, strong) id<WYHQScrollDisplayViewControllerDelegate> delegate;
- (instancetype)initWithControllers:(NSArray *)controllers;
@end
