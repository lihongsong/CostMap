//
//  YosKeepAccountsChartLineScene.m
//  YosKeepAccounts
//
//  Created by yoser on 2018/11/15.
//  Copyright © 2018 yoser. All rights reserved.
//

#import "YosKeepAccountsChartBrokenLineScene.h"
#import "YosKeepAccountsChartLineEntity.h"

@import Charts;

@interface YosKeepAccountsChartBrokenLineScene () <ChartViewDelegate>

@property (nonatomic, strong) LineChartView *chartView;

@end

@implementation YosKeepAccountsChartBrokenLineScene


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
}



- (void)setEntitys:(NSArray<YosKeepAccountsChartLineEntity *> *)entitys {
    _entitys = entitys;
    [self updateChartData];
}






- (void)setUp {
    
    self.chartView = [LineChartView new];
    
    [self addSubview:_chartView];
    
    [_chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    _chartView.delegate = self;
    
    _chartView.chartDescription.enabled = NO;
    
    _chartView.dragEnabled = YES;
    [_chartView setScaleEnabled:NO];
    _chartView.pinchZoomEnabled = NO;
    _chartView.drawGridBackgroundEnabled = NO;
    
    _chartView.xAxis.gridLineDashLengths = @[@10.0, @10.0];
    _chartView.xAxis.gridLineDashPhase = 0.f;
    _chartView.xAxis.labelTextColor = YosKeepAccountsThemeColor;
    _chartView.xAxis.axisLineColor = YosKeepAccountsThemeColor;
    _chartView.xAxis.gridColor = YosKeepAccountsThemeColor;
    _chartView.xAxis.valueFormatter =
    [[ChartIndexAxisValueFormatter alloc] initWithValues:@[]];
    _chartView.xAxis.labelPosition = XAxisLabelPositionBottom;
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    [leftAxis removeAllLimitLines];
    leftAxis.axisMinimum = 0.0;
    leftAxis.gridLineDashLengths = @[@5.f, @5.f];
    leftAxis.gridColor = YosKeepAccountsThemeColor;
    leftAxis.drawZeroLineEnabled = NO;
    leftAxis.drawLimitLinesBehindDataEnabled = YES;
    
    _chartView.rightAxis.enabled = NO;
    _chartView.leftAxis.labelTextColor = YosKeepAccountsThemeColor;
    _chartView.leftAxis.axisLineColor = YosKeepAccountsThemeColor;
    
    _chartView.legend.form = ChartLegendFormLine;
    
    [_chartView animateWithYAxisDuration:0.5];
}

- (void)updateChartData {
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < _entitys.count; i++) {
        YosKeepAccountsChartLineEntity *model = _entitys[i];
        NSInteger val = model.value;
        [values addObject:[[ChartDataEntry alloc] initWithX:i y:val icon: [UIImage imageNamed:@"icon"]]];
        [titles addObject:model.title];
    }
    
    _chartView.xAxis.valueFormatter =
    [[ChartIndexAxisValueFormatter alloc] initWithValues:titles];
    
    LineChartDataSet *set1 = nil;
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
        set1.values = values;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[LineChartDataSet alloc] initWithValues:values label:@""];
        
        set1.drawIconsEnabled = NO;
        set1.lineDashLengths = @[@5.f, @0.f];
        [set1 setColor:YosKeepAccountsThemeColor];
        [set1 setCircleColor:YosKeepAccountsThemeColor];
        set1.lineWidth = 1.0;
        set1.circleRadius = 3.0;
        set1.drawCircleHoleEnabled = NO;
        set1.valueFont = [UIFont systemFontOfSize:9.f];
        set1.drawValuesEnabled = NO;
        set1.formLineWidth = 0.0;
        
        NSArray *gradientColors = @[
                                    (id)[UIColor whiteColor].CGColor,
                                    (id)YosKeepAccountsThemeColor.CGColor
                                    ];
        CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
        
        set1.fillAlpha = 0.5f;
        set1.fill = [ChartFill fillWithLinearGradient:gradient angle:90.f];
        set1.drawFilledEnabled = YES;
        
        CGGradientRelease(gradient);
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        
        _chartView.data = data;
    }
}






@end
