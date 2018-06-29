//
//  PieChartsView.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/10.
//  Copyright © 2018年 jason. All rights reserved.
//
/*
#import "PieChartsView.h"
@interface PieChartsView()<ChartViewDelegate>
@property(nonatomic,strong)PieChartView *chartView;

@end

@implementation PieChartsView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.chartView = [[PieChartView alloc] initWithFrame:CGRectMake(0, 0, self.hj_width, self.hj_height)];
    [self setupPieChartView:_chartView];
    self.chartView.legend.enabled = NO;
    self.chartView.delegate = self;
    [self.chartView setExtraOffsetsWithLeft:20 top:0.f right:20.f bottom:0.f];
    [self.chartView animateWithYAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
    [self addSubview:self.chartView];
    // 每块名称
//    self.phartsData = @[@{@"title":@"Party A",@"data":@"25% B",@"state":@"住房",},@{@"title":@"Party B",@"data":@"35%",@"state":@"吃饭",},@{@"title":@"Party C",@"data":@"40%",@"state":@"玩"}];
//
//  @[
//                @"Party A", @"Party B", @"Party C", @"Party D", @"Party E", @"Party F",
//                @"Party G", @"Party H", @"Party I", @"Party J", @"Party K", @"Party L",
//                @"Party M", @"Party N", @"Party O", @"Party P", @"Party Q", @"Party R",
//                @"Party S", @"Party T", @"Party U", @"Party V", @"Party W", @"Party X",
//                @"Party Y", @"Party Z"
//                ];
}

- (void)setToggleHole:(NSInteger)toggleHole{
    switch (toggleHole) {
        case 1:
            self.chartView.drawHoleEnabled = true;
            break;
            
        default:
            self.chartView.drawHoleEnabled = false;
            break;
    }
    
    [self.chartView setNeedsDisplay];
}

- (void)setChartsData:(NSArray *)chartsData{
    _chartsData = chartsData;
    [self updateChartData:chartsData];
}

- (void)updateChartData:(NSArray *)chartsData{
    if (self.shouldHideData) {
        self.chartView.data = nil;
        return;
    }
    [self setData:chartsData];
}

-(void)setData:(NSArray *)chartsData{
    
    NSMutableArray *dataArr  = [[NSMutableArray alloc] init];
    for (int i = 0; i < chartsData.count; i ++){
        [dataArr addObject:[[PieChartDataEntry alloc] initWithValue:([[NSString stringWithFormat:@"%@",chartsData[i][DataPercent]] doubleValue]) label:chartsData[i][State]]];
    };
    PieChartDataSet *dataSet =[[PieChartDataSet alloc] initWithValues:dataArr label:@"CreateZYZ"];
    dataSet.sliceSpace = 2.0;
    
    // add a lot of colors
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    [colors addObjectsFromArray:ChartColorTemplates.colorful];
    [colors addObjectsFromArray:ChartColorTemplates.liberty];
    [colors addObjectsFromArray:ChartColorTemplates.pastel];
    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    
    dataSet.colors = colors;
    
    dataSet.valueLinePart1OffsetPercentage = 0.8;
    dataSet.valueLinePart1Length = 0.2;
    dataSet.valueLinePart2Length = 0.4;
    //dataSet.xValuePosition = PieChartValuePositionOutsideSlice;
    dataSet.yValuePosition = PieChartValuePositionOutsideSlice;
    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    [data setValueTextColor:UIColor.blackColor];
    NSLog(@"____%@",data);
    self.chartView.data = data;
    [self.chartView highlightValues:nil];
    
}

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}
// 使用Example
//[self setPieChartView];
//-(void)setPieChartView{
//    self.pieView = [[PieChartsView alloc] initWithFrame:CGRectMake(0, 0, SWidth, 350)];
//    self.pieView.chartsData = @[
//      @{@"title":@"Party A",@"data":@"20",@"state":@"公司3次",},
//      @{@"title":@"Party B",@"data":@"30",@"state":@"综合电商平台5",},
//      @{@"title":@"Party C",@"data":@"50",@"state":@"小额8次"}
//      ];
//    self.pieView.toggleValues = 0;
//    self.pieView.togglePinchZoom = 0;
//    self.pieView.toggleAutoScaleMinMax = 0;
//    self.pieView.toggleHole = 0;
//    self.pieView.shouldHideData = false;
//    [self.view addSubview:self.pieView];
//
//}
@end
 */
