//
//  WYHQHomeViewController.m
//  HJHQWY
//
//  Created by yoser on 2018/11/7.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import "WYHQHomeViewController.h"
#import "WYHQBillTableViewCell.h"
#import "WYHQBillModel.h"
#import "WYHQBillTableView.h"
#import "WYHQChartLineView.h"
#import "WYHQChartPieView.h"
#import "WYHQLeapButton.h"
#import "WYHQSettingView.h"
#import "UNNoDataView.h"
#import "WYHQHomeDateSelectButton.h"
#import "WYHQBillModel+WYHQService.h"
#import "UIViewController+Push.h"
#import "WYHQEditBillViewController.h"
#import "WYHQTranstionAnimationPush.h"
#import "CLCustomDatePickerView.h"
#import "WYHQCountingLabel.h"

@interface WYHQHomeViewController () <UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *tableHeaderView;

@property (strong, nonatomic) WYHQChartLineView *lineView;

@property (weak, nonatomic) IBOutlet WYHQHomeDateSelectButton *dateSelectBtn;

@property (weak, nonatomic) IBOutlet WYHQLeapButton *addBillBtn;

@property (strong, nonatomic) WYHQChartPieView *pieView;

@property (weak, nonatomic) IBOutlet WYHQBillTableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *chartBaseVw;

@property (weak, nonatomic) IBOutlet UIButton *changeBt;

@property (weak, nonatomic) IBOutlet UIButton *arrowBt;

@property (assign, nonatomic) BOOL isArrowUp;

@property (weak, nonatomic) IBOutlet UIButton *moreBt;

@property (weak, nonatomic) IBOutlet WYHQCountingLabel *moneyLb;

@property (weak, nonatomic) IBOutlet UIView *headerBackView;

@property (assign, nonatomic) CGFloat totalMoney;

@property (weak, nonatomic) IBOutlet UIView *navbar;

/**
 头部视图
 */
@property (weak, nonatomic) IBOutlet UIView *headerView;

/**
 年份
 */
@property (assign, nonatomic) NSUInteger year;

/**
 月份
 */
@property (assign, nonatomic) NSUInteger month;

@end

@implementation WYHQHomeViewController

+ (instancetype)instance {
    return StoryBoardLoaderRoot(@"BillHome");
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"花钱无忧";
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    [self setUpUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self requestData];
    [[self navigationController] setDelegate:self];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

    // 钱动画
    if (_totalMoney > 0) {
        [self doMoneyAnimation];
    }
}

- (void)setpNavBarWhenViewWillAppear {
    
    // 设置背景颜色
    [self cfy_setNavigationBarBackgroundColor:WYHQThemeColor];
    [self cfy_setNavigationBarBackgroundImage:nil];
    // 设置ShadowImage
    [self cfy_setNavigationBarShadowImageBackgroundColor:[UIColor clearColor]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

#pragma mark - Getter & Setter Methods

- (WYHQChartPieView *)pieView {
    if (!_pieView) {
        _pieView = [WYHQChartPieView new];
        _pieView.drawHoleEnabled = NO;
    }
    return _pieView;
}

- (WYHQChartLineView *)lineView {
    if (!_lineView) {
        _lineView = [WYHQChartLineView new];
    }
    return _lineView;
}

#pragma mark - Super Method

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.animateRect = self.addBillBtn.frame;
}

#pragma mark - Network Method



#pragma mark - Public Method



#pragma mark - Private Method

- (void)doMoneyAnimation {
    
    CGFloat money = fabs(_totalMoney);
    
    //设置变化范围及动画时间
    [_moneyLb countFrom:0.00
                     to:money
           withDuration:1.0f];
}

- (NSString *)dateString {
    return [NSString stringWithFormat:@"%04ld-%02ld",(long)_year, (long)_month];
}

- (void)arrowAnimate {
    
    // 对X轴进行旋转（指定X轴的话，就和UIView的动画一样绕中心旋转）
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    
    // 设定动画选项
    animation.duration = 0.5; // 持续时间
    animation.repeatCount = 1; // 重复次数
    
    // 设定旋转角度
    if (_isArrowUp) {
        animation.fromValue = [NSNumber numberWithFloat:M_PI]; // 起始角度
        animation.toValue = [NSNumber numberWithFloat:0.0]; // 终止角度
    } else {
        animation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
        animation.toValue = [NSNumber numberWithFloat:M_PI]; // 终止角度
    }
    _isArrowUp = !_isArrowUp;
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    // 添加动画
    [_dateSelectBtn.imageView.layer addAnimation:animation forKey:@"rotate-layer"];
}

- (void)setUpUI {
    
    _lineView.alpha = 1.0f;
    _pieView.alpha = 0.0f;
    
    _moneyLb.textAlignment = NSTextAlignmentCenter;
    _moneyLb.font = [UIFont fontWithName:@"Avenir Next" size:27];
    _moneyLb.textColor = [UIColor whiteColor];
    _moneyLb.formatBlock = ^NSString *(CGFloat value) {
        return [@(value).stringValue moneyStyle];
    };
    
    //设置格式
    _moneyLb.format = @"%.2f";
    
    self.navbar.backgroundColor = WYHQThemeColor;
    self.view.backgroundColor = WYHQThemeColor;
    self.headerBackView.backgroundColor = WYHQThemeColor;
    [self.changeBt setTitleColor:WYHQThemeColor forState:UIControlStateNormal];
    [self.changeBt setTitleColor:WYHQThemeColor forState:UIControlStateHighlighted];
    
    self.animateRect = _addBillBtn.frame;
    
    self.navigationController.delegate = self;
    
    self.tableHeaderView.backgroundColor = WYHQThemeColor;
    
    self.tableView.tableType = WYHQBillTableTypeHome;
    
    [_chartBaseVw addSubview:self.lineView];
    [_chartBaseVw addSubview:self.pieView];
    
    [_chartBaseVw bringSubviewToFront:_changeBt];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.chartBaseVw);
    }];
    
    [_pieView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.chartBaseVw);
    }];
    
    _lineView.alpha = 1.0f;
    _pieView.alpha = 0.0f;
    
    NSDate *today = [NSDate hj_getToday];
    _year = [today hj_year];
    _month = [today hj_month];
    
    [_dateSelectBtn setTitle:[self dateString] forState:UIControlStateNormal];
}

- (void)requestData {
    
    [_dateSelectBtn setTitle:[self dateString] forState:UIControlStateNormal];
    
    [[WYHQSQLManager share] searchData:kSQLTableName
                                  year:@(self.year).stringValue
                                 month:@(self.month).stringValue
                                   day:nil
                                result:^(NSMutableArray<WYHQBillModel *> *result, NSError *error) {
                                    
                                    NSArray *allBillArray = result;
                                    // 无数据
                                    if (allBillArray.count == 0) {
                                        self.tableView.models = @[];
                                        [self.tableView cyl_reloadData];
//                                        [self.addBillBtn startLeapAnimation];
//                                        [self.addBillBtn stopShakeAnimation];
                                        return ;
                                    }
//                                    [self.addBillBtn startShakeAnimation];
//                                    [self.addBillBtn stopLeapAnimation];
                                
                                    double sum;
                                    NSArray *tempArray = [WYHQBillModel templateBillArrayWithBills:result sumMoney:&sum];
                                    
                                    // 设置图表的数据
                                    self.pieView.models = tempArray;
                                    self.lineView.models = tempArray;
                                    
                                    // 设置列表的数据
                                    self.tableView.models = tempArray;
                                    [self.tableView cyl_reloadData];
                                    
                                    // 设置总额数据
                                    self.totalMoney = sum;
                                    [self doMoneyAnimation];
                                }];
}

#pragma mark - Notification Method



#pragma mark - Event & Target Methods

- (IBAction)setBtnClick {
    // 跳转设置
        WEAK_SELF
        [WYHQSettingView showSettingViewOnSuperViewController:self.navigationController
                                                gotoVCHandler:^(UIViewController * _Nonnull viewController) {
                                                    STRONG_SELF
                                                    [self.navigationController pushViewController:viewController animated:YES];
                                                }];
}

- (IBAction)addBillClick:(WYHQLeapButton *)sender {
    [[HJMediator shared] routeToURL:HJAPPURL(@"EditBill") withParameters:nil, nil];
}

- (IBAction)moreBtnClick:(UIButton *)sender {
    [[HJMediator shared] routeToURL:HJAPPURL(@"BillList") withParameters:nil, nil];
}

- (IBAction)dateBtnClick {
    
    [self arrowAnimate];
    
    WEAK_SELF
    [CLCustomDatePickerView showDatePickerWithTitle:@"选择时间"
                                           dateType:CLCustomDatePickerModeYM
                                    defaultSelValue:[self dateString]
                                            minDate:nil
                                            maxDate:nil
                                       isAutoSelect:NO
                                         themeColor:nil
                                        resultBlock:^(NSString *selectValue) {
                                            STRONG_SELF
                                            self.year = [[[selectValue componentsSeparatedByString:@"-"] firstObject] integerValue];
                                            self.month = [[[selectValue componentsSeparatedByString:@"-"] lastObject] integerValue];
                                            [self arrowAnimate];
                                            [self requestData];
                                        }
                                        cancelBlock:^{
                                            [self arrowAnimate];
                                        }];
}

// ******** 修改点 ********
- (IBAction)changeType:(UIButton *)sender {
    
    UIView *fakeButton = [sender snapshotViewAfterScreenUpdates:NO];
    fakeButton.frame = sender.frame;
    [sender.superview addSubview:fakeButton];
    
    sender.hidden = YES;
    
    sender.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         CGPoint center = fakeButton.center;
                         fakeButton.bounds = CGRectMake(center.x, center.y, 0, 0);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5
                                               delay:0
                              usingSpringWithDamping:0.2
                               initialSpringVelocity:5.0
                                             options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                                 fakeButton.frame = sender.frame;
                                             }
                                          completion:^(BOOL finished) {
                                              [fakeButton removeFromSuperview];
                                              sender.hidden = NO;
                                              sender.userInteractionEnabled = YES;
                                          }];
                         
                     }];
    
    [UIView animateWithDuration:0.7 animations:^{
        if (self.lineView.alpha == 0.0f) {
            self.lineView.alpha = 1.0f;
            self.pieView.alpha = 0.0f;
        } else {
            self.lineView.alpha = 0.0f;
            self.pieView.alpha = 1.0f;
        }
        
        if (self.lineView.alpha == 1.0f) {
            [self.lineView animate];
        } else {
            [self.pieView animate];
        }
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark -- UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    
    if ([fromVC isKindOfClass:[WYHQHomeViewController class]] &&
        [toVC isKindOfClass:[WYHQEditBillViewController class]] &&
        operation == UINavigationControllerOperationPush) {
        return [WYHQTranstionAnimationPush new];
    } else {
        return nil;
    }
}

@end
