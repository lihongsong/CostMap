//
//  HJGuidePageWKScriptMessageHandler.h
//  HJNetWorkingDemo
//
//  Created by Jack on 2017/12/19.
//  Copyright © 2017年 姜奎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "NSObject+GuidePageSelectorExtension.h"
#import "HJGuidePageUtility.h"
@interface HJGuidePageWKScriptMessageHandler : NSObject<WKScriptMessageHandler>
/**delegate*/
@property (nonatomic,weak) id delegate;
+(HJGuidePageWKScriptMessageHandler*)handlerWithDelegate:(__weak id)delegate;
- (instancetype)initWith:(__weak id)delegate;
@end
