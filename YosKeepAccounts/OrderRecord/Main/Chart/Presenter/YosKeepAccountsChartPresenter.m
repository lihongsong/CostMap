//
//  YosKeepAccountsChartPresenter.m
//  YosKeepAccounts
//
//  Created by yoser on 2019/3/25.
//  Copyright © 2019 yoser. All rights reserved.
//

#import "YosKeepAccountsChartPresenter.h"
#import "YosKeepAccountsChartBrokenLineScene.h"
#import "YosKeepAccountsChartLineSceneModel.h"
#import "YosKeepAccountsChartLineScene.h"
#import "YosKeepAccountsChartPieScene.h"
#import "YosKeepAccountsOrderList.h"
#import "YosKeepAccountsOrderEntity+YosKeepAccountsService.h"

#import <HJMediator/HJMediator.h>
#import "YosKeepAccountsUserManager.h"
#import <HMSegmentedControl/HMSegmentedControl.h>

#define kLineButtonTag 1000
#define kPieButtonTag 2000

@interface YosKeepAccountsChartPresenter ()
<
UIScrollViewDelegate,
HJMediatorTargetInstance
>

@property (strong, nonatomic) YosKeepAccountsChartLineSceneModel *viewModel;
@property (weak, nonatomic) IBOutlet UIView *segmentBaseView;

@property (weak, nonatomic) IBOutlet YosKeepAccountsOrderList *tableScene;

@property (weak, nonatomic) IBOutlet UIScrollView *chartScrollView;

@property (strong, nonatomic) YosKeepAccountsChartLineScene *lineScene;

@property (strong, nonatomic) YosKeepAccountsChartPieScene *pieScene;

@property (strong, nonatomic) UIImage *pieBtnImage;

@property (strong, nonatomic) UIImage *lineBtnImage;

@property (weak, nonatomic) IBOutlet UIView *pieChartScene;
@property (weak, nonatomic) IBOutlet UIView *lineChartScene;

@property (strong, nonatomic) NSMutableDictionary *charts;

@property (strong, nonatomic) HMSegmentedControl *segmentedControl;

@end

@implementation YosKeepAccountsChartPresenter

+ (instancetype)instance {
    return StoryBoardLoaderRoot(@"Chart");
}

+ (id)targetInstance {
    return [YosKeepAccountsChartPresenter instance];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    [self setUpRAC];
    
}

- (void)setUpRAC {
    
    _viewModel = [YosKeepAccountsChartLineSceneModel new];
    _viewModel.type = YosKeepAccountsChartDay;
    
    WEAK_SELF
//    [RACObserve(_viewModel, lineEntitys) subscribeNext:^(NSArray <YosKeepAccountsChartLineEntity *> *entitys) {
//        STRONG_SELF
//        self.chartLineScene.entitys = entitys;
//    }];
}

- (void)setUpUI {
    
    self.navigationItem.title = @"汇总";
    self.chartScrollView.delegate = self;
    self.chartScrollView.pagingEnabled = YES;
    
    self.view.backgroundColor = HJHexColor(k0xf5f5f5);
    
    [self.pieChartScene addSubview:[self pieScene]];
    [self.lineChartScene addSubview:[self lineScene]];
    
    [self.pieScene mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.lineScene mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.segmentBaseView addSubview:self.segmentedControl];
    
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)createChartOnView:(UIView *)superview key:(YosKeepAccountsChartType)type {
    
    YosKeepAccountsChartBrokenLineScene *chartLineScene = [YosKeepAccountsChartBrokenLineScene new];
    YosKeepAccountsChartLineScene *lineScene = [YosKeepAccountsChartLineScene new];
    YosKeepAccountsChartPieScene *pieScene = [YosKeepAccountsChartPieScene new];
    
    [superview addSubview:chartLineScene];
    [superview addSubview:lineScene];
    [superview addSubview:pieScene];
    
    [@[chartLineScene, lineScene, pieScene] enumerateObjectsUsingBlock:^(UIView  * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }];
    
    NSMutableDictionary *chartDic = [NSMutableDictionary dictionary];
    [chartDic setValue:chartLineScene forKey:@"brokenLine"];
    [chartDic setValue:lineScene forKey:@"line"];
    [chartDic setValue:pieScene forKey:@"pie"];
    
    [self.charts setValue:chartDic forKey:@(type).stringValue];
}

#pragma mark - Getter & Setter Methods

- (YosKeepAccountsChartLineScene *)lineScene {
    if (!_lineScene) {
        _lineScene = [YosKeepAccountsChartLineScene new];
    }
    return _lineScene;
}

- (YosKeepAccountsChartPieScene *)pieScene {
    if (!_pieScene) {
        _pieScene = [YosKeepAccountsChartPieScene new];
    }
    return _pieScene;
}

- (HMSegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [HMSegmentedControl new];
        _segmentedControl.sectionTitles = @[@"柱状图",@"扇形图"];
        
        _segmentedControl.selectedTitleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15],
                                                          NSForegroundColorAttributeName: YosKeepAccountsThemeColor};
        _segmentedControl.titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15],
                                                  NSForegroundColorAttributeName: HJHexColor(0x666666)};
        _segmentedControl.selectionIndicatorColor = YosKeepAccountsThemeColor;
        _segmentedControl.selectionIndicatorHeight = 3;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        [_segmentedControl addTarget:self
                              action:@selector(chartTypeValueChange:)
                    forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

- (NSMutableDictionary *)charts {
    if (!_charts) {
        _charts = [NSMutableDictionary dictionary];
    }
    return _charts;
}

- (UIImage *)pieBtnImage {
    if (!_pieBtnImage) {
        UIImage *lineIcon = [UIImage imageNamed:@"pie_view"];
        UIImage *themeImage = [UIImage hj_imageWithColor:YosKeepAccountsThemeColor];
        themeImage = [themeImage hj_imageScaledToSize:lineIcon.size];
        themeImage = [themeImage hj_imageWithMask:lineIcon];
        _pieBtnImage = themeImage;
    }
    return _pieBtnImage;
}
- (UIImage *)lineBtnImage {
    if (!_lineBtnImage) {
        UIImage *lineIcon = [UIImage imageNamed:@"line_view"];
        UIImage *themeImage = [UIImage hj_imageWithColor:YosKeepAccountsThemeColor];
        themeImage = [themeImage hj_imageScaledToSize:lineIcon.size];
        themeImage = [themeImage hj_imageWithMask:lineIcon];
        _lineBtnImage = themeImage;
    }
    return _lineBtnImage;
}

- (void)requestData {
    
    YosKeepAccountsOrderEntity *model = [YosKeepAccountsOrderEntity new];
    model.yka_username = [YosKeepAccountsUserManager shareInstance].phone;
    
    NSMutableArray<YosKeepAccountsOrderEntity *> *result =
    [[YosKeepAccountsSQLManager share] searchData:model tableName:kSQLTableName];
    
    NSArray *allOrderArray = result;
    if (allOrderArray.count == 0) {
        self.tableScene.entitys = @[];
        [self.tableScene cyl_reloadData];
        return ;
    }
    double sum;
    NSArray *tempArray = [YosKeepAccountsOrderEntity templateOrderArrayWithOrders:result sumWealth:&sum];
    self.pieScene.entitys = tempArray;
    self.lineScene.entitys = tempArray;
    self.tableScene.entitys = tempArray;
    [self.tableScene cyl_reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat halfWidth = scrollView.hj_width * 0.5;
    self.segmentedControl.selectedSegmentIndex = scrollView.contentOffset.x > halfWidth ? 1 : 0;
    
}

- (void)chartTypeValueChange:(HMSegmentedControl *)segmentedControl {
    CGPoint offset = CGPointMake(self.chartScrollView.hj_width * segmentedControl.selectedSegmentIndex, 0);
    self.chartScrollView.delegate = nil;
    [self.chartScrollView setContentOffset:offset animated:YES];
    WEAK_SELF
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        STRONG_SELF
        self.chartScrollView.delegate = self;
    });
}

- (IBAction)changeType:(UIButton *)sender {
    if (sender.tag == kLineButtonTag) {
        sender.tag = kPieButtonTag;
    } else {
        sender.tag = kLineButtonTag;
    }
    UIView *fakeSmallButton = [sender snapshotViewAfterScreenUpdates:NO];
    fakeSmallButton.frame = sender.frame;
    [sender.superview addSubview:fakeSmallButton];
    if (sender.tag == kLineButtonTag) {
        [sender setImage:self.pieBtnImage forState:UIControlStateNormal];
    } else {
        [sender setImage:self.lineBtnImage forState:UIControlStateNormal];
    }
    [sender setNeedsDisplay];
    CGPoint senderCenter = sender.center;
    UIImage *fakeBigImage = [sender imageForState:UIControlStateNormal];
    UIImageView *fakeBigButton = [[UIImageView alloc] initWithImage:fakeBigImage];
    fakeBigButton.frame = CGRectMake(senderCenter.x, senderCenter.y, 0, 0);
    [sender.superview addSubview:fakeBigButton];
    sender.hidden = YES;
    sender.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3
                     animations:^{
                         CGPoint center = fakeSmallButton.center;
                         fakeSmallButton.bounds = CGRectMake(center.x, center.y, 0, 0);
                     } completion:^(BOOL finished) {
                         [fakeSmallButton removeFromSuperview];
                         [UIView animateWithDuration:0.3
                                               delay:0
                              usingSpringWithDamping:0.3
                               initialSpringVelocity:5.0
                                             options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                                 fakeBigButton.bounds = CGRectMake(0, 0, fakeBigImage.size.width, fakeBigImage.size.height);
                                                 fakeBigButton.center = senderCenter;
                                             }
                                          completion:^(BOOL finished) {
                                              [fakeBigButton removeFromSuperview];
                                              sender.hidden = NO;
                                              sender.userInteractionEnabled = YES;
                                          }];
                     }];
    [UIView animateWithDuration:0.7 animations:^{
    } completion:^(BOOL finished) {
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self requestData];
}

#pragma mark - Getter & Setter Methods

#pragma mark - Super Method
#pragma mark - Network Method
#pragma mark - Public Method
#pragma mark - Private Method
#pragma mark - Notification Method
#pragma mark - Event & Target Methods

//- (IBAction)addOrderClick:(YosKeepAccountsLeapButton *)sender {
//    [[HJMediator shared] routeToURL:HJAPPURL(@"EditOrder") withParameters:nil, nil];
//}
//
//- (IBAction)moreBtnClick:(UIButton *)sender {
//    [[HJMediator shared] routeToURL:HJAPPURL(@"OrderList") withParameters:nil, nil];
//}


@end
