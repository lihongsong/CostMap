#import "UIFont+TargetFont.h"
#import "CostMapPlistManager.h"
@implementation UIFont (TargetFont)
+ (UIFont *)PercentTitleFont{
    return [UIFont fontNameIndex:0 withFontSizeIndex:0];
}
+ (UIFont *)NewsBigTitleFont{
    return [UIFont fontNameIndex:0 withFontSizeIndex:1];
}
+ (UIFont *)BigTitleFont{
    return [UIFont fontNameIndex:0 withFontSizeIndex:2];
}
+ (UIFont *)NavigationTitleFont{
   return [UIFont fontNameIndex:2 withFontSizeIndex:3];
}
+ (UIFont *)bigButtonTitleFont{
    return [UIFont fontNameIndex:0 withFontSizeIndex:10];
}
+ (UIFont *)navigationRightFont{
    return [UIFont fontNameIndex:0 withFontSizeIndex:4];
}
+ (UIFont *)NormalTitleFont{
    return [UIFont fontNameIndex:1 withFontSizeIndex:5];
}
+ (UIFont *)NormalSmallTitleFont{
    return [UIFont fontNameIndex:1 withFontSizeIndex:6];
}
+ (UIFont *)normalFont{
    return [UIFont fontNameIndex:1 withFontSizeIndex:7];
}
+ (UIFont *)stateLabelFont{
    return [UIFont fontNameIndex:1 withFontSizeIndex:11];
}
+ (UIFont *)stateFont{
    return [UIFont fontNameIndex:1 withFontSizeIndex:8];
}
+ (UIFont *)tabBarFont{
    return [UIFont fontNameIndex:1 withFontSizeIndex:9];
}
+ (UIFont *)fontNameIndex:(NSInteger)index withFontSizeIndex:(NSInteger)sizeIndex{
    if ([UIFont fontWithName:[CostMapPlistManager getFontName:index] size:[CostMapPlistManager getFontSize:sizeIndex]] != nil){
        return [UIFont fontWithName:[CostMapPlistManager getFontName:index] size:[CostMapPlistManager getFontSize:sizeIndex]];
    }else{
        return [UIFont fontWithName:[CostMapPlistManager getFontName:3] size:[CostMapPlistManager getFontSize:sizeIndex]];
    }
}
@end
