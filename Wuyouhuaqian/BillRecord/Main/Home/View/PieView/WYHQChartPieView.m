//
//  WYHQChartPieView.m
//  Wuyouhuaqian
//
//  Created by yoser on 2018/11/8.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import "WYHQChartPieView.h"
@import Charts;

@interface WYHQChartPieView() <ChartViewDelegate>

@property (nonatomic, strong) PieChartView *chartView;

@end

@implementation WYHQChartPieView {
    NSArray *parties;
}

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < models.count; i++) {
        
        WYHQBillModel *model = models[i];
        CGFloat money = fabs([model.s_money doubleValue]);
        [values addObject:[[PieChartDataEntry alloc] initWithValue:money label:parties[i % parties.count] icon: [UIImage imageNamed:@"icon"]]];
    }
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:values label:@"分 类"];
    
    dataSet.sliceSpace = 2;
    
    dataSet.drawIconsEnabled = NO;
    dataSet.drawValuesEnabled = NO;
    
    dataSet.iconsOffset = CGPointMake(0, 40);
    
    // add a lot of colors
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    [colors addObjectsFromArray:ChartColorTemplates.colorful];
    [colors addObjectsFromArray:ChartColorTemplates.liberty];
    [colors addObjectsFromArray:ChartColorTemplates.pastel];
    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    
    dataSet.colors = colors;
    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    [data setValueTextColor:UIColor.whiteColor];
    
    _chartView.data = data;
    [_chartView highlightValues:nil];
    
    [_chartView animateWithXAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
}

#pragma mark - Public Method

- (void)animate {
    [_chartView animateWithXAxisDuration:1.0 easingOption:ChartEasingOptionEaseInOutSine];
}

#pragma mark - Private Method

- (void)setUp {
    
    parties = [WYHQBillTool allBillTypesName];
    
    _chartView = [PieChartView new];
    
    [self addSubview:_chartView];
    
    [_chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self setupPieChartView:_chartView];
    
    _chartView.delegate = self;
    
    ChartLegend *l = _chartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    l.verticalAlignment = ChartLegendVerticalAlignmentTop;
    l.orientation = ChartLegendOrientationVertical;
    l.drawInside = NO;
    l.xEntrySpace = 10.0;
    l.yEntrySpace = 12.0;
    l.yOffset = 20.0;
    l.xOffset = 30.0;
    
    // entry label styling
    _chartView.entryLabelColor = UIColor.whiteColor;
    _chartView.entryLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f];
}

- (void)setupPieChartView:(PieChartView *)chartView {
    
    // 设置不可交互
    chartView.userInteractionEnabled = NO;
    chartView.usePercentValuesEnabled = NO;
    chartView.drawSlicesUnderHoleEnabled = NO;
    chartView.drawEntryLabelsEnabled = NO;
    chartView.holeRadiusPercent = 0.58;
    chartView.transparentCircleRadiusPercent = 0.61;
    chartView.chartDescription.enabled = NO;
    [chartView setExtraOffsetsWithLeft:-100.f top:10.f right:100.f bottom:5.f];
    
    chartView.drawCenterTextEnabled = YES;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSString *specialMoney = [NSString stringWithFormat:@"¥%@", @"0"];
    NSString *enterString = [NSString stringWithFormat:@"支出\n%@", specialMoney];
    
    NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:enterString];
    [centerText addAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:11.f],
                                NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]
                                } range:NSMakeRange(centerText.length - specialMoney.length, specialMoney.length)];
    chartView.centerAttributedText = centerText;
    
    chartView.drawHoleEnabled = YES;
    chartView.rotationAngle = 0.0;
    chartView.rotationEnabled = YES;
    chartView.highlightPerTapEnabled = YES;
    
    ChartLegend *l = chartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    l.verticalAlignment = ChartLegendVerticalAlignmentTop;
    l.orientation = ChartLegendOrientationVertical;
    l.drawInside = NO;
    l.xEntrySpace = 7.0;
    l.yEntrySpace = 0.0;
    l.yOffset = 0.0;
}

#pragma mark - Notification Method



#pragma mark - Event & Target Methods

@end
