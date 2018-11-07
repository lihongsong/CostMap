//
//  WYHQHomeViewController.m
//  HJHQWY
//
//  Created by yoser on 2018/11/7.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import "WYHQHomeViewController.h"
#import "GradientCompareBarView.h"

@interface WYHQHomeViewController ()

@property (strong, nonatomic) GradientCompareBarView *chartView;

@end

@implementation WYHQHomeViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];

    _chartView = [[GradientCompareBarView alloc] init];
    _chartView.frame = self.view.bounds;
    [self.view addSubview:_chartView];
    
    _chartView.lendArr = @[@3,@2,@5,@3,@9,@5];
    _chartView.repayArr = @[@1,@4,@7,@6,@8,@4];
    [_chartView refreshData];

}

#pragma mark - Getter & Setter Methods



#pragma mark - Network Method



#pragma mark - Public Method



#pragma mark - Private Method



#pragma mark - Notification Method



#pragma mark - Event & Target Methods

- (void)skipDayBillListViewController {
    [[HJMediator shared] routeToURL:HJAPPURL(@"BillList") withParameters:nil, nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self skipDayBillListViewController];
}

@end
