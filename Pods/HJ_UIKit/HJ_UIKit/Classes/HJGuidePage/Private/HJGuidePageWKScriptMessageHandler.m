//
//  HJGuidePageWKScriptMessageHandler.m
//  HJNetWorkingDemo
//
//  Created by Jack on 2017/12/19.
//  Copyright © 2017年 姜奎. All rights reserved.
//

#import "HJGuidePageWKScriptMessageHandler.h"
static HJGuidePageWKScriptMessageHandler* scriptMessageHandler = nil;
@implementation HJGuidePageWKScriptMessageHandler
+(HJGuidePageWKScriptMessageHandler*)handlerWithDelegate:(__weak id)delegate{
    if (!scriptMessageHandler) {
        scriptMessageHandler = [HJGuidePageWKScriptMessageHandler new];
    }
    scriptMessageHandler.delegate = delegate;
    return scriptMessageHandler;
}
- (instancetype)initWith:(__weak id)delegate{
    if (self = [super init]) {
        self.delegate = delegate;
    }
    return self;
}
- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    
    HJGuidePageDlog(@"(%@)",message.body);
    
    if ([message.body isKindOfClass:[NSDictionary class]]) {
        NSDictionary* dict = (NSDictionary*)message.body;
        SEL sel = NSSelectorFromString(dict[@"funcName"]);
        
        if (self.delegate&&[self.delegate canRunToSelector:sel]) {
            HJGuidePageDlog(@"(%@)",dict[@"body"]);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.delegate runSelector:sel withObjects:dict[@"body"]];
            });
        }
    }
}


@end
