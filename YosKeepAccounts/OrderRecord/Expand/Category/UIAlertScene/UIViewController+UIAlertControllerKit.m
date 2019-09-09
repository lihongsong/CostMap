#import "UIViewController+UIAlertControllerKit.h"
@implementation UIViewController (UIAlertControllerKit)
-(void)addAlertScene:(NSString *)message block:(void (^)(void))block{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tips" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(block){
            block();
        }
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
