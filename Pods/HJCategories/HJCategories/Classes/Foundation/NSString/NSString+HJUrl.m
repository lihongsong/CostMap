//
//  NSString+HJUrl.m
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import "NSString+HJUrl.h"

@implementation NSString (HJUrl)

- (NSString *)hj_processedUrlWithToken:(NSString *)token {
    
    NSString *newUrl = self;
    NSString *newToken = token;
    
    if (!newUrl || [newUrl length] == 0 || [newUrl rangeOfString:@"token="].location != NSNotFound) {
        return newUrl;
    }
    if ( !token || [token length] == 0) {
        newToken = @"";
    }
    if ([newUrl rangeOfString:@"?"].location != NSNotFound) {
        //包含字符"?"，则拼接token时前面加一个&符号
        newUrl = [NSString stringWithFormat:@"%@&token=%@", newUrl,newToken];
    }else {
        newUrl = [NSString stringWithFormat:@"%@?token=%@", newUrl,newToken];
    }
    
    return newUrl;
}

- (NSString *)hj_sceneSuffix {
    return [NSString stringWithFormat:@"scene=%@",self];
}

- (NSString *)hj_versionSuffix {
    return [NSString stringWithFormat:@"version=%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]?:@""];
}

- (NSString *)hj_processedUrlWithScene:(NSString *)scene {
    NSURL * url = [NSURL URLWithString:self];
    if (scene && url) {
        return [NSURL URLWithString:[self stringByAppendingFormat:[NSURL URLWithString:self].query ? @"&%@&%@" : @"?%@&%@",[self hj_versionSuffix], scene]].absoluteString;
    }
    return self;
}

@end
