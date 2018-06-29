//
//  ChartsBaseView.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/10.
//  Copyright © 2018年 jason. All rights reserved.
//
/*
#import "ChartsBaseView.h"
@interface ChartsBaseView()
{
@protected
    NSArray *parties;
}
@property(nonatomic,strong)ChartViewBase * chartView;
@end

@implementation ChartsBaseView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
         [self initialize];
    }
    return self;
}

- (void)initialize
{
    // 每块名称
    parties = @[
                @"Party A", @"Party B", @"Party C", @"Party D", @"Party E", @"Party F",
                @"Party G", @"Party H", @"Party I", @"Party J", @"Party K", @"Party L",
                @"Party M", @"Party N", @"Party O", @"Party P", @"Party Q", @"Party R",
                @"Party S", @"Party T", @"Party U", @"Party V", @"Party W", @"Party X",
                @"Party Y", @"Party Z"
                ];
}

- (void) setToggleValues:(BOOL)toggleValues{
    for (id<IChartDataSet> set in _chartView.data.dataSets)
    {
        set.drawValuesEnabled = toggleValues;
    }
    
    [_chartView setNeedsDisplay];
}
- (void)setToggleIcons:(BOOL)toggleIcons{
    for (id<IChartDataSet> set in _chartView.data.dataSets)
    {
        set.drawIconsEnabled = toggleIcons;
    }
    
    [_chartView setNeedsDisplay];
}

- (void)setToggleHighlight:(BOOL)toggleHighlight{
    _chartView.data.highlightEnabled = toggleHighlight;
    [_chartView setNeedsDisplay];
}

- (void)setAnimateDirection:(AnimateDirection)animateDirection{
    switch (animateDirection) {
        case animateDirectionX:
            {
                 [_chartView animateWithXAxisDuration:3.0];            }
            break;
        case animateDirectionY:
        {
            [_chartView animateWithYAxisDuration:3.0];
            
        }
            break;
        case animateDirectionXY:
        {
            [_chartView animateWithXAxisDuration:3.0 yAxisDuration:3.0];
        }
            break;
        default:
            break;
    }
}

//保存相册，可能用到，可能用不到
- (void)saveToGallery{
    UIImageWriteToSavedPhotosAlbum([_chartView getChartImageWithTransparent:NO], nil, nil, nil);
}

- (void) setTogglePinchZoom:(BOOL)togglePinchZoom{
    BarLineChartViewBase *barLineChart = (BarLineChartViewBase *)_chartView;
    barLineChart.pinchZoomEnabled = togglePinchZoom;
    
    [_chartView setNeedsDisplay];
}

- (void)setToggleAutoScaleMinMax:(BOOL)toggleAutoScaleMinMax{
    BarLineChartViewBase *barLineChart = (BarLineChartViewBase *)_chartView;
    barLineChart.autoScaleMinMaxEnabled = toggleAutoScaleMinMax;
    
    [_chartView notifyDataSetChanged];
}

- (void)setShouldHideData:(BOOL)shouldHideData{
    _shouldHideData = shouldHideData;
    [self updateChartData];
}

- (void)setToggleBarBorders:(BOOL)toggleBarBorders{
    for (id<IBarChartDataSet, NSObject> set in _chartView.data.dataSets)
    {
        if ([set conformsToProtocol:@protocol(IBarChartDataSet)])
        {
            set.barBorderWidth = set.barBorderWidth == 1.0 ? 0.0 : 1.0;
        }
    }
    [_chartView setNeedsDisplay];
}

#pragma mark - Stubs for chart view
// Override this
- (void)updateChartData
{
    
}

- (void)setupPieChartView:(PieChartView *)chartView
{
    chartView.usePercentValuesEnabled = YES;
    chartView.drawSlicesUnderHoleEnabled = NO;
    chartView.holeRadiusPercent = 0.58;
    chartView.transparentCircleRadiusPercent = 0.61;
    chartView.chartDescription.enabled = NO;
    [chartView setExtraOffsetsWithLeft:5.f top:10.f right:5.f bottom:5.f];
    
    chartView.drawCenterTextEnabled = YES;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@"Charts\nby Daniel Cohen Gindi"];
    [centerText setAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:13.f],
                                NSParagraphStyleAttributeName: paragraphStyle
                                } range:NSMakeRange(0, centerText.length)];
    [centerText addAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f],
                                NSForegroundColorAttributeName: UIColor.grayColor
                                } range:NSMakeRange(10, centerText.length - 10)];
    [centerText addAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:11.f],
                                NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]
                                } range:NSMakeRange(centerText.length - 19, 19)];
    //chartView.centerAttributedText = centerText;
    
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

- (void)setupRadarChartView:(RadarChartView *)chartView
{
    chartView.chartDescription.enabled = NO;
}

- (void)setupBarLineChartView:(BarLineChartViewBase *)chartView
{
    chartView.chartDescription.enabled = NO;
    
    chartView.drawGridBackgroundEnabled = NO;
    
    chartView.dragEnabled = YES;
    [chartView setScaleEnabled:YES];
    chartView.pinchZoomEnabled = NO;
    
    // ChartYAxis *leftAxis = chartView.leftAxis;
    
    ChartXAxis *xAxis = chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    
    chartView.rightAxis.enabled = NO;
}



@end
 */
