#import <UIKit/UIKit.h>
#import "NSDate+CostMapAdd.h"
#import "CostMapCustomDatePickerBaseScene.h"
#define CostMapCustomErrorLog(...) NSLog(@"reason: %@", [NSString stringWithFormat:__VA_ARGS__])
typedef NS_ENUM(NSInteger, CostMapCustomDatePickerMode) {
            CostMapCustomDatePickerModeTime,              
            CostMapCustomDatePickerModeDate,              
            CostMapCustomDatePickerModeDateAndTime,       
            CostMapCustomDatePickerModeCountDownTimer,    
            CostMapCustomDatePickerModeYMDHM,      
            CostMapCustomDatePickerModeMDHM,       
            CostMapCustomDatePickerModeYMD,        
            CostMapCustomDatePickerModeYM,         
            CostMapCustomDatePickerModeY,          
            CostMapCustomDatePickerModeMD,         
            CostMapCustomDatePickerModeHM          
};
typedef void(^CostMapCustomDateResultBlock)(NSString *selectValue);
typedef void(^CostMapCustomDateCancelBlock)(void);
@interface CostMapCustomDatePickerScene : CostMapCustomDatePickerBaseScene
+ (CostMapCustomDatePickerScene *)showDatePickerWithTitle:(NSString *)title
                                           dateType:(CostMapCustomDatePickerMode)type
                                    defaultSelValue:(NSString *)defaultSelValue
                                        resultBlock:(CostMapCustomDateResultBlock)resultBlock;
+ (CostMapCustomDatePickerScene *)showDatePickerWithTitle:(NSString *)title
                                           dateType:(CostMapCustomDatePickerMode)type
                                    defaultSelValue:(NSString *)defaultSelValue
                                            minDate:(NSDate *)minDate
                                            maxDate:(NSDate *)maxDate
                                       isAutoSelect:(BOOL)isAutoSelect
                                         themeColor:(UIColor *)themeColor
                                        resultBlock:(CostMapCustomDateResultBlock)resultBlock;
+ (CostMapCustomDatePickerScene *)showDatePickerWithTitle:(NSString *)title
                                           dateType:(CostMapCustomDatePickerMode)type
                                    defaultSelValue:(NSString *)defaultSelValue
                                            minDate:(NSDate *)minDate
                                            maxDate:(NSDate *)maxDate
                                       isAutoSelect:(BOOL)isAutoSelect
                                         themeColor:(UIColor *)themeColor
                                        resultBlock:(CostMapCustomDateResultBlock)resultBlock
                                        cancelBlock:(CostMapCustomDateCancelBlock)cancelBlock;
@end
