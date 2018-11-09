//
//  WYHQChartLineView.h
//  Wuyouhuaqian
//
//  Created by yoser on 2018/11/8.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYHQChartLineView : UIView

@property (copy, nonatomic) NSArray<WYHQBillModel *> *models;

- (void)animate;

@end

NS_ASSUME_NONNULL_END
