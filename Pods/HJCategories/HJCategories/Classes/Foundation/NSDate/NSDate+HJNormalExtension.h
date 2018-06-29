//
//  NSDate+HJNormalExtension.h
//  HJCategories
//
//  Created by yoser on 2017/12/20.
//

#import <Foundation/Foundation.h>

@interface NSDate (HJNormalExtension)

/**
 日期格式化对象，使用单例，提高性能
 
 @return 日期格式
 */
+ (NSDateFormatter *)hj_sharedDateFormatter;

/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)hj_day;
- (NSUInteger)hj_month;
- (NSUInteger)hj_year;
- (NSUInteger)hj_hour;
- (NSUInteger)hj_minute;
- (NSUInteger)hj_second;
+ (NSUInteger)hj_day:(NSDate *)date;
+ (NSUInteger)hj_month:(NSDate *)date;
+ (NSUInteger)hj_year:(NSDate *)date;
+ (NSUInteger)hj_hour:(NSDate *)date;
+ (NSUInteger)hj_minute:(NSDate *)date;
+ (NSUInteger)hj_second:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)hj_daysInYear;
+ (NSUInteger)hj_daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)hj_isLeapYear;
+ (BOOL)hj_isLeapYear:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)hj_weekOfYear;
+ (NSUInteger)hj_weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)hj_formatYMD;
+ (NSString *)hj_formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)hj_weeksOfMonth;
+ (NSUInteger)hj_weeksOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)hj_begindayOfMonth;
+ (NSDate *)hj_begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)hj_lastdayOfMonth;
+ (NSDate *)hj_lastdayOfMonth:(NSDate *)date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)hj_dateAfterDay:(NSUInteger)day;
+ (NSDate *)hj_dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)hj_dateAfterMonth:(NSUInteger)month;
+ (NSDate *)hj_dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)hj_offsetYears:(int)numYears;
+ (NSDate *)hj_offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)hj_offsetMonths:(int)numMonths;
+ (NSDate *)hj_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)hj_offsetDays:(int)numDays;
+ (NSDate *)hj_offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)hj_offsetHours:(int)hours;
+ (NSDate *)hj_offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)hj_daysAgo;
+ (NSUInteger)hj_daysAgo:(NSDate *)date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)hj_weekday;
+ (NSInteger)hj_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)hj_dayFromWeekday;
+ (NSString *)hj_dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)hj_isSameDay:(NSDate *)anotherDate;

/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
- (BOOL)hj_isToday;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)hj_dateByAddingDays:(NSUInteger)days;

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
+ (NSString *)hj_monthWithMonthNumber:(NSInteger)month;

/**
 * 根据日期返回字符串
 */
+ (NSString *)hj_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)hj_stringWithFormat:(NSString *)format;
+ (NSDate *)hj_dateWithString:(NSString *)string format:(NSString *)format;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)hj_daysInMonth:(NSUInteger)month;
+ (NSUInteger)hj_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)hj_daysInMonth;
+ (NSUInteger)hj_daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)hj_timeInfo;
+ (NSString *)hj_timeInfoWithDate:(NSDate *)date;
+ (NSString *)hj_timeInfoWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)hj_ymdFormat;
- (NSString *)hj_hmsFormat;
- (NSString *)hj_ymdHmsFormat;
+ (NSString *)hj_ymdFormat;
+ (NSString *)hj_hmsFormat;
+ (NSString *)hj_ymdHmsFormat;

//获取系统默认时区现在时间
+ (NSDate *)hj_getToday;

@end
