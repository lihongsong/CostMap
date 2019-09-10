#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class CostMapDaySelectedScene;
@protocol CostMapDaySelectedSceneDelegate<NSObject>
- (void)selectedScene:(CostMapDaySelectedScene *)selectScene didChangeDate:(NSDate *)date;
- (void)selectedScene:(CostMapDaySelectedScene *)selectScene didClickDate:(NSDate *)date;
@end
@interface CostMapDaySelectedScene : UIView
@property (strong, nonatomic, readonly) NSDate *currentDate;
+ (instancetype)instance;
- (void)refreshDate:(NSDate *)date;
@property (weak, nonatomic) id<CostMapDaySelectedSceneDelegate> delegate;
@end
NS_ASSUME_NONNULL_END
