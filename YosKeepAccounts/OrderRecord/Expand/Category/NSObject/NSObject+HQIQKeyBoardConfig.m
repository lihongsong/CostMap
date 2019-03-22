#import "NSObject+HQIQKeyBoardConfig.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
@implementation NSObject (HQIQKeyBoardConfig)
+ (void)load {
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}
@end
