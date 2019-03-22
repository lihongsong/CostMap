#import <UIKit/UIKit.h>
@interface UNNoDataScene : UIView
@property (nonatomic, strong) UILabel *noDataLabel;
+ (instancetype)viewAddedTo:(UIView *)view;
+ (instancetype)viewAddedTo:(UIView *)view
                  imageName:(NSString *)imageName
                      title:(NSString *)title;
@end
