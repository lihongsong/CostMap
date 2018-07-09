//
//  HQWYJavaScriptOpenNativeHandler.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/2.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYJavaScriptBaseHandler.h"

@protocol HQWYJavaScriptOpenNativeHandlerDelegate<NSObject>
- (void)presentNative;
@end

@interface HQWYJavaScriptOpenNativeHandler : HQWYJavaScriptBaseHandler
@property(nonatomic,strong)id<HQWYJavaScriptOpenNativeHandlerDelegate>delegate;
@end
