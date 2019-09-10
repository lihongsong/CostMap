#import "NSDate+CostMapAdd.h"
static const NSCalendarUnit unitFlags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);
@implementation NSDate (CostMapAdd)
+ (NSCalendar *)calendar {
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar) {
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    }
    return sharedCalendar;
}
- (NSInteger)year {
    NSDateComponents *components = [[NSDate calendar] components:unitFlags fromDate:self];
    return components.year;
}
- (NSInteger)month {
    NSDateComponents *components = [[NSDate calendar] components:unitFlags fromDate:self];
    return components.month;
}
- (NSInteger)day {
    NSDateComponents *components = [[NSDate calendar] components:unitFlags fromDate:self];
    return components.day;
}
- (NSInteger)hour {
    NSDateComponents *components = [[NSDate calendar] components:unitFlags fromDate:self];
    return components.hour;
}
- (NSInteger)minute {
    NSDateComponents *comps = [[NSDate calendar] components:unitFlags fromDate:self];
    return comps.minute;
}
- (NSInteger)second {
    NSDateComponents *components = [[NSDate calendar] components:unitFlags fromDate:self];
    return components.second;
}
- (NSInteger)weekday {
    NSDateComponents *components = [[NSDate calendar] components:unitFlags fromDate:self];
    return components.weekday;
}
+ (NSDate *)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    NSCalendar *calendar = [NSDate calendar];
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    if (year >= 0) {
        components.year = year;
    }
    if (month >= 0) {
        components.month = month;
    }
    if (day >= 0) {
        components.day = day;
    }
    if (hour >= 0) {
        components.hour = hour;
    }
    if (minute >= 0) {
        components.minute = minute;
    }
    if (second >= 0) {
        components.second = second;
    }
    NSDate *date = [calendar dateFromComponents:components];
    return date;
}
+ (NSDate *)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute {
    return [self setYear:year month:month day:day hour:hour minute:minute second:-1];
}
+ (NSDate *)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    return [self setYear:year month:month day:day hour:-1 minute:-1 second:-1];
}
+ (NSDate *)setYear:(NSInteger)year month:(NSInteger)month {
    return [self setYear:year month:month day:-1 hour:-1 minute:-1 second:-1];
}
+ (NSDate *)setYear:(NSInteger)year {
    return [self setYear:year month:-1 day:-1 hour:-1 minute:-1 second:-1];
}
+ (NSDate *)setMonth:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute {
    return [self setYear:-1 month:month day:day hour:hour minute:minute second:-1];
}
+ (NSDate *)setMonth:(NSInteger)month day:(NSInteger)day {
    return [self setYear:-1 month:month day:day hour:-1 minute:-1 second:-1];
}
+ (NSDate *)setHour:(NSInteger)hour minute:(NSInteger)minute {
    return [self setYear:-1 month:-1 day:-1 hour:hour minute:minute second:-1];
}
+ (NSString *)getDateString:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    dateFormatter.dateFormat = format;
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
+ (NSDate *)getDate:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    dateFormatter.dateFormat = format;
    NSDate *destDate = [dateFormatter dateFromString:dateString];
    return destDate;
}
+ (NSUInteger)getDaysInYear:(NSInteger)year month:(NSInteger)month {
    BOOL isLeapYear = year % 4 == 0 ? (year % 100 == 0 ? (year % 400 == 0 ? YES : NO) : YES) : NO;
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12: {
            return 31;
            break;
        }
        case 4:
        case 6:
        case 9:
        case 11: {
            return 30;
            break;
        }
        case 2: {
            if (isLeapYear) {
                return 29;
                break;
            } else {
                return 28;
                break;
            }
        }
        default:
            break;
    }
    return 0;
}
+ (NSUInteger)getDaysInYear2:(NSInteger)year month:(NSInteger)month {
    NSDate *date = [NSDate getDate:[NSString stringWithFormat:@"%zi-%zi", year, month] format:@"yyyy-MM"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}
+ (NSString *)currentTimestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval interval = [date timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%0.f", interval];
    return timeString;
}
+ (NSString *)currentDateString {
    return [self currentDateStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}
+ (NSString *)currentDateStringWithFormat:(NSString *)formatterStr {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatterStr;
    NSString *currentDateStr = [formatter stringFromDate:currentDate];
    return currentDateStr;
}
+ (NSString *)dateStringWithDelta:(NSTimeInterval)delta {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:delta];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter stringFromDate:date];
}
+ (NSInteger)deltaDays:(NSString *)beginDateString endDate:(NSString *)endDateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *beginDate = [dateFormatter dateFromString:beginDateString];
    NSDate *endDate = [dateFormatter dateFromString:endDateString];
    NSTimeInterval deltaTime = [endDate timeIntervalSinceDate:beginDate];
    NSInteger days = (NSInteger) deltaTime / (24 * 60 * 60);
    return days;
}
+ (NSString *)date:(NSString *)dateString format:(NSString *)format addDays:(NSInteger)days {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    NSDate *myDate = [dateFormatter dateFromString:dateString];
    NSDate *newDate = [myDate dateByAddingTimeInterval:60 * 60 * 24 * days];
    NSString *newDateString = [dateFormatter stringFromDate:newDate];
    return newDateString;
}
- (NSComparisonResult)br_compare:(NSDate *)targetDate format:(NSString *)format {
    NSString *dateString1 = [NSDate getDateString:self format:format];
    NSString *dateString2 = [NSDate getDateString:targetDate format:format];
    NSDate *date1 = [NSDate getDate:dateString1 format:format];
    NSDate *date2 = [NSDate getDate:dateString2 format:format];
    if ([date1 compare:date2] == NSOrderedDescending) {
        return 1;
    } else if ([date1 compare:date2] == NSOrderedAscending) {
        return -1;
    } else {
        return 0;
    }
}
@end
