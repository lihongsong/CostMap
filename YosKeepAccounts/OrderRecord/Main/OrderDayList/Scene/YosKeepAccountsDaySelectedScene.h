#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class YosKeepAccountsDaySelectedScene;
@protocol YosKeepAccountsDaySelectedSceneDelegate<NSObject>
- (void)selectedScene:(YosKeepAccountsDaySelectedScene *)selectScene didChangeDate:(NSDate *)date;
- (void)selectedScene:(YosKeepAccountsDaySelectedScene *)selectScene didClickDate:(NSDate *)date;
@end
@interface YosKeepAccountsDaySelectedScene : UIView
@property (strong, nonatomic, readonly) NSDate *currentDate;
+ (instancetype)instance;
- (void)refreshDate:(NSDate *)date;
@property (weak, nonatomic) id<YosKeepAccountsDaySelectedSceneDelegate> delegate;
@end
NS_ASSUME_NONNULL_END
