#import <Foundation/Foundation.h>
@interface NSDate (YosKeepAccountsAdd)
@property(readonly) NSInteger year;    
@property(readonly) NSInteger month;   
@property(readonly) NSInteger day;     
@property(readonly) NSInteger hour;    
@property(readonly) NSInteger minute;  
@property(readonly) NSInteger second;  
@property(readonly) NSInteger weekday; 
+ (NSDate *)setYear:(NSInteger)year;
+ (NSDate *)setYear:(NSInteger)year month:(NSInteger)month;
+ (NSDate *)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+ (NSDate *)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;
+ (NSDate *)setMonth:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;
+ (NSDate *)setMonth:(NSInteger)month day:(NSInteger)day;
+ (NSDate *)setHour:(NSInteger)hour minute:(NSInteger)minute;
+ (NSString *)getDateString:(NSDate *)date format:(NSString *)format;
+ (NSDate *)getDate:(NSString *)dateString format:(NSString *)format;
+ (NSUInteger)getDaysInYear:(NSInteger)year month:(NSInteger)month;
+ (NSString *)currentTimestamp;
+ (NSString *)currentDateString;
+ (NSString *)currentDateStringWithFormat:(NSString *)formatterStr;
+ (NSInteger)deltaDays:(NSString *)beginDateString endDate:(NSString *)endDateString;
+ (NSString *)dateStringWithDelta:(NSTimeInterval)delta;
+ (NSString *)date:(NSString *)dateString format:(NSString *)format addDays:(NSInteger)days;
- (NSComparisonResult)br_compare:(NSDate *)targetDate format:(NSString *)format;
@end
