#import "CostMapHomePresenter.h"
#import "CostMapOrderListCell.h"
#import "CostMapOrderEntity.h"
#import "CostMapOrderList.h"
#import "CostMapLeapButton.h"
#import "UNNoDataScene.h"
#import "CostMapHomeDateSelectButton.h"
#import "CostMapOrderEntity+CostMapService.h"
#import "UIViewController+Push.h"
#import "CostMapEditOrderPresenter.h"
#import "CostMapTranstionAnimationPush.h"
#import "CostMapCustomDatePickerScene.h"
#import "CostMapCountingLabel.h"
#import "CostMapWaterWaveView.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface CostMapHomePresenter ()
<
UINavigationControllerDelegate
>
@property (weak, nonatomic) IBOutlet UIButton *todayBtn;
@property (weak, nonatomic) IBOutlet UIView *waterWaveView;
@property (weak, nonatomic) IBOutlet CostMapHomeDateSelectButton *dateSelectBtn;
@property (weak, nonatomic) IBOutlet UIButton *addOrderBtn;
@property (weak, nonatomic) IBOutlet CostMapOrderList *tableScene;
@property (assign, nonatomic) BOOL isArrowUp;
@property (weak, nonatomic) IBOutlet CostMapCountingLabel *wealthLb;
@property (weak, nonatomic) IBOutlet UIView *headerBackScene;
@property (assign, nonatomic) CGFloat totalWealth;
@property (weak, nonatomic) IBOutlet UIView *navbar;
@property (weak, nonatomic) IBOutlet UIView *headerScene;
@property (weak, nonatomic) IBOutlet UILabel *yearLb;
@property (assign, nonatomic) NSUInteger year;
@property (weak, nonatomic) IBOutlet UIImageView *pickerArrowIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *wealthTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *monthTitleLb;
@property (weak, nonatomic) IBOutlet UIButton *rightBarBtn;
@property (assign, nonatomic) NSUInteger month;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;
@end
@implementation CostMapHomePresenter

+ (instancetype)instance {
    return StoryBoardLoaderRoot(@"OrderHome");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Bill";
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self setUpUI];
    [self setUpRAC];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self requestData];
    [[self navigationController] setDelegate:self];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if (_totalWealth > 0) {
        [self doWealthAnimation];
    }
}

- (void)changeThemeColor {
    [super changeThemeColor];
    
    self.rightBarBtn.tintColor = CostMapThemeTitleColor;
    self.titleLb.textColor = CostMapThemeTitleColor;
    [_pickerArrowIV setTintColor:CostMapThemeTitleColor];
    _monthTitleLb.textColor = CostMapThemeTitleColor;
    [_dateSelectBtn setTitleColor:CostMapThemeTitleColor forState:UIControlStateNormal];
    _yearLb.textColor = CostMapThemeTitleColor;
    _wealthLb.textColor = CostMapThemeTitleColor;
    _wealthTitleLb.textColor = CostMapThemeTitleColor;
    [_todayBtn setTitleColor:CostMapThemeTitleColor forState:UIControlStateNormal];
    _headerScene.backgroundColor = CostMapThemeColor;
    [_addOrderBtn setTintColor:CostMapThemeColor];
    
    self.navbar.backgroundColor = CostMapThemeColor;
    self.view.backgroundColor = HJHexColor(k0xf5f5f5);
    self.headerBackScene.backgroundColor = CostMapThemeColor;
    [_addOrderBtn setTintColor:CostMapThemeColor];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)setUpRAC {
}

- (void)setpNavBarWhenSceneWillAppear {
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.animateRect = CGRectMake(200, 200, 20, 20);
//    self.animateRect = self.addOrderBtn.frame;
}
- (void)doWealthAnimation {
    CGFloat wealth = fabs(_totalWealth);
    [_wealthLb countFrom:0.00
                     to:wealth
           withDuration:1.0f];
}

- (void)arrowAnimate {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation.duration = 0.5; 
    animation.repeatCount = 1; 
    if (_isArrowUp) {
        animation.fromValue = [NSNumber numberWithFloat:M_PI]; 
        animation.toValue = [NSNumber numberWithFloat:0.0]; 
    } else {
        animation.fromValue = [NSNumber numberWithFloat:0.0]; 
        animation.toValue = [NSNumber numberWithFloat:M_PI]; 
    }
    _isArrowUp = !_isArrowUp;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [_dateSelectBtn.imageView.layer addAnimation:animation forKey:@"rotate-layer"];
}
- (void)setUpUI {
    
    self.rightBarBtn.tintColor = CostMapThemeTitleColor;
    self.titleLb.textColor = CostMapThemeTitleColor;
    [_pickerArrowIV setTintColor:CostMapThemeTitleColor];
    _monthTitleLb.textColor = CostMapThemeTitleColor;
    [_dateSelectBtn setTitleColor:CostMapThemeTitleColor forState:UIControlStateNormal];
    _yearLb.textColor = CostMapThemeTitleColor;
    _wealthLb.textColor = CostMapThemeTitleColor;
    _wealthTitleLb.textColor = CostMapThemeTitleColor;
    [_todayBtn setTitleColor:CostMapThemeTitleColor forState:UIControlStateNormal];
    
    [_todayBtn addTarget:self action:@selector(todayClick) forControlEvents:UIControlEventTouchUpInside];
    
    CostMapWaterWaveView *waterView =
    [[CostMapWaterWaveView alloc] initWithFrame:CGRectMake(0, 0, SWidth, _waterWaveView.hj_height)];
    waterView.backgroundColor = [UIColor clearColor];
    waterView.firstWaveHeight = 30;
    waterView.secondWaveHeight = 25;
    waterView.showSecondWave = YES;
    waterView.firstWaveColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    waterView.secondWaveColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    [_waterWaveView addSubview:waterView];
    
    _headerScene.backgroundColor = CostMapThemeColor;
    [_addOrderBtn setTintColor:CostMapThemeColor];
    
    [waterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.waterWaveView);
    }];
    
    [waterView startWaveAnimate];
    
    _navHeight.constant = HJ_NavigationH;
    
    _wealthLb.textAlignment = NSTextAlignmentLeft;
    _wealthLb.formatBlock = ^NSString *(CGFloat value) {
        return [NSString stringWithFormat:@"??%@",[@(value).stringValue moneyStyle]];
    };
    _wealthLb.format = @"%.2f";
    self.navbar.backgroundColor = CostMapThemeColor;
    self.view.backgroundColor = HJHexColor(k0xf5f5f5);
    self.headerBackScene.backgroundColor = CostMapThemeColor;
//    self.animateRect = _addOrderBtn.frame;
    self.animateRect = CGRectMake(200, 200, 20, 20);
    UIImage *addBtnImage = [UIImage imageNamed:@"yka_orderAdd"];
    [_addOrderBtn setImage:[addBtnImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [_addOrderBtn setTintColor:CostMapThemeColor];
    self.navigationController.delegate = self;
    WEAK_SELF
    
    NSDate *today = [NSDate hj_getToday];
    _year = [today hj_year];
    _month = [today hj_month];
    
    _yearLb.text = [NSString stringWithFormat:@"%ld year",_year];
    [_dateSelectBtn setTitle:[NSString stringWithFormat:@"%02ld",_month] forState:UIControlStateNormal];
    
    self.tableScene.enableDelete = YES;
    self.tableScene.tableType = CostMapOrderTableTypeMonth_Type;
    self.tableScene.deleteAction = ^(UITableViewCellEditingStyle editingStyle, CostMapOrderEntity * _Nonnull model) {
        STRONG_SELF
        [[CostMapSQLManager share] deleteData:kSQLTableName yka_id:model.yka_id];
        NSMutableArray *tempArray = [self.tableScene.entitys mutableCopy];
        [tempArray removeObject:model];
        self.tableScene.entitys = tempArray;
        [self.tableScene cyl_reloadData];
    };
    self.tableScene.selectAction = ^(CostMapOrderEntity * _Nonnull model) {
        [[HJMediator shared] routeToURL:HJAPPURL(@"EditOrder") withParameters:@{@"orderEntity": model}, nil];
    };
}

- (void)todayClick {
    NSDate *today = [NSDate hj_getToday];
    _year = [today hj_year];
    _month = [today hj_month];
    [self arrowAnimate];
    [self requestData];
}

- (void)requestData {
    
    _yearLb.text = [NSString stringWithFormat:@"%ld year",_year];
    [_dateSelectBtn setTitle:[NSString stringWithFormat:@"%02ld",_month] forState:UIControlStateNormal];
    
    CostMapOrderEntity *model = [CostMapOrderEntity new];
    model.yka_year = @(self.year).stringValue;
    model.yka_month = @(self.month).stringValue;
//    model.yka_username = @"nobody";
    NSArray *result =
    [[CostMapSQLManager share] searchData:model
                                        tableName:kSQLTableName];
    NSSortDescriptor *sortDes = [NSSortDescriptor sortDescriptorWithKey:@"yka_time" ascending:NO];
    result = [result sortedArrayUsingDescriptors:@[sortDes]];
    self.tableScene.entitys = result;
    [self.tableScene cyl_reloadData];
    
    double sum;
    [CostMapOrderEntity templateOrderArrayWithOrders:result sumWealth:&sum];
    self.totalWealth = sum;
    [self doWealthAnimation];
}


- (IBAction)chartBtnClick {
    [[HJMediator shared] routeToURL:HJAPPURL(@"Chart") withParameters:nil, nil];
}

- (IBAction)addOrderClick:(CostMapLeapButton *)sender {
    [[HJMediator shared] routeToURL:HJAPPURL(@"EditOrder") withParameters:nil, nil];
}

- (IBAction)moreBtnClick:(UIButton *)sender {
    [[HJMediator shared] routeToURL:HJAPPURL(@"OrderList") withParameters:nil, nil];
}

- (IBAction)dateBtnClick {
    [self arrowAnimate];
    
    NSString *dateString = [NSString stringWithFormat:@"%04ld-%02ld",_year, _month];
    WEAK_SELF
    [CostMapCustomDatePickerScene showDatePickerWithTitle:@"Choose Time"
                                           dateType:CostMapCustomDatePickerModeYM
                                    defaultSelValue:dateString
                                            minDate:nil
                                            maxDate:nil
                                       isAutoSelect:NO
                                         themeColor:CostMapThemeColor
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


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if ([fromVC isKindOfClass:[CostMapHomePresenter class]] &&
        [toVC isKindOfClass:[CostMapEditOrderPresenter class]] &&
        operation == UINavigationControllerOperationPush) {
        return [CostMapTranstionAnimationPush new];
    } else {
        return nil;
    }
}

@end
