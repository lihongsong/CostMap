#import "ASConfiguration.h"
#import <HJCategories/HJUIKit.h>
@implementation ASUrl
@end
@implementation ASTheme
- (instancetype)init {
    if (self = [super init]) {
        self.navTitleTextFont = [UIFont boldSystemFontOfSize:17];
        self.navTitleTextColor = HJHexColor(0x333333);
        self.backIndicatorImage = [UIImage new];
        self.navBarTintColor = HJHexColor(0xffffff);
        self.navTintColor = HJHexColor(0x333333);
        self.tabBarShadowColor = HJHexColor(0x999999);
        self.mainColor = HJHexColor(0x3097fd);
        self.foregroundColor = HJHexColor(0xffffff);
        self.backgroundColor = HJHexColor(0xf2f2f2);
        self.placeHolderColor = HJHexColor(0xaaaaaa);
        self.titleColor = HJHexColor(0x333333);
        self.subTitleColor = HJHexColor(0x666666);
        self.promptColor = HJHexColor(0x999999);
        self.weakPromptColor = HJHexColor(0x999999);
        self.separatorColor = HJHexColor(0xfafafa);
        self.sectionSpaceColor = HJHexColor(0xfafafa);
        self.disableColor = HJHexColor(0xbbbbbb);
        self.statemetnFont = [UIFont systemFontOfSize:12];
        self.subTitleFont = [UIFont systemFontOfSize:13];
    }
    return self;
}
@end
@implementation ASConfiguration
static ASConfiguration *configuration;
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configuration = [[ASConfiguration alloc] init];
        configuration.commando = NO;
        configuration.theme = [ASTheme new];
        configuration.urls = [ASUrl new];
    });
    return configuration;
}
@end
