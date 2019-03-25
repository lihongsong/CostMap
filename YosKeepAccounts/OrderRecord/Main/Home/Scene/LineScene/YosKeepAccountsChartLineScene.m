#import "YosKeepAccountsChartLineScene.h"
#import "YosKeepAccountsOrderTool.h"
@import Charts;
@interface YosKeepAccountsChartLineScene() <ChartViewDelegate>
@property (nonatomic, strong) BarChartView *chartScene;
@end
@implementation YosKeepAccountsChartLineScene {
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
- (void)setEntitys:(NSArray<YosKeepAccountsOrderEntity *> *)entitys {
    _entitys = entitys;
    [self updateChartData];
}
#pragma mark - Public Method
- (void)animate {
    [_chartScene animateWithYAxisDuration:1.0 easingOption:ChartEasingOptionEaseInOutSine];
}
#pragma mark - Private Method
- (void)setUp {
    parties = [YosKeepAccountsOrderTool allOrderTypesName];
    _chartScene = [BarChartView new];
    [self addSubview:_chartScene];
    [_chartScene mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    _chartScene.delegate = self;
    _chartScene.chartDescription.enabled = NO;
    _chartScene.userInteractionEnabled = NO;
    _chartScene.maxVisibleCount = 60;
    _chartScene.pinchZoomEnabled = NO;
    _chartScene.drawBarShadowEnabled = NO;
    _chartScene.drawGridBackgroundEnabled = NO;
    _chartScene.rightAxis.drawAxisLineEnabled = NO;
    _chartScene.rightAxis.drawLabelsEnabled = NO;
    _chartScene.leftAxis.axisLineColor = YosKeepAccountsThemeColor;
    _chartScene.xAxis.axisLineColor = YosKeepAccountsThemeColor;
    ChartXAxis *xAxis = _chartScene.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:parties];
    _chartScene.leftAxis.drawGridLinesEnabled = NO;
    _chartScene.rightAxis.drawGridLinesEnabled = NO;
    _chartScene.legend.enabled = NO;
    _chartScene.xAxis.labelTextColor = HJHexColor(k0x666666);
    _chartScene.leftAxis.labelTextColor = HJHexColor(k0x666666);
    _chartScene.xAxis.yOffset = 5;
    _chartScene.extraBottomOffset = 5;
    [self updateChartData];
}
- (void)updateChartData {
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < _entitys.count; i++) {
        YosKeepAccountsOrderEntity *model = _entitys[i];
        double val = fabs([model.yka_wealth floatValue]);
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:val]];
    }
    BarChartDataSet *set1 = nil;
    if (_chartScene.data.dataSetCount > 0) {
        set1 = (BarChartDataSet *)_chartScene.data.dataSets[0];
        set1.values = yVals;
        [_chartScene.data notifyDataChanged];
        [_chartScene notifyDataSetChanged];
    } else {
        set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"DataSet"];
        set1.colors = [YosKeepAccountsOrderTool allOrderTypesColor];
        set1.drawValuesEnabled = NO;
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        _chartScene.data = data;
        _chartScene.fitBars = YES;
    }
    [_chartScene setNeedsDisplay];
    [_chartScene animateWithYAxisDuration:0.5];
}
#pragma mark - Notification Method
#pragma mark - Event & Target Methods
@end
