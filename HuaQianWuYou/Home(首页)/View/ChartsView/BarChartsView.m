//
//  BarChartsView.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/10.
//  Copyright © 2018年 jason. All rights reserved.
//
/*
#import "BarChartsView.h"
#import "DayAxisValueFormatter.h"
#import "MonthAxisValueFormatter.h"

@interface BarChartsView()<ChartViewDelegate>

@property(nonatomic,strong)BarChartView *chartView;


@end

@implementation BarChartsView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.chartView = [[BarChartView alloc] initWithFrame:CGRectMake(0, 0, self.hj_width, self.hj_height)];
    [self setupBarLineChartView:_chartView];
    self.chartView.drawBarShadowEnabled = NO;//是否绘制柱形的阴影
    self.chartView.drawValueAboveBarEnabled = YES;//数值显示在柱形的上面还是下面
    
    self.chartView.delegate = self;
    self.chartView.maxVisibleCount = 60;
    self.chartView.scaleYEnabled = NO;//取消Y轴缩放
    self.chartView.doubleTapToZoomEnabled = false;//取消双击缩放
    self.chartView.dragEnabled = YES;//启用拖拽图表
    self.chartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
    self.chartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    [self addSubview:self.chartView];
    
    //底部X轴上单位
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawGridLinesEnabled = NO;
    xAxis.granularity = 0; // only intervals of 1 month 间隔
    xAxis.axisLineWidth = 1.0;//设置X轴线宽
    xAxis.labelCount = 7;
    //xAxis.spaceMax = 10;
    //xAxis.spaceMin = 1;
    //xAxis.labelWidth = 8;
    MonthAxisValueFormatter *xAxisFormatter = [[MonthAxisValueFormatter alloc] initForChart:_chartView];//自定义格式
    xAxis.valueFormatter = [[MonthAxisValueFormatter alloc] initForChart:_chartView];
//
//    ChartXAxis *xAxis = _chartView.xAxis;
//    xAxis.labelPosition = XAxisLabelPositionBottom;
//    xAxis.drawGridLinesEnabled = NO;
    
    NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init];//自定义格式
    leftAxisFormatter.minimumFractionDigits = 0;//最小最大单位
    leftAxisFormatter.maximumFractionDigits = 1;
    leftAxisFormatter.negativeSuffix = @" $";
    leftAxisFormatter.positiveSuffix = @" $";
    
    //左边Y轴 线和数字
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.labelCount = 8;//通过labelCount属性设置Y轴要均分的数量.
    //在这里要说明一下，设置的labelCount的值不一定就是Y轴要均分的数量，这还要取决于forceLabelsEnabled属性，如果forceLabelsEnabled等于YES, 则强制绘制指定数量的label, 但是可能不是均分的
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:leftAxisFormatter];//设置Y轴上标签显示数字的格式
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
    leftAxis.spaceTop = 0.15;
    leftAxis.axisMinimum = 0.0; //设置Y轴的最小值 this replaces startAtZero = YES
    leftAxis.drawGridLinesEnabled = NO;//不绘制网络线
    leftAxis.forceLabelsEnabled = NO;//不强制绘制制定数量的label
    leftAxis.axisMaximum = 150;//设置Y轴的最大值
    leftAxis.inverted = NO;//是否将Y轴进行上下翻转
    leftAxis.axisLineWidth = 0.5;//Y轴线宽
    leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
    //右边Y轴 线和数字
    //self.barChartView.rightAxis.enabled = NO;//不绘制右边轴
//    ChartYAxis *rightAxis = _chartView.rightAxis;
//    rightAxis.enabled = YES;
//    rightAxis.drawGridLinesEnabled = NO;
//    rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
//    rightAxis.labelCount = 8;
//    rightAxis.valueFormatter = leftAxis.valueFormatter;
//    rightAxis.spaceTop = 0.15;
//    rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    // 图例对象
//    ChartLegend *l = _chartView.legend;
//    l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
//    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
//    l.orientation = ChartLegendOrientationHorizontal;
//    l.drawInside = NO;
//    l.form = ChartLegendFormSquare;
//    l.formSize = 9.0;
//    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
//    l.xEntrySpace = 4.0;
    
    //点击后出现试图，时间够再研究
//    XYMarkerView *marker = [[XYMarkerView alloc]
//                            initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
//                            font: [UIFont systemFontOfSize:12.0]
//                            textColor: UIColor.whiteColor
//                            insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)
//                            xAxisValueFormatter: _chartView.xAxis.valueFormatter];
//    marker.chartView = _chartView;
//    marker.minimumSize = CGSizeMake(80.f, 40.f);
//    _chartView.marker = marker;
}

#pragma mark 更新数据
-(void)refreshData{
    [self updateChartData];
}

- (void)updateChartData{
    if (self.shouldHideData) {
        self.chartView.data = nil;
        return;
    }
    [self setData];
}

-(void)setData{
    
    //X轴上面需要显示的数据
    NSMutableArray *dataArr  = [[NSMutableArray alloc] init];
    NSMutableArray *dataArr2  = [[NSMutableArray alloc] init];
//    for (int i = 0; i < chartsData.count; i ++){// X轴显示多少条
//        [dataArr addObject:[[BarChartDataEntry alloc] initWithX:i y:([[NSString stringWithFormat:@"%@",chartsData[i][DataNumber]] doubleValue]) icon:nil]];
//
//    };
//    BarChartDataSet *dataSet = nil;
//    if (_chartView.data.dataSetCount > 0){
//        dataSet = (BarChartDataSet *)_chartView.data.dataSets[0];
//        dataSet.values = dataArr;
//        [_chartView.data notifyDataChanged];
//        [_chartView notifyDataSetChanged];
//    }else{
//        dataSet = [[BarChartDataSet alloc] initWithValues:dataArr label:@"The year 2017"];
//        [dataSet setColors:ChartColorTemplates.material];
//        dataSet.drawIconsEnabled = NO;
//
//        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
//        [dataSets addObject:dataSet];
//
//        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
//        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
//
//        data.barWidth = 0.9f;
//        [data groupBarsFromX:5 groupSpace:10 barSpace:5];
//        [data groupWidthWithGroupSpace:10 barSpace:5];
//        _chartView.data = data;
                for (int i = 0; i < self.chartsData.count; i ++) {
                    [dataArr addObject:[[BarChartDataEntry alloc] initWithX:i y:([[NSString stringWithFormat:@"%@",self.chartsData[i][DataNumber]] doubleValue]) icon:nil]];
                    [dataArr2 addObject:[[BarChartDataEntry alloc] initWithX:i y:([[NSString stringWithFormat:@"%@",self.chartsData2[i][DataNumber]] doubleValue]) icon:nil]];
                    
                }
    
                //stack barchart
                //let dataEntry = BarChartDataEntry(x: Double(i), yValues:  [self.unitsSold[i],self.unitsBought[i]], label: "groupChart")
  
    //        [dataSet setColors:ChartColorTemplates.material];
    //        dataSet.drawIconsEnabled = NO;
    //
    //        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    //        [dataSets addObject:dataSet];
    //
    //        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
    //        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
    //
    //        data.barWidth = 0.9f;
    //        [data groupBarsFromX:5 groupSpace:10 barSpace:5];
    //        [data groupWidthWithGroupSpace:10 barSpace:5];
    //        _chartView.data = data;
    BarChartDataSet * dataSet = [[BarChartDataSet alloc] initWithValues:dataArr label:@"The year 2017"];
    BarChartDataSet * dataSet2 = [[BarChartDataSet alloc] initWithValues:dataArr2 label:@"The year 2018"];
    NSArray *arrData = @[dataSet,dataSet2];
    BarChartData *chartData = [[BarChartData alloc] initWithDataSets:arrData];
           // chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
            //chartDataSet.colors = ChartColorTemplates.colorful()
            //let chartData = BarChartData(dataSet: chartDataSet)
    float groupSpace = 0.3;
    float barSpace = 0.05;
    float barWidth = 0.3;
            // (0.3 + 0.05) * 2 + 0.3 = 1.00 -> interval per "group"
            
    NSInteger groupCount = [self.chartsData count];
    int startYear = 0;
            chartData.barWidth = barWidth;
    self.chartView.xAxis.axisMinimum = 0.0;
   double gg = [chartData groupWidthWithGroupSpace:groupSpace barSpace:barSpace];
    
    self.chartView.xAxis.axisMaximum = startYear + gg * groupCount;
    [chartData groupBarsFromX:startYear groupSpace:groupSpace barSpace:barSpace];
    [self.chartView notifyDataSetChanged];
            
    self.chartView.data = chartData;
            
            
            
            
            
            
            //background color
            //barChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
            
            //chart animation
           // barChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
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

//使用 Example
  //[self setBarChartsView];

//- (void)setBarChartsView{
//    self.barView = [[BarChartsView alloc] initWithFrame:CGRectMake(0, 0, SWidth, 350)];
//    self.barView.chartsData = @[
//                                @{@"title":@"Party A",@"data":@"20",@"state":@"公司3次",},
//                                @{@"title":@"Party B",@"data":@"30",@"state":@"综合电商平台5",},
//                                @{@"title":@"Party C",@"data":@"65",@"state":@"小额8次"},
//                                @{@"title":@"Party A",@"data":@"20",@"state":@"公司3次",},
//                                @{@"title":@"Party B",@"data":@"30",@"state":@"综合电商平台5",},
//                                @{@"title":@"Party C",@"data":@"85",@"state":@"小额8次"},
//                                @{@"title":@"Party A",@"data":@"20",@"state":@"公司3次",},
//                                @{@"title":@"Party B",@"data":@"30",@"state":@"综合电商平台5",},
//                                @{@"title":@"Party C",@"data":@"50",@"state":@"小额8次"},
//                                @{@"title":@"Party A",@"data":@"20",@"state":@"公司3次",},
//                                @{@"title":@"Party B",@"data":@"30",@"state":@"综合电商平台5",}/*,
//                                @{@"title":@"Party C",@"data":@"5",@"state":@"小额8次"},
//                                @{@"title":@"Party C",@"data":@"68",@"state":@"小额8次"},
//                                @{@"title":@"Party A",@"data":@"20",@"state":@"公司3次",},
//                                @{@"title":@"Party B",@"data":@"30",@"state":@"综合电商平台5",},
//                                @{@"title":@"Party C",@"data":@"50",@"state":@"小额8次"}*/
//                                ];
//
//    self.barView.chartsData2 = @[
//                                 @{@"title":@"Party A",@"data":@"20",@"state":@"公司3次",},
//                                 @{@"title":@"Party B",@"data":@"30",@"state":@"综合电商平台5",},
//                                 @{@"title":@"Party C",@"data":@"65",@"state":@"小额8次"},
//                                 @{@"title":@"Party A",@"data":@"20",@"state":@"公司3次",},
//                                 @{@"title":@"Party B",@"data":@"30",@"state":@"综合电商平台5",},
//                                 @{@"title":@"Party C",@"data":@"85",@"state":@"小额8次"},
//                                 @{@"title":@"Party A",@"data":@"20",@"state":@"公司3次",},
//                                 @{@"title":@"Party B",@"data":@"30",@"state":@"综合电商平台5",},
//                                 @{@"title":@"Party C",@"data":@"50",@"state":@"小额8次"},
//                                 @{@"title":@"Party A",@"data":@"20",@"state":@"公司3次",},
//                                 @{@"title":@"Party B",@"data":@"30",@"state":@"综合电商平台5",}/*,
//                                                                                           @{@"title":@"Party C",@"data":@"5",@"state":@"小额8次"},
//                                                                                           @{@"title":@"Party C",@"data":@"68",@"state":@"小额8次"},
//                                                                                           @{@"title":@"Party A",@"data":@"20",@"state":@"公司3次",},
//                                                                                           @{@"title":@"Party B",@"data":@"30",@"state":@"综合电商平台5",},
//                                                                                           @{@"title":@"Party C",@"data":@"50",@"state":@"小额8次"}*/
//                                 ];
//    self.barView.toggleValues = 0;
//    self.barView.togglePinchZoom = true;
//    self.barView.toggleAutoScaleMinMax = 0;
//    self.barView.shouldHideData = false;
//    [self.view addSubview:self.barView];
//    [self.barView refreshData];
//}
//@end

