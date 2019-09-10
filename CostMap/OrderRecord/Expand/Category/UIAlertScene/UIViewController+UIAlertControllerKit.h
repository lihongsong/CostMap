#import <UIKit/UIKit.h>
@interface UIViewController (UIAlertControllerKit)
-(void)addAlertScene:(NSString *)message block:(void (^)(void))block;
@end
