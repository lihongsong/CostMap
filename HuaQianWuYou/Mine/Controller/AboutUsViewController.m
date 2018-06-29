//
//  AboutUsViewController.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI {
    WeakObj(self);
    self.title = @"关于我们";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont NavigationTitleFont],NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.view.backgroundColor = HJHexColor(0xf2f2f2);
    UIImageView *appLogo = [UIImageView new];
    [self.view addSubview:appLogo];
    [appLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.top.mas_equalTo(self.view.mas_top).mas_offset(124);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    appLogo.image = [UIImage imageNamed:@"corner_logo"];

    UILabel *versionLabel = [UILabel new];
    [self.view addSubview:versionLabel];
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.centerX.mas_equalTo(appLogo.mas_centerX);
        make.top.mas_equalTo(appLogo.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(self.view).mas_offset(15);
        make.right.mas_equalTo(self.view).mas_offset(-15);
    }];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ?: @"";
    versionLabel.text = [NSString stringWithFormat:@"版本号 V%@", version];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.textColor = HJHexColor(0x666666);
    versionLabel.font = [UIFont systemFontOfSize:15];

    UILabel *tipLabel = [UILabel new];
    [self.view addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.top.mas_equalTo(versionLabel.mas_bottom).mas_offset(45);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(25);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-25);
    }];
    tipLabel.numberOfLines = 0;
    tipLabel.textColor = HJHexColor(0x999999);
    NSString *tipString = @"您身边的公积金社保管家~";
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentCenter;
    paraStyle.lineSpacing = 3; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;

    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:12], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:tipString attributes:dic];
    tipLabel.attributedText = attributeStr;

    UILabel *bottomTip1 = [UILabel new];
    [self.view addSubview:bottomTip1];
    UILabel *bottomTip2 = [UILabel new];
    [self.view addSubview:bottomTip2];
    [bottomTip2 mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.height.mas_equalTo(16.5);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-15);
    }];
    bottomTip2.textColor = HJHexColor(0x999999);
    bottomTip2.text = @"邮箱：kefu@huaqianwuyou.com";
    bottomTip2.font = [UIFont systemFontOfSize:12];

    [bottomTip1 mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.height.mas_equalTo(16.5);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(bottomTip2.mas_top).mas_offset(-10);
    }];
    bottomTip1.textColor = HJHexColor(0x999999);
    bottomTip1.text = @"微信公众号：花钱无忧";
    bottomTip1.font = [UIFont systemFontOfSize:12];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
