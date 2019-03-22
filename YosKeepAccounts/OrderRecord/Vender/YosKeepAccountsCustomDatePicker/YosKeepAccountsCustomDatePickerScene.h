#import <UIKit/UIKit.h>
#import "NSDate+YosKeepAccountsAdd.h"
#import "YosKeepAccountsCustomDatePickerBaseScene.h"
#define YosKeepAccountsCustomErrorLog(...) NSLog(@"reason: %@", [NSString stringWithFormat:__VA_ARGS__])
typedef NS_ENUM(NSInteger, YosKeepAccountsCustomDatePickerMode) {
            YosKeepAccountsCustomDatePickerModeTime,              
            YosKeepAccountsCustomDatePickerModeDate,              
            YosKeepAccountsCustomDatePickerModeDateAndTime,       
            YosKeepAccountsCustomDatePickerModeCountDownTimer,    
            YosKeepAccountsCustomDatePickerModeYMDHM,      
            YosKeepAccountsCustomDatePickerModeMDHM,       
            YosKeepAccountsCustomDatePickerModeYMD,        
            YosKeepAccountsCustomDatePickerModeYM,         
            YosKeepAccountsCustomDatePickerModeY,          
            YosKeepAccountsCustomDatePickerModeMD,         
            YosKeepAccountsCustomDatePickerModeHM          
};
typedef void(^YosKeepAccountsCustomDateResultBlock)(NSString *selectValue);
typedef void(^YosKeepAccountsCustomDateCancelBlock)(void);
@interface YosKeepAccountsCustomDatePickerScene : YosKeepAccountsCustomDatePickerBaseScene
+ (YosKeepAccountsCustomDatePickerScene *)showDatePickerWithTitle:(NSString *)title
                                           dateType:(YosKeepAccountsCustomDatePickerMode)type
                                    defaultSelValue:(NSString *)defaultSelValue
                                        resultBlock:(YosKeepAccountsCustomDateResultBlock)resultBlock;
+ (YosKeepAccountsCustomDatePickerScene *)showDatePickerWithTitle:(NSString *)title
                                           dateType:(YosKeepAccountsCustomDatePickerMode)type
                                    defaultSelValue:(NSString *)defaultSelValue
                                            minDate:(NSDate *)minDate
                                            maxDate:(NSDate *)maxDate
                                       isAutoSelect:(BOOL)isAutoSelect
                                         themeColor:(UIColor *)themeColor
                                        resultBlock:(YosKeepAccountsCustomDateResultBlock)resultBlock;
+ (YosKeepAccountsCustomDatePickerScene *)showDatePickerWithTitle:(NSString *)title
                                           dateType:(YosKeepAccountsCustomDatePickerMode)type
                                    defaultSelValue:(NSString *)defaultSelValue
                                            minDate:(NSDate *)minDate
                                            maxDate:(NSDate *)maxDate
                                       isAutoSelect:(BOOL)isAutoSelect
                                         themeColor:(UIColor *)themeColor
                                        resultBlock:(YosKeepAccountsCustomDateResultBlock)resultBlock
                                        cancelBlock:(YosKeepAccountsCustomDateCancelBlock)cancelBlock;
@end
