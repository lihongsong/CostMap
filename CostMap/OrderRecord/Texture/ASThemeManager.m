//
//  ASCustomView.m
//  CostMap
//

#import "ASThemeManager.h"
#import "CospMapThemeController.h"

#import <HJCategories/HJUIKit.h>

@interface ASThemeManager()

@end

static NSString *theme_url = @"https://costmap.github.io/web/skin.html";
static NSString *kThemeConfig = @"kThemeConfig";

static NSString *kThemeColorCache = @"kThemeColorCache";

@implementation ASThemeManager

+ (void)changeThemeColor:(NSString *)colorStr {
    
    [[NSUserDefaults standardUserDefaults] setValue:@(YES) forKey:kThemeConfig];
    [[NSUserDefaults standardUserDefaults] setValue:colorStr forKey:kThemeColorCache];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationChangeThemeColor object:nil];
}

+ (UIColor *)themeColor {
    NSString *colorHex = [[NSUserDefaults standardUserDefaults] valueForKey:kThemeColorCache];
    
    if (StrIsEmpty(colorHex)) {
        colorHex = @"FF6A45";
    }
    
    return HJHexStringColor([@"#" stringByAppendingString:colorHex]);
}

+ (void)skipChooseThemeIfNeedFromVC:(UIViewController *)controller {
    
    if (![controller isKindOfClass:[UINavigationController class]]) {
        controller = controller.navigationController;
    }
    
    CospMapThemeController *vc = [CospMapThemeController new];
    [vc loadURLString:theme_url];
    [(UINavigationController *)controller pushViewController:vc animated:YES];
}

+ (BOOL)isConfigTheme {
    BOOL hasSetTheme = [[[NSUserDefaults standardUserDefaults] valueForKey:kThemeConfig] boolValue];
    return hasSetTheme;
}

@end
