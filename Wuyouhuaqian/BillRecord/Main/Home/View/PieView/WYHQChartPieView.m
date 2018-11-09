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

- (void)setHoleRadiusPercent:(CGFloat)holeRadiusPercent {
    _holeRadiusPercent = holeRadiusPercent;
    self.chartView.holeRadiusPercent = holeRadiusPercent;
    [self.chartView setNeedsDisplay];
}

- (void)setDrawHoleEnabled:(BOOL)drawHoleEnabled {
    _drawHoleEnabled = drawHoleEnabled;
    self.chartView.drawHoleEnabled = drawHoleEnabled;
    self.chartView.drawCenterTextEnabled = drawHoleEnabled;
    [self.chartView setNeedsDisplay];
}

- (void)setModels:(NSArray<WYHQBillModel *> *)models {
    _models = models;
    
    // 总金额
    __block double sum = 0.0f;
    [self.models enumerateObjectsUsingBlock:^(WYHQBillModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sum += [obj.s_money doubleValue];
    }];
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < models.count; i++) {
        
        WYHQBillModel *model = models[i];
        CGFloat money = fabs([model.s_money doubleValue]);
        NSString *percentStr;
        if (sum == 0.0f) {
            percentStr = @"0%";
        } else {
            percentStr = [NSString stringWithFormat:@"%.2f%@",fabs([model.s_money doubleValue] / sum * 100), @"%"];
        }
        NSString *titleStr = [NSString stringWithFormat:@"%@    %@",parties[i % parties.count], percentStr];
        [values addObject:[[PieChartDataEntry alloc] initWithValue:money label:titleStr icon: [UIImage imageNamed:@"icon"]]];
    }
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:values label:nil];
    
    dataSet.sliceSpace = 2;
    
    dataSet.drawIconsEnabled = NO;
    dataSet.drawValuesEnabled = NO;
    
    dataSet.iconsOffset = CGPointMake(0, 40);
    
    // add a lot of colors
    
    dataSet.colors = [WYHQBillTool allBillTypesColor];
    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    [data setValueTextColor:UIColor.whiteColor];
    
    NSString *specialMoney = [NSString stringWithFormat:@"¥%.2f", fabs(sum)];
    
    NSString *enterString = [NSString stringWithFormat:@"支出\n%@", specialMoney];
    
    NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:enterString];
    
    [centerText addAttributes:@{
                                NSFontAttributeName: [UIFont systemFontOfSize:15],
                                NSForegroundColorAttributeName: HJHexColor(0x666666)
                                } range:NSMakeRange(0, 2)];
    
    [centerText addAttributes:@{
                                NSFontAttributeName: [UIFont systemFontOfSize:20],
                                NSForegroundColorAttributeName: WYHQThemeColor
                                } range:NSMakeRange(centerText.length - specialMoney.length, specialMoney.length)];
    
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    [style setAlignment:NSTextAlignmentCenter];
    
    [centerText addAttributes:@{
                                NSParagraphStyleAttributeName: style
                                } range:NSMakeRange(0, enterString.length)];
    
    _chartView.centerAttributedText = centerText;
    
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
    
    _holeRadiusPercent = 0.58;
    
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
    l.font = [UIFont systemFontOfSize:9.f];
    l.textColor = HJHexColor(0x666666);
    
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
    chartView.holeRadiusPercent = _holeRadiusPercent;
    chartView.drawHoleEnabled = _drawHoleEnabled;
    chartView.transparentCircleRadiusPercent = 0.61;
    chartView.chartDescription.enabled = NO;
    [chartView setExtraOffsetsWithLeft:-100.f top:10.f right:100.f bottom:5.f];
    
    chartView.drawCenterTextEnabled = _drawHoleEnabled;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
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

#pragma mark - Super Method

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat totalHeight = self.hj_height;
    
    CGFloat fontSize = totalHeight * 9 / 200.0;
    
    CGFloat ySpace = totalHeight * 12.0 / 260.0;
    
    ChartLegend *l = _chartView.legend;
    l.font = [UIFont systemFontOfSize:fontSize];
    l.textColor = HJHexColor(0x666666);
    
    l.xEntrySpace = 10.0;
    l.yEntrySpace = ySpace;
    l.yOffset = 20.0;
    l.xOffset = 20.0;
    
    [_chartView setNeedsDisplay];
}

@end
