//
//  UNNoDataView.h
//  union
//
//  Created by 顾慧超 on 16/4/29.
//  Copyright © 2016年 hardy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UNNoDataView : UIView

@property (nonatomic, strong) UILabel *noDataLabel;

/**
 *  默认构造器
 *
 *  @param frame frame
 *
 *  @return 实例对象
 */
+ (instancetype)viewAddedTo:(UIView *)view;

/**
 *  指定构造器
 *
 *  @param frame     frame
 *  @param imageName 图片名
 *  @param title     提示文案
 *
 *  @return 实例对象
 */
+ (instancetype)viewAddedTo:(UIView *)view
                  imageName:(NSString *)imageName
                      title:(NSString *)title;

@end
