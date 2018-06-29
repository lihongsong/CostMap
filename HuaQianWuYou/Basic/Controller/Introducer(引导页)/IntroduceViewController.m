//
//  IntroduceViewController.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/14.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "IntroduceViewController.h"
#import "ScrollDisplayViewController.h"
#import "PageViewController.h"
#import "UtilitiesDefine.h"
@interface IntroduceViewController ()<ScrollDisplayViewControllerDelegate>
@property(nonatomic,strong) ScrollDisplayViewController *scrollVC;
@end

@implementation IntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after
    [self addChildViewController:self.scrollVC];
    self.scrollVC.view.frame = CGRectMake(0,0, SWidth, SHeight);
    [self.view addSubview:self.scrollVC.view];
    self.view.userInteractionEnabled = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(ScrollDisplayViewController*)scrollVC{
    if (!_scrollVC) {
        NSArray*vcs = @[[self createPageVC:PageOneType],
                        [self createPageVC:PageTwoType],
                        [self createPageVC:PageThreeType],
                        ];
        _scrollVC =[[ScrollDisplayViewController alloc] initWithControllers:vcs];
        _scrollVC.delegate = self;
    }
    return _scrollVC;
}

-(PageViewController *)createPageVC:(PageType)type{
    PageViewController *pageVC = [[PageViewController alloc]init];
    return pageVC;
}

//当用户点击了某一页触发
- (void)scrollDisplayViewController:(ScrollDisplayViewController *)scrollDisplayViewController didSelectedIndex:(NSInteger)index{
    
}
//实时回传当前索引值
- (void)scrollDisplayViewController:(ScrollDisplayViewController *)scrollDisplayViewController currentIndex:(NSInteger)index{
    //目前没用到，便于后期扩转
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
