//
//  PageViewController.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/14.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *pageImageView;

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)setType:(PageType)type{
    switch (type) {
        case PageOneType:
        {
            NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"" ofType:@"png"];
            self.pageImageView.image = [UIImage imageWithContentsOfFile:imagePath];
        }
            break;
        case PageTwoType:
        {
            NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"" ofType:@"png"];
            self.pageImageView.image = [UIImage imageWithContentsOfFile:imagePath];
        }
            break;
        case PageThreeType:
        {
            NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"" ofType:@"png"];
            self.pageImageView.image = [UIImage imageWithContentsOfFile:imagePath];
        }
            break;
        default:
            break;
    }
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
