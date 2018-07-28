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
    UIImageView *bgImageView;
}

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpUI {
    
    bgImageView = [UIImageView new];
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    bgImageView.image = [self getLaunchImage];
    
    [self.view addSubview:self.defaultView];
    self.defaultView.hidden = YES;
    [self.defaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    WeakObj(self);
    self.defaultView.reloadBlock = ^{
        StrongObj(self);
        [self.defaultView ln_showLoadingHUDMoney];
          [self requestData];
    };
}

- (void)requestData {
    WeakObj(self);
    [BasicConfigModel requestBasicConfigCompletion:^(BasicConfigModel *_Nullable result, NSError *_Nullable error) {
        StrongObj(self);
        NSLog(@"____%@___",error);
        if (error) {
            
            if (error.code == kCFURLErrorNotConnectedToInternet && !
                self.defaultView.hidden) {
                [self.defaultView ln_hideProgressHUD:LNMBProgressHUDAnimationToast message:@"网络异常~"];
            }else{
              [self.defaultView ln_hideProgressHUD:LNMBProgressHUDAnimationToast message:error.userInfo[@"msg"]];
            }
            self.defaultView.hidden = NO;
            return;
        }else{
            [self.defaultView ln_hideProgressHUD];
        }
        if (result) {
            self.defaultView.hidden = YES;
        }
        result.exampleCreditScore = @"88";
        if (result.exampleCreditScore != GetUserDefault(KExample_Credit_Score)) {
        SetUserDefault(result.exampleCreditScore, KExample_Credit_Score)
        }
        if (self.accomplishBlock) {
            self.accomplishBlock(result.exampleCreditScore);
        }
    }];
}

- (UIImage *)getLaunchImage {
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    
    NSString *viewOrientation = nil;
    if (([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) || ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait)) {
        viewOrientation = @"Portrait";
    } else {
        viewOrientation = @"Landscape";
    }
    NSString *launchImage = @"";
    
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    
    return [UIImage imageNamed:launchImage];
}

@end
