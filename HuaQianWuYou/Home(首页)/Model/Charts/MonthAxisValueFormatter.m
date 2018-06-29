//
//  MonthAxisValueFormatter.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/11.
//  Copyright © 2018年 jason. All rights reserved.
//备用
/*
#import "MonthAxisValueFormatter.h"

@implementation MonthAxisValueFormatter{
    NSArray *months;
    __weak BarLineChartViewBase *_chart;
}

- (id)initForChart:(BarLineChartViewBase *)chart
{
    self = [super init];
    if (self)
    {
        self->_chart = chart;
        
        months = @[
                   @"1月", @"2月", @"3月",
                   @"4月", @"5月", @"6月",
                   @"7月", @"8月", @"9月",
                   @"10月", @"11月", @"12月"
                   ];
    }
    return self;
}

- (NSString *)stringForValue:(double)value
                        axis:(ChartAxisBase *)axis
{
    int month = (int)value;
    int year = [self determineYearForMonth:month];
    
    NSString *monthName = months[month % months.count];
    NSString *yearName = [@(year) stringValue];
    
    if (_chart.visibleXRange > 12 * 1)
    {
        return [NSString stringWithFormat:@"%@ %@", monthName, yearName];
    }
    else
    {
        return [NSString stringWithFormat:@"%@", monthName];
    }
}

//- (int)daysForMonth:(int)month year:(int)year
//{
//    // month is 0-based
//
//    if (month == 1)
//    {
//        BOOL is29Feb = NO;
//
//        if (year < 1582)
//        {
//            is29Feb = (year < 1 ? year + 1 : year) % 4 == 0;
//        }
//        else if (year > 1582)
//        {
//            is29Feb = year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
//        }
//
//        return is29Feb ? 29 : 28;
//    }
//
//    if (month == 3 || month == 5 || month == 8 || month == 10)
//    {
//        return 30;
//    }
//
//    return 31;
//}
//
//- (int)determineMonthForDayOfYear:(int)dayOfYear
//{
//    int month = -1;
//    int days = 0;
//
//    while (days < dayOfYear)
//    {
//        month = month + 1;
//
//        if (month >= 12)
//            month = 0;
//
//        int year = [self determineYearForDays:days];
//        days += [self daysForMonth:month year:year];
//    }
//
//    return MAX(month, 0);
//}
//
//
//- (int)determineDayOfMonthForDays:(int)days month:(int)month
//{
//    int count = 0;
//    int daysForMonths = 0;
//
//    while (count < month)
//    {
//        int year = [self determineYearForDays:days];
//        daysForMonths += [self daysForMonth:count % 12 year:year];
//        count++;
//    }
//
//    return days - daysForMonths;
//}

- (int)determineYearForMonth:(int)month
{
    if (month <= 12)
    {
        return 2016;
    }
    else if (month <= 24)
    {
        return 2017;
    }
    else if (month <= 36)
    {
        return 2018;
    }
    else if (month <= 48)
    {
        return 2019;
    }
    
    return 2020;
}
 

@end
 */
