//
//  WYHQChartLineView.m
//  Wuyouhuaqian
//
//  Created by yoser on 2018/11/8.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import "WYHQChartLineView.h"
#import "WYHQBillTool.h"
@import Charts;

@interface WYHQChartLineView() <ChartViewDelegate>

@property (nonatomic, strong) BarChartView *chartView;

@end

@implementation WYHQChartLineView {
    NSArray *parties;
}

#pragma mark - Life Cycle

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

#pragma mark - Getter & Setter Methods

- (void)setModels:(NSArray<WYHQBillModel *> *)models {
    _models = models;
    
    [self updateChartData];
}

#pragma mark - Public Method

- (void)animate {
    [_chartView animateWithYAxisDuration:1.0 easingOption:ChartEasingOptionEaseInOutSine];
}


#pragma mark - Private Method

- (void)setUp {
    
    parties = [WYHQBillTool allBillTypesName];
    
    _chartView = [BarChartView new];
    
    [self addSubview:_chartView];
    
    [_chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    _chartView.delegate = self;
    
    _chartView.chartDescription.enabled = NO;
    
    _chartView.userInteractionEnabled = NO;
    _chartView.maxVisibleCount = 60;
    _chartView.pinchZoomEnabled = NO;
    _chartView.drawBarShadowEnabled = NO;
    _chartView.drawGridBackgroundEnabled = NO;
    _chartView.rightAxis.drawAxisLineEnabled = NO;
    _chartView.rightAxis.drawLabelsEnabled = NO;
    _chartView.leftAxis.axisLineColor = WYHQThemeColor;
    _chartView.xAxis.axisLineColor = WYHQThemeColor;
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:parties];
    
    _chartView.leftAxis.drawGridLinesEnabled = NO;
    _chartView.rightAxis.drawGridLinesEnabled = NO;
    
    _chartView.legend.enabled = NO;
    _chartView.xAxis.labelTextColor = HJHexColor(k0x666666);
    _chartView.leftAxis.labelTextColor = HJHexColor(k0x666666);
    _chartView.xAxis.yOffset = 5;
    _chartView.extraBottomOffset = 5;
    
    [self updateChartData];
}

- (void)updateChartData {
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < _models.count; i++) {
        WYHQBillModel *model = _models[i];
        double val = fabs([model.s_money floatValue]);
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:val]];
    }
    
    BarChartDataSet *set1 = nil;
    if (_chartView.data.dataSetCount > 0) {
        set1 = (BarChartDataSet *)_chartView.data.dataSets[0];
        set1.values = yVals;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    } else {
        set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"DataSet"];
        set1.colors = [WYHQBillTool allBillTypesColor];// ChartColorTemplates.vordiplom;
        set1.drawValuesEnabled = NO;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        
        _chartView.data = data;
        _chartView.fitBars = YES;
    }
    
    [_chartView setNeedsDisplay];
    
    [_chartView animateWithYAxisDuration:0.5];
    
}



#pragma mark - Notification Method



#pragma mark - Event & Target Methods

@end
