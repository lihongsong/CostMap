//
//  FeedbackViewController.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "FeedbackViewController.h"
#import "UITextView+HJPlaceHolder.h"
#import "FeedbackModel.h"
#import "FeedbackModel+Service.h"
#import "LoginInfoModel.h"
#import <YYText/YYText.h>

@interface FeedbackViewController ()
@property(nonatomic, strong) YYTextView *feedbackTextView;
@property(nonatomic,strong)UITapGestureRecognizer *tap;
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI {
    WeakObj(self);
    self.title = @"意见反馈";
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.navigationController.navigationBar addGestureRecognizer:self.tap]; self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont NavigationTitleFont],NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.view.backgroundColor = HJHexColor(0xf2f2f2);
    UILabel *tipLabel = [UILabel new];
    [self.view addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.left.top.mas_equalTo(self.view).mas_equalTo(15);
        make.height.mas_equalTo(17);
        make.width.mas_equalTo(120);
    }];
    tipLabel.text = @"问题和意见";
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.textColor = HJHexColor(0x666666);
    
    self.feedbackTextView = [YYTextView new];
    [self.view addSubview:self.feedbackTextView];
    [self.feedbackTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.top.mas_equalTo(tipLabel.mas_bottom).mas_offset(15);
        make.width.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(153);
    }];
    self.feedbackTextView.placeholderText = @"请简要描述您要反馈的问题和意见";
    self.feedbackTextView.placeholderTextColor = HJHexColor(0x999999);
    self.feedbackTextView.contentInset = UIEdgeInsetsMake(5, 10, 5, 10);
    self.feedbackTextView.backgroundColor = HJHexColor(0xffffff);
    self.feedbackTextView.scrollEnabled = NO;
    
    UIButton *commitBtn = [UIButton new];
    [self.view addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.top.mas_equalTo(self.feedbackTextView.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-15);
        make.height.mas_equalTo(44);
    }];
    [commitBtn setTitle:@"提交反馈" forState:UIControlStateNormal];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id) [UIColor colorWithRed:255 / 255.0 green:96 / 255.0 blue:26 / 255.0 alpha:1].CGColor, (__bridge id) [UIColor colorWithRed:255 / 255.0 green:143 / 255.0 blue:0 alpha:1].CGColor];
    gradientLayer.locations = @[@0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.frame = CGRectMake(0, 0, SWidth - 30, 40);
    gradientLayer.cornerRadius = 4;
    [commitBtn.layer addSublayer:gradientLayer];
    [commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)commitBtnAction {
    WeakObj(self);
    [self.feedbackTextView resignFirstResponder];
    if (StrIsEmpty(self.feedbackTextView.text)) {
        [KeyWindow ln_showToastHUD:@"反馈内容不能为空"];
        return;
    }
     LoginUserInfoModel *userInfo = [LoginUserInfoModel cachedLoginModel];
    [KeyWindow ln_showLoadingHUD];
    [FeedbackModel requestFeedbackWithAccount:userInfo?userInfo.mobile:@"15618775597"
                                   adviceString:self.feedbackTextView.text
                                     Completion:^(FeedbackModel * _Nullable result, NSError * _Nullable error) {
                                         StrongObj(self);
                                         [KeyWindow ln_hideProgressHUD];
                                         if (error) {
                                             [KeyWindow ln_showToastHUD:error.localizedDescription];
                                             return ;
                                         }
                                         [self.navigationController popViewControllerAnimated:YES];
                                     }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:true];
}

- (void)tapClick{
    [self.view endEditing:true];
}

@end
