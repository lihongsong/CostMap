#import "YosKeepAccountsChartPieScene.h"
@import Charts;
@interface YosKeepAccountsChartPieScene() <ChartViewDelegate>
@property (nonatomic, strong) PieChartView *chartScene;
@end
@implementation YosKeepAccountsChartPieScene {
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
    self.chartScene.holeRadiusPercent = holeRadiusPercent;
    [self.chartScene setNeedsDisplay];
}
- (void)setDrawHoleEnabled:(BOOL)drawHoleEnabled {
    _drawHoleEnabled = drawHoleEnabled;
    self.chartScene.drawHoleEnabled = drawHoleEnabled;
    self.chartScene.drawCenterTextEnabled = drawHoleEnabled;
    [self.chartScene setNeedsDisplay];
}
- (void)setEntitys:(NSArray<YosKeepAccountsOrderEntity *> *)entitys {
    _entitys = entitys;
    __block double sum = 0.0f;
    [self.entitys enumerateObjectsUsingBlock:^(YosKeepAccountsOrderEntity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sum += [obj.yka_wealth doubleValue];
    }];
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (int i = 0; i < entitys.count; i++) {
        YosKeepAccountsOrderEntity *model = entitys[i];
        CGFloat wealth = fabs([model.yka_wealth doubleValue]);
        NSString *percentStr;
        if (sum == 0.0f) {
            percentStr = @"0%";
        } else {
            percentStr = [NSString stringWithFormat:@"%.2f%@",fabs([model.yka_wealth doubleValue] / sum * 100), @"%"];
        }
        NSString *titleStr = [NSString stringWithFormat:@"%@    %@",parties[i % parties.count], percentStr];
        [values addObject:[[PieChartDataEntry alloc] initWithValue:wealth label:titleStr icon: [UIImage imageNamed:@"icon"]]];
    }
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:values label:nil];
    dataSet.sliceSpace = 2;
    dataSet.drawIconsEnabled = NO;
    dataSet.drawValuesEnabled = NO;
    dataSet.iconsOffset = CGPointMake(0, 40);
    dataSet.colors = [YosKeepAccountsOrderTool allOrderTypesColor];
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    [data setValueTextColor:UIColor.whiteColor];
    NSString *specialWealth = [NSString stringWithFormat:@"¥%.2f", fabs(sum)];
    NSString *enterString = [NSString stringWithFormat:@"支出\n%@", specialWealth];
    NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:enterString];
    [centerText addAttributes:@{
                                NSFontAttributeName: [UIFont systemFontOfSize:15],
                                NSForegroundColorAttributeName: HJHexColor(0x666666)
                                } range:NSMakeRange(0, 2)];
    [centerText addAttributes:@{
                                NSFontAttributeName: [UIFont systemFontOfSize:20],
                                NSForegroundColorAttributeName: YosKeepAccountsThemeColor
                                } range:NSMakeRange(centerText.length - specialWealth.length, specialWealth.length)];
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    [style setAlignment:NSTextAlignmentCenter];
    [centerText addAttributes:@{
                                NSParagraphStyleAttributeName: style
                                } range:NSMakeRange(0, enterString.length)];
    _chartScene.centerAttributedText = centerText;
    _chartScene.data = data;
    [_chartScene highlightValues:nil];
    [_chartScene animateWithXAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
}
#pragma mark - Public Method
- (void)animate {
    [_chartScene animateWithXAxisDuration:1.0 easingOption:ChartEasingOptionEaseInOutSine];
}
#pragma mark - Private Method
- (void)setUp {
    _holeRadiusPercent = 0.58;
    parties = [YosKeepAccountsOrderTool allOrderTypesName];
    _chartScene = [PieChartView new];
    [self addSubview:_chartScene];
    [_chartScene mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self setupPieChartScene:_chartScene];
    _chartScene.delegate = self;
    ChartLegend *l = _chartScene.legend;
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
    _chartScene.entryLabelColor = UIColor.whiteColor;
    _chartScene.entryLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f];
}
- (void)setupPieChartScene:(PieChartView *)chartScene {
    chartScene.userInteractionEnabled = NO;
    chartScene.usePercentValuesEnabled = NO;
    chartScene.drawSlicesUnderHoleEnabled = NO;
    chartScene.drawEntryLabelsEnabled = NO;
    chartScene.holeRadiusPercent = _holeRadiusPercent;
    chartScene.drawHoleEnabled = _drawHoleEnabled;
    chartScene.transparentCircleRadiusPercent = 0.61;
    chartScene.chartDescription.enabled = NO;
    [chartScene setExtraOffsetsWithLeft:-100.f top:5.f right:100.f bottom:5.f];
    chartScene.drawCenterTextEnabled = _drawHoleEnabled;
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    chartScene.rotationAngle = 0.0;
    chartScene.rotationEnabled = YES;
    chartScene.highlightPerTapEnabled = YES;
    ChartLegend *l = chartScene.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    l.verticalAlignment = ChartLegendVerticalAlignmentTop;
    l.orientation = ChartLegendOrientationVertical;
    l.drawInside = NO;
    l.xEntrySpace = 7.0;
    l.yEntrySpace = 0.0;
    l.yOffset = 0.0;
    l.maxSizePercent = 0.2;
}
#pragma mark - Notification Method
#pragma mark - Event & Target Methods
#pragma mark - Super Method
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat totalHeight = self.hj_height;
    CGFloat fontSize = totalHeight * 9 / 200.0;
    CGFloat ySpace = totalHeight * 12.0 / 260.0;
    ChartLegend *l = _chartScene.legend;
    l.font = [UIFont systemFontOfSize:fontSize];
    l.textColor = HJHexColor(0x666666);
    l.xEntrySpace = 10.0;
    l.yEntrySpace = ySpace;
    l.yOffset = 20.0;
    l.xOffset = 10.0;
    [_chartScene setExtraOffsetsWithLeft:-120.f top:5.f right:120.f bottom:5.f];
    [_chartScene setNeedsDisplay];
}
@end
