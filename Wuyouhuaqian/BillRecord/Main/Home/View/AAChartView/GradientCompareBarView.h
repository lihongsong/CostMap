//
//  GradientCompareBarView.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "BaseChartView.h"

@interface GradientCompareBarView : BaseChartView<AAChartViewDidFinishLoadDelegate>
@property (nonatomic, strong) AAChartModel *barChartModel;
@property (nonatomic, strong) AAChartView  *barChartView;
@property (nonatomic,strong) NSArray *lendArr;//
@property (nonatomic,strong) NSArray *repayArr; //
-(void)refreshData;
@end
