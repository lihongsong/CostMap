//
//  NSDate+HJNormalExtension.m
//  HJCategories
//
//  Created by yoser on 2017/12/20.
//

#import "NSDate+HJNormalExtension.h"

#define HJSharedDateFormatter (NSDateFormatter *)[NSDate hj_sharedDateFormatter]

@implementation NSDate (HJNormalExtension)

+ (NSDateFormatter *)hj_sharedDateFormatter{
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
    });
    return formatter;
}

- (NSUInteger)hj_day {
    return [NSDate hj_day:self];
}

- (NSUInteger)hj_month {
    return [NSDate hj_month:self];
}

- (NSUInteger)hj_year {
    return [NSDate hj_year:self];
}

- (NSUInteger)hj_hour {
    return [NSDate hj_hour:self];
}

- (NSUInteger)hj_minute {
    return [NSDate hj_minute:self];
}

- (NSUInteger)hj_second {
    return [NSDate hj_second:self];
}

+ (NSUInteger)hj_day:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents day];
}

+ (NSUInteger)hj_month:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)hj_year:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)hj_hour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)hj_minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)hj_second:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}

- (NSUInteger)hj_daysInYear {
    return [NSDate hj_daysInYear:self];
}

+ (NSDate *)hj_getToday{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}

+ (NSUInteger)hj_daysInYear:(NSDate *)date {
    return [self hj_isLeapYear:date] ? 366 : 365;
}

- (BOOL)hj_isLeapYear {
    return [NSDate hj_isLeapYear:self];
}

+ (BOOL)hj_isLeapYear:(NSDate *)date {
    NSUInteger year = [date hj_year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)hj_formatYMD {
    return [NSDate hj_formatYMD:self];
}

+ (NSString *)hj_formatYMD:(NSDate *)date {
    return [NSString stringWithFormat:@"%lu-%02lu-%02lu",(unsigned long)[date hj_year],(unsigned long)[date hj_month], (unsigned long)[date hj_day]];
}

- (NSUInteger)hj_weeksOfMonth {
    return [NSDate hj_weeksOfMonth:self];
}

+ (NSUInteger)hj_weeksOfMonth:(NSDate *)date {
    return [[date hj_lastdayOfMonth] hj_weekOfYear] - [[date hj_begindayOfMonth] hj_weekOfYear] + 1;
}

- (NSUInteger)hj_weekOfYear {
    return [NSDate hj_weekOfYear:self];
}

+ (NSUInteger)hj_weekOfYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date hj_year];
    
    NSDate *lastdate = [date hj_lastdayOfMonth];
    
    for (i = 1;[[lastdate hj_dateAfterDay:-7 * i] hj_year] == year; i++) {
        
    }
    
    return i;
}

- (NSDate *)hj_dateAfterDay:(NSUInteger)day {
    return [NSDate hj_dateAfterDate:self day:day];
}

+ (NSDate *)hj_dateAfterDate:(NSDate *)date day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}

- (NSDate *)hj_dateAfterMonth:(NSUInteger)month {
    return [NSDate hj_dateAfterDate:self month:month];
}

+ (NSDate *)hj_dateAfterDate:(NSDate *)date month:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

- (NSDate *)hj_begindayOfMonth {
    return [NSDate hj_begindayOfMonth:self];
}

+ (NSDate *)hj_begindayOfMonth:(NSDate *)date {
    return [self hj_dateAfterDate:date day:-[date hj_day] + 1];
}

- (NSDate *)hj_lastdayOfMonth {
    return [NSDate hj_lastdayOfMonth:self];
}

+ (NSDate *)hj_lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self hj_begindayOfMonth:date];
    return [[lastDate hj_dateAfterMonth:1] hj_dateAfterDay:-1];
}

- (NSUInteger)hj_daysAgo {
    return [NSDate hj_daysAgo:self];
}

+ (NSUInteger)hj_daysAgo:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];
}

- (NSInteger)hj_weekday {
    return [NSDate hj_weekday:self];
}

+ (NSInteger)hj_weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)hj_dayFromWeekday {
    return [NSDate hj_dayFromWeekday:self];
}

+ (NSString *)hj_dayFromWeekday:(NSDate *)date {
    switch([date hj_weekday]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

- (BOOL)hj_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

- (BOOL)hj_isToday {
    return [self hj_isSameDay:[NSDate date]];
}

- (NSDate *)hj_dateByAddingDays:(NSUInteger)days {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)hj_monthWithMonthNumber:(NSInteger)month {
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)hj_stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date hj_stringWithFormat:format];
}

- (NSString *)hj_stringWithFormat:(NSString *)format {
    
    [HJSharedDateFormatter setDateFormat:format];
    
    NSString *retStr = [HJSharedDateFormatter stringFromDate:self];
    
    return retStr;
}

+ (NSDate *)hj_dateWithString:(NSString *)string format:(NSString *)format {
    
    [HJSharedDateFormatter setDateFormat: format];
    
    NSDate *destDate= [HJSharedDateFormatter dateFromString:string];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:destDate];
    NSDate *localeDate = [destDate  dateByAddingTimeInterval: interval];
    
    return localeDate;
}

- (NSUInteger)hj_daysInMonth:(NSUInteger)month {
    return [NSDate hj_daysInMonth:self month:month];
}

+ (NSUInteger)hj_daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date hj_isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)hj_daysInMonth {
    return [NSDate hj_daysInMonth:self];
}

+ (NSUInteger)hj_daysInMonth:(NSDate *)date {
    return [self hj_daysInMonth:date month:[date hj_month]];
}

- (NSString *)hj_timeInfo {
    return [NSDate hj_timeInfoWithDate:self];
}

+ (NSString *)hj_timeInfoWithDate:(NSDate *)date {
    return [self hj_timeInfoWithDateString:[self hj_stringWithDate:date format:[self hj_ymdHmsFormat]]];
}

+ (NSString *)hj_timeInfoWithDateString:(NSString *)dateString {
    NSDate *date = [self hj_dateWithString:dateString format:[self hj_ymdHmsFormat]];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate hj_month] - [date hj_month]);
    int year = (int)([curDate hj_year] - [date hj_year]);
    int day = (int)([curDate hj_day] - [date hj_day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate hj_month] == 1 && [date hj_month] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self hj_daysInMonth:date month:[date hj_month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate hj_day] + (totalDays - (int)[date hj_day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[curDate hj_month];
            int preMonth = (int)[date hj_month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}

- (NSString *)hj_ymdFormat {
    return [NSDate hj_ymdFormat];
}

- (NSString *)hj_hmsFormat {
    return [NSDate hj_hmsFormat];
}

- (NSString *)hj_ymdHmsFormat {
    return [NSDate hj_ymdHmsFormat];
}

+ (NSString *)hj_ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)hj_hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)hj_ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self hj_ymdFormat], [self hj_hmsFormat]];
}

- (NSDate *)hj_offsetYears:(int)numYears {
    return [NSDate hj_offsetYears:numYears fromDate:self];
}

+ (NSDate *)hj_offsetYears:(int)numYears fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:numYears];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)hj_offsetMonths:(int)numMonths {
    return [NSDate hj_offsetMonths:numMonths fromDate:self];
}

+ (NSDate *)hj_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)hj_offsetDays:(int)numDays {
    return [NSDate hj_offsetDays:numDays fromDate:self];
}

+ (NSDate *)hj_offsetDays:(int)numDays fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)hj_offsetHours:(int)hours {
    return [NSDate hj_offsetHours:hours fromDate:self];
}

+ (NSDate *)hj_offsetHours:(int)numHours fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:numHours];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}


@end
