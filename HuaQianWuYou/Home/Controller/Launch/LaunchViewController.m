//
//  LaunchViewController.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/6/5.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "LaunchViewController.h"
#import "BasicConfigModel+Service.h"
#import "BasicConfigModel.h"
#import "BasicDataModel.h"
#import "BasicDataModel+Service.h"

@interface LaunchViewController () {
    UIActivityIndicatorView *activityView;
}

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestData];
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpUI {
    UIImageView *bgImageView = [UIImageView new];
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    bgImageView.image = [self getLaunchImage];
    [self.view addSubview:self.defaultView];
    [self.defaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    activityView = [UIActivityIndicatorView new];
    [self.view addSubview:activityView];
    [activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
    activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    WeakObj(self);
    self.defaultView.reloadBlock = ^{
        StrongObj(self);
        if (!self->activityView.isAnimating) {
          [self requestData];
        }
    };
    self.defaultView.hidden = YES;
}

- (void)requestData {
    WeakObj(self);
    [activityView startAnimating];
    [BasicConfigModel requestBasicConfigCompletion:^(BasicConfigModel *_Nullable result, NSError *_Nullable error) {
        StrongObj(self);
        [self->activityView stopAnimating];
        if (error) {
            [KeyWindow ln_showToastHUD:error.userInfo[@"msg"]];
            self.defaultView.hidden = NO;
            return;
        }
        if (result) {
            self.defaultView.hidden = YES;
            if (![result.exampleCreditScore isEqualToString:@"88"]) {
                [BasicDataModel requestBasicData:AdvertisingTypeStartPage Completion:^(BasicDataModel * _Nullable dataModel, NSError * _Nullable error) {
                }];
            }
        }
        if (self.accomplishBlock) {
            self.accomplishBlock(result.exampleCreditScore);
        }
    }];
}

- (UIImage *)getLaunchImage {
    NSString *launchImageName = @""; //启动图片名称变量
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    //获取与当前设备匹配的启动图片名称
    if (screenHeight == 480) { //4，4S
        launchImageName = @"LaunchImage-700";
    } else if (screenHeight == 568) { //5, 5C, 5S, iPod
        launchImageName = @"LaunchImage-700-568h";
    } else if (screenHeight == 667) { //6, 6S
        launchImageName = @"LaunchImage-800-667h";
    } else if (screenHeight == 736) { // 6Plus, 6SPlus
        launchImageName = @"LaunchImage-800-Landscape-736h";
    } else if (screenHeight == 812) { // X
        launchImageName = @"LaunchImage-1100-Portrait-2436h";
    }
    if (launchImageName.length < 1) return 0;
    //设备启动图片为控制器的背景图片
    UIImage *img = [UIImage imageNamed:launchImageName];
    self.view.backgroundColor = [UIColor colorWithPatternImage:img];
    return img;
}

@end
