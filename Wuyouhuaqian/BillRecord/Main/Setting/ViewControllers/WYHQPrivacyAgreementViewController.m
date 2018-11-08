//
//  WYHQPrivacyAgreementViewController.m
//  Wuyouhuaqian
//
//  Created by sunhw on 2018/11/8.
//  Copyright © 2018 yoser. All rights reserved.
//

#import "WYHQPrivacyAgreementViewController.h"
#import <WebKit/WebKit.h>
#import <Masonry.h>

@interface WYHQPrivacyAgreementViewController ()

@end

@implementation WYHQPrivacyAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"隐私政策";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PrivateAgreement" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    
    WKWebView *webview = [[WKWebView alloc] init];
    [self.view addSubview:webview];
    
    [webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [webview loadHTMLString:html baseURL:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

@end
