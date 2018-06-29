//
//  ActiveViewController.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/6/29.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "ActiveViewController.h"
#import <WebKit/WebKit.h>

@interface ActiveViewController ()<WKNavigationDelegate,WKUIDelegate>
@property(nonatomic,strong)WKWebView *activeWebView;
@end

@implementation ActiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.activeWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    //[self.activeWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://developer.apple.com/reference/webkit"]]];
    [self.activeWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://172.17.106.138:8081/#/home"]]];
   

    [self.view addSubview:self.activeWebView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setLelftNavigationItem:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
