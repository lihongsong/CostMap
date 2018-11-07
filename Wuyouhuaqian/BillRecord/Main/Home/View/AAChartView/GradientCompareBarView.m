//
//  GradientCompareBarView.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "GradientCompareBarView.h"

@implementation GradientCompareBarView
-(void)initialize{
    
}

-(AAChartView  *)barChartView{
    if (_barChartView == nil) {
        _barChartView = [[AAChartView alloc]init];
        _barChartView.delegate = self;
    }
    return _barChartView;
}

-(void)refreshData {
    [self addSubview:self.barChartView];
    
    //设置 barChartView 的背景色是否为透明
    self.barChartView.backgroundColor = [UIColor whiteColor];
    self.barChartView.scrollEnabled = NO;;
    self.barChartModel= [self configureTheChartModel];
    [self.barChartView aa_drawChartWithChartModel:self.barChartModel];
}

-(AAChartModel *)configureTheChartModel {
    AAChartModel *aaChartModel = AAObject(AAChartModel)
    .tooltipEnabledSet(false) 
    .chartTypeSet(AAChartTypeColumn)
    .titleSet(@"")
    .subtitleSet(@"")
    .colorsThemeSet([self configureTheRandomColorArrayWithColorNumber:14])
    .gradientColorEnabledSet(true)
    .borderRadiusSet(@5)
    .yAxisTitleSet(@"")
    .yAxisLineWidthSet(@0)
    .yAxisMaxSet(@(10))//Y轴最大值
    .yAxisTickPositionsSet(@[@(0),@(2),@(4),@(6),@(8),@(10)])//指定y轴坐标
    .categoriesSet(@[@"00:00-03:59", @"04:00-07:59", @"08:00-11:59", @"12:00-15:59", @"16:00-19:59", @"20:00-23:59"])
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"主叫")
                 .dataSet(self.lendArr)
                 .colorSet((id)@{
                                 @"linearGradient": @{
                                         @"x1": @0,
                                         @"y1": @0,
                                         @"x2": @0,
                                         @"y2": @1
                                         },
                                 @"stops": @[@[@0,@"#FAD961 "],
                                             @[@1,@"#F76B1C"]]//颜色字符串设置支持十六进制类型和 rgba 类型
                                 }),
                 AAObject(AASeriesElement)
                 .nameSet(@"被叫")
                 .dataSet(self.repayArr)
                 .colorSet((id)@{
                                 @"linearGradient": @{
                                         @"x1": @0,
                                         @"y1": @1,
                                         @"x2": @0,
                                         @"y2": @0
                                         },
                                 @"stops": @[@[@0,@"#3389FF"],
                                             @[@1,@"#30BEF8"]]//颜色字符串设置支持十六进制类型和 rgba 类型
                                 }),
                 ]
               );
    
    return aaChartModel;
}

- (void)layoutSubviews {
    CGFloat chartViewWidth  = self.hj_width;
    CGFloat chartViewHeight = self.hj_height;
    self.barChartView.frame = CGRectMake(0, 0, chartViewWidth, chartViewHeight);
}

- (NSArray *)configureTheRandomColorArrayWithColorNumber:(NSInteger)colorNumber {
    NSMutableArray *colorStringArr = [[NSMutableArray alloc]init];
    for (int i=0; i < colorNumber; i++) {
        int R = (arc4random() % 256) ;
        int G = (arc4random() % 256) ;
        int B = (arc4random() % 256) ;
        NSString *colorStr = [NSString stringWithFormat:@"rgba(%d,%d,%d,0.9)",R,G,B];
        [colorStringArr addObject:colorStr];
    }
    return colorStringArr;
}

#pragma mark -- AAChartView delegate
- (void)AAChartViewDidFinishLoad {
    //NSLog(@"🔥🔥🔥🔥🔥 AAChartView content did finish load!!!");
}

@end
