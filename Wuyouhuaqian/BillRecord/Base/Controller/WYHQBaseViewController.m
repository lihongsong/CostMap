//
//  WYHQBaseViewController.m
//  JiKeLoan
//
//  Created by Rainy on 16/5/25.
//  Copyright © 2016年 JiKeLoan. All rights reserved.
//

#import "WYHQBaseViewController.h"

@interface WYHQBaseViewController ()

@end

@implementation WYHQBaseViewController

#pragma mark - life circle


- (id)init {
    self = [super init];
    if (self) {
        //因为在路由切换页面时，创建新VC替换上层VC，同时界面停留在子VC时，是不会执行上层VC的viewDidLoad方法的。
        //设置返回按钮文字需要在上层VC设置，所以将设置返回按钮文字的方法移到init方法中。
        [self setupBackBarButtonItem];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    //storyboard初始化不会执行init方法
    [self setupBackBarButtonItem];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self adjustsScrollViewInsets];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self setpNavBarWhenViewWillAppear];
}

- (void)setpNavBarWhenViewWillAppear {
    // 设置背景图
    [self cfy_setNavigationBarBackgroundColor:[UIColor whiteColor]];
    [self cfy_setNavigationBarBackgroundImage:nil];
    // 设置ShadowImage
    [self cfy_setNavigationBarShadowImageBackgroundColor:[UIColor clearColor]];
    
    [self.navigationController.navigationBar setTintColor:HJHexColor(0x666666)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - iOS11-ScrollView内边距设置兼容

- (void)adjustsScrollViewInsets {
    adjustsScrollViewInsets_NO([self getFirstScrollViewFromVC], self);
}

- (UIScrollView *)getFirstScrollViewFromVC {
    UIScrollView * scrollView = nil;
    for (UIView * view  in self.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            scrollView = (UIScrollView *)view;
            break;
        }
    }
    return scrollView;
}

#pragma mark - 设置视图控制器的BackBarButtonItem
- (void)setupBackBarButtonItem {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

#pragma mark - 设置视图控制器的leftBarButtonItemWithImage
- (void)setupCustomLeftWithImage:(UIImage *)image target:(id)tar action:(SEL)act {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 20);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:tar action:act forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark - 设置视图控制器的rightBarButtonItemWithImage
- (void)setupCustomRightWithImage:(UIImage *)image target:(id)tar action:(SEL)act {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 0);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:tar action:act forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - 设置视图控制器的rightBarButtonItemWithTitle
- (void)setupCustomRightWithtitle:(NSString *)title attributes:(NSDictionary<NSAttributedStringKey, id> *)attrs target:(id)tar action:(SEL)act {
    UILabel *rightTitle = [[UILabel alloc]init];
    rightTitle.frame = CGRectMake(0, 0, 55, 44);
    NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] initWithString:title attributes:attrs];
    rightTitle.attributedText = mas;
    rightTitle.textAlignment = NSTextAlignmentRight;
    rightTitle.userInteractionEnabled = YES;
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:tar action:act];
    [rightTitle addGestureRecognizer:gest];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightTitle];
    self.navigationItem.rightBarButtonItem = rightItem;
}

@end
