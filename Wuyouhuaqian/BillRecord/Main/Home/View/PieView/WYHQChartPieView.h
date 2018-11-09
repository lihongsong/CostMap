//
//  WYHQChartPieView.h
//  Wuyouhuaqian
//
//  Created by yoser on 2018/11/8.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYHQChartPieView : UIView

@property (copy, nonatomic) NSArray<WYHQBillModel *> *models;

/**
 中间圆圈的占比
 */
@property (assign, nonatomic) CGFloat holeRadiusPercent;

/**
 是否显示中间空心
 */
@property (assign, nonatomic) BOOL drawHoleEnabled;

- (void)animate;

@end

NS_ASSUME_NONNULL_END
