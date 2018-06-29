//
//  BaseChartView.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAChartKit.h"

@interface BaseChartView : UIView
@property (nonatomic, strong) AAChartModel *aaChartModel;
@property (nonatomic, strong) AAChartView  *aaChartView;
@end
