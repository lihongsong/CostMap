//
//  UIApplication+HJOpenUrl.m
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import "UIApplication+HJOpenUrl.h"

@implementation UIApplication (HJOpenUrl)

+ (void)hj_openURL:(NSURL*)url options:(NSDictionary<NSString *, id> *)options completionHandler:(void (^ __nullable)(BOOL success))completion {
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:options completionHandler:completion];
        } else {
            // Fallback on earlier versions
        }
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
