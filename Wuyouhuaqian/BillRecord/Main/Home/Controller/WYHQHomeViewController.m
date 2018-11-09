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

#import "WYHQTranstionAnimationPush.h"
#import "CLCustomDatePickerView.h"

@interface WYHQHomeViewController () <UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *tableHeaderView;

@property (strong, nonatomic) WYHQChartLineView *lineView;

@property (nonatomic, strong) WYHQHomeDateSelectButton *dateSelectBtn;

@property (weak, nonatomic) IBOutlet WYHQLeapButton *addBillBtn;

@property (strong, nonatomic) WYHQChartPieView *pieView;

@property (weak, nonatomic) IBOutlet WYHQBillTableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *chartBaseVw;

@property (weak, nonatomic) IBOutlet UIButton *changeBt;

@property (weak, nonatomic) IBOutlet UIButton *arrowBt;

@property (assign, nonatomic) BOOL isArrowUp;

@property (weak, nonatomic) IBOutlet UIButton *moreBt;

@property (weak, nonatomic) IBOutlet UILabel *moneyLb;

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

#pragma mark - Network Method



#pragma mark - Public Method



#pragma mark - Private Method


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
    
    self.animateRect = _addBillBtn.frame;
    
    self.navigationController.delegate = self;
    
    self.tableHeaderView.backgroundColor = WYHQThemeColor;
    
    self.tableView.tableType = WYHQBillTableTypeHome;
    
    UIBarButtonItem *setItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_set"]
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(setBtnClick)];
    
    UIView *dateView = [UIView new];
    dateView.frame = CGRectMake(0, 0, 100, 40);
    
    _dateSelectBtn = [WYHQHomeDateSelectButton new];
    [_dateSelectBtn setFrame:CGRectMake(0, 0, 100, 40)];
    [_dateSelectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_dateSelectBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_dateSelectBtn setImage:[UIImage imageNamed:@"home_picker_arrow"] forState:UIControlStateNormal];
    [_dateSelectBtn addTarget:self action:@selector(dateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *dateItem = [[UIBarButtonItem alloc] initWithCustomView:_dateSelectBtn];
    
    self.navigationItem.rightBarButtonItem = dateItem;
    self.navigationItem.leftBarButtonItem = setItem;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = self.title;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = UIColor.whiteColor;
    
    self.navigationItem.titleView = titleLabel;
    
    [_chartBaseVw addSubview:self.lineView];
    [_chartBaseVw addSubview:self.pieView];
    
    [_chartBaseVw bringSubviewToFront:_changeBt];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.chartBaseVw);
    }];
    
    [_pieView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.chartBaseVw);
    }];
    
    _lineView.hidden = NO;
    _pieView.hidden = YES;
    
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
                                        [self.addBillBtn startLeapAnimation];
                                        [self.addBillBtn stopShakeAnimation];
                                        return ;
                                    }
                                    
                                    [self.addBillBtn startShakeAnimation];
                                    [self.addBillBtn stopLeapAnimation];
                                
                                    double sum;
                                    NSArray *tempArray = [WYHQBillModel templateBillArrayWithBills:result sumMoney:&sum];
                                    
                                    // 设置图表的数据
                                    self.pieView.models = tempArray;
                                    self.lineView.models = tempArray;
                                    
                                    // 设置列表的数据
                                    self.tableView.models = tempArray;
                                    [self.tableView cyl_reloadData];
                                    
                                    // 设置总额数据
                                    self.moneyLb.text = [NSString stringWithFormat:@"%.2f", sum];
                                }];
}

#pragma mark - Notification Method



#pragma mark - Event & Target Methods

- (void)setBtnClick {
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

- (void)dateBtnClick {
    
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

- (IBAction)changeType:(UIButton *)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        if (self.lineView.hidden == YES) {
            self.lineView.hidden = NO;
            self.pieView.hidden = YES;
        } else {
            self.lineView.hidden = YES;
            self.pieView.hidden = NO;
        }
    } completion:^(BOOL finished) {
        if (self.lineView.hidden == NO) {
            [self.lineView animate];
        } else {
            [self.pieView animate];
        }
    }];
}

#pragma mark -- UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        return [WYHQTranstionAnimationPush new];
    }else{
        return nil;
    }
}

@end
