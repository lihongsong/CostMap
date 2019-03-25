#import "UIFont+TargetFont.h"
#import "YosKeepAccountsPlistManager.h"
@implementation UIFont (TargetFont)
#pragma mark 百分比 55
+ (UIFont *)PercentTitleFont{
    return [UIFont fontNameIndex:0 withFontSizeIndex:0];
}
#pragma mark 发现详情大标题 25
+ (UIFont *)NewsBigTitleFont{
    return [UIFont fontNameIndex:0 withFontSizeIndex:1];
}
#pragma mark 大标题字体 20
+ (UIFont *)BigTitleFont{
    return [UIFont fontNameIndex:0 withFontSizeIndex:2];
}
#pragma mark 航栏Title文字字号 19
+ (UIFont *)NavigationTitleFont{
   return [UIFont fontNameIndex:2 withFontSizeIndex:3];
}
#pragma mark 按钮title标题 18
+ (UIFont *)bigButtonTitleFont{
    return [UIFont fontNameIndex:0 withFontSizeIndex:10];
}
#pragma mark 导航栏右边字体 17
+ (UIFont *)navigationRightFont{
    return [UIFont fontNameIndex:0 withFontSizeIndex:4];
}
#pragma mark 普通标题 16
+ (UIFont *)NormalTitleFont{
    return [UIFont fontNameIndex:1 withFontSizeIndex:5];
}
#pragma mark 小标题 15
+ (UIFont *)NormalSmallTitleFont{
    return [UIFont fontNameIndex:1 withFontSizeIndex:6];
}
#pragma mark 正文字号 14
+ (UIFont *)normalFont{
    return [UIFont fontNameIndex:1 withFontSizeIndex:7];
}
#pragma mark 标签文字 13
+ (UIFont *)stateLabelFont{
    return [UIFont fontNameIndex:1 withFontSizeIndex:11];
}
#pragma mark 说明性文字 12
+ (UIFont *)stateFont{
    return [UIFont fontNameIndex:1 withFontSizeIndex:8];
}
#pragma mark 标签栏文字 11
+ (UIFont *)tabBarFont{
    return [UIFont fontNameIndex:1 withFontSizeIndex:9];
}
+ (UIFont *)fontNameIndex:(NSInteger)index withFontSizeIndex:(NSInteger)sizeIndex{
    if ([UIFont fontWithName:[YosKeepAccountsPlistManager getFontName:index] size:[YosKeepAccountsPlistManager getFontSize:sizeIndex]] != nil){
        return [UIFont fontWithName:[YosKeepAccountsPlistManager getFontName:index] size:[YosKeepAccountsPlistManager getFontSize:sizeIndex]];
    }else{
        return [UIFont fontWithName:[YosKeepAccountsPlistManager getFontName:3] size:[YosKeepAccountsPlistManager getFontSize:sizeIndex]];
    }
}
@end
