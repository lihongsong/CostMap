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

#import "CLCustomDatePickerView.h"

@interface WYHQHomeViewController ()

@property (strong, nonatomic) WYHQChartLineView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *dateLb;

@property (strong, nonatomic) WYHQChartPieView *pieView;

@property (weak, nonatomic) IBOutlet WYHQBillTableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *chartBaseVw;

@property (weak, nonatomic) IBOutlet UIButton *changeBt;

@property (weak, nonatomic) IBOutlet UIButton *arrowBt;

@property (weak, nonatomic) IBOutlet UIImageView *arrowIV;

@property (assign, nonatomic) BOOL isArrowUp;

@property (weak, nonatomic) IBOutlet UIButton *moreBt;

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
    
    self.navigationItem.title = @"花钱无忧";
    
    [self setUpUI];
    
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)setpNavBarWhenViewWillAppear {
    
    // 设置背景颜色
    [self cfy_setNavigationBarBackgroundImage:[UIImage hj_imageWithColor:[UIColor blueColor]]];
    
    // 设置ShadowImage
    [self cfy_setNavigationBarShadowImageBackgroundColor:[UIColor clearColor]];
}

#pragma mark - Getter & Setter Methods

- (WYHQChartPieView *)pieView {
    if (!_pieView) {
        _pieView = [WYHQChartPieView new];
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
    [_arrowIV.layer addAnimation:animation forKey:@"rotate-layer"];
}

- (void)setUpUI {
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                      NSFontAttributeName: [UIFont systemFontOfSize:18]}];
    
    UIBarButtonItem *setItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_set"]
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(setBtnClick)];
    
    self.navigationItem.leftBarButtonItem = setItem;
    
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
    
    self.dateLb.text = [self dateString];
}

- (void)requestData {
    
    self.dateLb.text = [self dateString];
    
    WYHQBillModel *model = [WYHQBillModel new];
    model.s_type_id = @(WYHQBillTypeFood).stringValue;
    model.s_money = @"-9000";
    model.s_type_name = @"衣服";
    
    WYHQBillModel *model1 = [WYHQBillModel new];
    model1.s_type_id = @(WYHQBillTypeCloth).stringValue;
    model1.s_money = @"-300";
    model1.s_type_name = @"衣服";
    
    WYHQBillModel *model2 = [WYHQBillModel new];
    model2.s_type_id = @(WYHQBillTypeVehicles).stringValue;
    model2.s_money = @"-700";
    model2.s_type_name = @"衣服";
    
    WYHQBillModel *model3 = [WYHQBillModel new];
    model3.s_type_id = @(WYHQBillTypeHome).stringValue;
    model3.s_money = @"-20";
    model3.s_type_name = @"衣服";
    
    WYHQBillModel *model4 = [WYHQBillModel new];
    model4.s_type_id = @(WYHQBillTypeFood).stringValue;
    model4.s_money = @"-11100";
    model4.s_type_name = @"衣服";
    
    WYHQBillModel *model5 = [WYHQBillModel new];
    model5.s_type_id = @(WYHQBillTypeFood).stringValue;
    model5.s_money = @"-11100";
    model5.s_type_name = @"衣服";
    
    WYHQBillModel *model6 = [WYHQBillModel new];
    model6.s_type_id = @(WYHQBillTypeFood).stringValue;
    model6.s_money = @"-11100";
    model6.s_type_name = @"衣服";
    
    WYHQBillModel *model7 = [WYHQBillModel new];
    model7.s_type_id = @(WYHQBillTypeFood).stringValue;
    model7.s_money = @"-11100";
    model7.s_type_name = @"衣服";
    
    _tableView.models = @[model, model1, model2, model3, model4, model5, model6, model7];
    [_tableView reloadData];
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
    // 跳转新建
    [[HJMediator shared] routeToURL:HJAPPURL(@"EditBill") withParameters:nil, nil];
}

- (IBAction)moreBtnClick:(UIButton *)sender {
    [[HJMediator shared] routeToURL:HJAPPURL(@"BillList") withParameters:nil, nil];
}

- (IBAction)datePickerClick:(UIButton *)sender {
    
    [self arrowAnimate];
    
    WEAK_SELF
    [CLCustomDatePickerView showDatePickerWithTitle:@"选择时间"
                                           dateType:CLCustomDatePickerModeYM
                                    defaultSelValue:[self dateString]
                                        resultBlock:^(NSString *selectValue) {
                                            STRONG_SELF
                                            self.year = [[[selectValue componentsSeparatedByString:@"-"] firstObject] integerValue];
                                            self.month = [[[selectValue componentsSeparatedByString:@"-"] lastObject] integerValue];
                                            [self arrowAnimate];
                                            [self requestData];
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


@end
