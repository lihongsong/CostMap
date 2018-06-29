//
//  NSBundle+HJLoad.m
//  HJCategories
//
//  Created by yoser on 2018/1/4.
//

#import "NSBundle+HJLoad.h"

@implementation NSBundle (HJLoad)

+ (nullable UIView *)hj_loadNibView:(NSString *)className{
    return [[[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil] firstObject];
}

+ (UIView *)hj_loadNibView:(NSString *)className bundle:(NSBundle *)bundle{
    return [[bundle loadNibNamed:className owner:nil options:nil] firstObject];
}

+ (NSBundle *)hj_loadFramework:(NSString *)frameworkName{
    
    NSURL *nativoBundleURL = [[NSBundle mainBundle] URLForResource:frameworkName
                                                     withExtension:@"framework"
                                                      subdirectory:@"Frameworks"];
    
    NSBundle *frameworkBundle = [NSBundle bundleWithURL:nativoBundleURL];
    return frameworkBundle;
}


+ (NSBundle *)hj_loadSubBundle:(NSString *)subBundleName{
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *subBundlePath = [bundle pathForResource:subBundleName ofType:@"bundle"];
    NSBundle *subBundle = [NSBundle bundleWithPath:subBundlePath];
    return subBundle;
}

@end
