//
//  PageViewController.m
// WuYouQianBao
//
//  Created by jasonzhang on 2018/5/14.
//  Copyright © 2018年 jasonzhang. All rights reserved.
//

#import "WYHQPageViewController.h"
#import "ZYZControl.h"


@interface WYHQPageViewController ()
@property (strong, nonatomic)UIImageView *pageImageView;
@property (strong, nonatomic)UIButton *startButton;
@end

@implementation WYHQPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.pageImageView];
}

-(UIImageView *)pageImageView
{
    if (_pageImageView == nil) {
        _pageImageView = [ZYZControl createImageViewFrame:CGRectMake(0, 0, SWidth, SHeight) imageName:@"introduce_LaunchImage_01"];
    }
    return _pageImageView;
}

-(UIButton *)startButton
{
    if (_startButton == nil) {
        _startButton = [ZYZControl createButtonWithFrame:CGRectMake(SWidth/2.0 - 90,SHeight - 100 - 40, 180, 40) target:self SEL:@selector(startButtonClick) title:@"开启旅程"];
        [_startButton setImage:[UIImage imageNamed:@"introduce_LaunchImage_Button"] forState:UIControlStateNormal];
        [_startButton setImage:[UIImage imageNamed:@"introduce_LaunchImage_Button"] forState:UIControlStateHighlighted];
    }
    return _startButton;
}

-(void)setType:(PageType)type{
    switch (type) {
        case PageOneType:
        {
            if ([UIDevice hj_isIPhoneXSizedDevice]) {
                 self.pageImageView.image = [UIImage imageNamed:@"LaunchImage_01_iphonex"];
            }else{
                 self.pageImageView.image = [UIImage imageNamed:@"introduce_LaunchImage_01"];
            }
            
          
        }
            break;
        case PageTwoType:
        {
            if ([UIDevice hj_isIPhoneXSizedDevice]) {
                 self.pageImageView.image = [UIImage imageNamed:@"LaunchImage_02_iphonex"];
            }else{
                 self.pageImageView.image = [UIImage imageNamed:@"introduce_LaunchImage_02"];
            }
        }
            break;
        case PageThreeType:
        {
            if ([UIDevice hj_isIPhoneXSizedDevice]) {
                 self.pageImageView.image = [UIImage imageNamed:@"LaunchImage_03_iphonex"];
            }else{
                 self.pageImageView.image = [UIImage imageNamed:@"introduce_LaunchImage_03"];
            }
            
            [self.view addSubview:self.startButton];
            if ([UIDevice hj_isIPhone6SizedDevice]) {
                self.startButton.frame = CGRectMake(SWidth/2.0 - 90,SHeight - 100 - 20, 180, 40);
            }else if ([UIDevice hj_isIPhone6PlusSizedDevice]){
                self.startButton.frame = CGRectMake(SWidth/2.0 - 90,SHeight - 40 - 80, 180, 40);
            }else{
                self.startButton.frame = CGRectMake(SWidth/2.0 - 90,SHeight - 40 - 50, 180, 40);
            }
        }
            break;
        default:
            break;
    }
}

- (void)startButtonClick{
    self.rootStartVC();
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
