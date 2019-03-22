#import "GradientCompareBarScene.h"
@implementation GradientCompareBarScene
-(void)initialize{
}
-(YosChartScene  *)barChartScene{
    if (_barChartScene == nil) {
        _barChartScene = [[YosChartScene alloc]init];
        _barChartScene.delegate = self;
    }
    return _barChartScene;
}
-(void)refreshData {
    [self addSubview:self.barChartScene];
    self.barChartScene.backgroundColor = [UIColor whiteColor];
    self.barChartScene.scrollEnabled = NO;;
    self.barChartEntity= [self configureTheChartEntity];
    [self.barChartScene yos_method_drawChartWithChartEntity:self.barChartEntity];
}
-(YosChartEntity *)configureTheChartEntity {
    YosChartEntity *aaChartEntity = YosObject(YosChartEntity)
    .tooltipEnabledSet(false) 
    .chartTypeSet(YosChartTypeColumn)
    .titleSet(@"")
    .subtitleSet(@"")
    .colorsThemeSet([self configureTheRandomColorArrayWithColorNumber:14])
    .gradientColorEnabledSet(true)
    .borderRadiusSet(@5)
    .yAxisTitleSet(@"")
    .yAxisLineWidthSet(@0)
    .yAxisMaxSet(@(10))
    .yAxisTickPositionsSet(@[@(0),@(2),@(4),@(6),@(8),@(10)])
    .categoriesSet(@[@"衣", @"食", @"住", @"行", @"A", @"B"])
    .seriesSet(@[
                 YosObject(YosSeriesElement)
                 .nameSet(@"")
                 .dataSet(self.lendArr)
                 ]
               );
    return aaChartEntity;
}
- (void)layoutSubviews {
    CGFloat chartSceneWidth  = self.hj_width;
    CGFloat chartSceneHeight = self.hj_height;
    self.barChartScene.frame = CGRectMake(0, 0, chartSceneWidth, chartSceneHeight);
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
#pragma mark -- YosChartScene delegate
- (void)YosChartSceneDidFinishLoad {
}
@end
