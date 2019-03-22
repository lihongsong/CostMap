#import "UIAlertView+Block.h"
#import <objc/runtime.h>
static NSString *UIAlertViewKey = @"UIAlertViewKey";
@implementation UIAlertView (Block)
+ (void)alertWithCallBackBlock:(UIAlertViewCallBackBlock)alertSceneCallBackBlock title:(NSString *)title message:(NSString *)message  cancelButtonName:(NSString *)cancelButtonName otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonName otherButtonTitles: otherButtonTitles, nil];
    [alert setValue:@"1" forKey:@"defaultButtonIndex"];
    NSString *other = nil;
    va_list args;
    if (otherButtonTitles) {
        va_start(args, otherButtonTitles);
        while ((other = va_arg(args, NSString*))) {
            [alert addButtonWithTitle:other];
        }
        va_end(args);
    }
    alert.delegate = alert;
    [alert show];
    alert.alertSceneCallBackBlock = alertSceneCallBackBlock;
}
- (void)setAlertSceneCallBackBlock:(UIAlertViewCallBackBlock)alertSceneCallBackBlock {
    [self willChangeValueForKey:@"callbackBlock"];
    objc_setAssociatedObject(self, &UIAlertViewKey, alertSceneCallBackBlock, OBJC_ASSOCIATION_COPY);
    [self didChangeValueForKey:@"callbackBlock"];
}
- (UIAlertViewCallBackBlock)alertSceneCallBackBlock {
    return objc_getAssociatedObject(self, &UIAlertViewKey);
}
- (void)alertScene:(UIAlertView *)alertScene clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.alertSceneCallBackBlock) {
        self.alertSceneCallBackBlock(buttonIndex);
    }
}
@end
