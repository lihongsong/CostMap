//
//  AreaSplineChartView.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//
typedef NS_ENUM(NSInteger, AreaSplineType){
    AreaSplineTypeSingle,
    AreaSplineTypeCompare,
};

#import "BaseChartView.h"

@interface AreaSplineChartView : BaseChartView
@property (nonatomic, strong) AAChartModel *zzChartModel;
@property (nonatomic, strong) AAChartView  *zzChartView;
@property (nonatomic,assign)AreaSplineType chartType;
@property(nonatomic,strong)NSArray *callArr;//  主叫
@property(nonatomic,strong)NSArray *beCallArr; // 被叫
@end
