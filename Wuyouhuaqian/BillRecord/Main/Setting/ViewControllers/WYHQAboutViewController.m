//
//  WYHQAboutViewController.m
//  Wuyouhuaqian
//
//  Created by sunhw on 2018/11/8.
//  Copyright © 2018 yoser. All rights reserved.
//

#import "WYHQAboutViewController.h"

@interface WYHQAboutViewController ()
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@end

@implementation WYHQAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    self.versionLabel.text = [NSString stringWithFormat:@"版本: %@", app_Version];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

@end
