#import "YosKeepAccountsHomePresenter.h"
#import "YosKeepAccountsOrderListCell.h"
#import "YosKeepAccountsOrderEntity.h"
#import "YosKeepAccountsOrderList.h"
#import "YosKeepAccountsChartLineScene.h"
#import "YosKeepAccountsChartPieScene.h"
#import "YosKeepAccountsLeapButton.h"
#import "YosKeepAccountsSettingScene.h"
#import "UNNoDataScene.h"
#import "YosKeepAccountsHomeDateSelectButton.h"
#import "YosKeepAccountsOrderEntity+YosKeepAccountsService.h"
#import "UIViewController+Push.h"
#import "YosKeepAccountsEditOrderPresenter.h"
#import "YosKeepAccountsTranstionAnimationPush.h"
#import "YosKeepAccountsCustomDatePickerScene.h"
#import "YosKeepAccountsCountingLabel.h"
#define kLineButtonTag 1000
#define kPieButtonTag 2000

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface YosKeepAccountsHomePresenter () <UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *tableHeaderScene;
@property (strong, nonatomic) YosKeepAccountsChartLineScene *lineScene;
@property (weak, nonatomic) IBOutlet YosKeepAccountsHomeDateSelectButton *dateSelectBtn;
@property (weak, nonatomic) IBOutlet YosKeepAccountsLeapButton *addOrderBtn;
@property (strong, nonatomic) YosKeepAccountsChartPieScene *pieScene;
@property (weak, nonatomic) IBOutlet YosKeepAccountsOrderList *tableScene;
@property (weak, nonatomic) IBOutlet UIView *chartBaseVw;
@property (weak, nonatomic) IBOutlet UIButton *changeBt;
//@property (weak, nonatomic) IBOutlet UIButton *arrowBt;
@property (assign, nonatomic) BOOL isArrowUp;
@property (weak, nonatomic) IBOutlet UIButton *moreBt;
@property (weak, nonatomic) IBOutlet YosKeepAccountsCountingLabel *wealthLb;
@property (weak, nonatomic) IBOutlet UIView *headerBackScene;
@property (assign, nonatomic) CGFloat totalWealth;
@property (weak, nonatomic) IBOutlet UIView *navbar;
@property (weak, nonatomic) IBOutlet UIView *headerScene;
@property (assign, nonatomic) NSUInteger year;
@property (assign, nonatomic) NSUInteger month;
@property (strong, nonatomic) UIImage *pieBtnImage;
@property (strong, nonatomic) UIImage *lineBtnImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;
@end
@implementation YosKeepAccountsHomePresenter
+ (instancetype)instance {
    return StoryBoardLoaderRoot(@"OrderHome");
}
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"花钱无忧";
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self setUpUI];
    [self setUpRAC];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self requestData];
    [[self navigationController] setDelegate:self];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    if (_totalWealth > 0) {
        [self doWealthAnimation];
    }
}

- (void)setUpRAC {
    
    [RACObserve(self, totalWealth) subscribeNext:^(id x) {
        NSLog(@"totalWealth: %@", x);
    }];
}

- (void)setpNavBarWhenSceneWillAppear {
    [self cfy_setNavigationBarBackgroundColor:YosKeepAccountsThemeColor];
    [self cfy_setNavigationBarBackgroundImage:nil];
    [self cfy_setNavigationBarShadowImageBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}
#pragma mark - Getter & Setter Methods
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
- (YosKeepAccountsChartPieScene *)pieScene {
    if (!_pieScene) {
        _pieScene = [YosKeepAccountsChartPieScene new];
        _pieScene.drawHoleEnabled = NO;
    }
    return _pieScene;
}
- (YosKeepAccountsChartLineScene *)lineScene {
    if (!_lineScene) {
        _lineScene = [YosKeepAccountsChartLineScene new];
    }
    return _lineScene;
}
#pragma mark - Super Method
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.animateRect = self.addOrderBtn.frame;
}
#pragma mark - Network Method
#pragma mark - Public Method
#pragma mark - Private Method
- (void)doWealthAnimation {
    CGFloat wealth = fabs(_totalWealth);
    [_wealthLb countFrom:0.00
                     to:wealth
           withDuration:1.0f];
}
- (NSString *)dateString {
    return [NSString stringWithFormat:@"%04ld-%02ld",(long)_year, (long)_month];
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
    _navHeight.constant = HJ_NavigationH;
    _lineScene.alpha = 1.0f;
    _pieScene.alpha = 0.0f;
    [_changeBt setImage:self.pieBtnImage forState:UIControlStateNormal];
    _changeBt.tag = kLineButtonTag;
    _wealthLb.textAlignment = NSTextAlignmentCenter;
    _wealthLb.font = [UIFont fontWithName:@"AvenirNextCondensed-Bold" size:28];
    _wealthLb.textColor = [UIColor whiteColor];
    _wealthLb.formatBlock = ^NSString *(CGFloat value) {
        return [NSString stringWithFormat:@"¥%@",[@(value).stringValue moneyStyle]];
    };
    _wealthLb.format = @"%.2f";
    self.navbar.backgroundColor = YosKeepAccountsThemeColor;
    self.view.backgroundColor = HJHexColor(k0xf5f5f5);
    self.headerBackScene.backgroundColor = YosKeepAccountsThemeColor;
    [self.changeBt setTitleColor:YosKeepAccountsThemeColor forState:UIControlStateNormal];
    [self.changeBt setTitleColor:YosKeepAccountsThemeColor forState:UIControlStateHighlighted];
    self.animateRect = _addOrderBtn.frame;
    UIImage *addBtnImage = [UIImage imageNamed:@"orderAdd"];
    [_addOrderBtn setImage:[addBtnImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [_addOrderBtn setTintColor:YosKeepAccountsThemeColor];
    self.navigationController.delegate = self;
    self.tableHeaderScene.backgroundColor = YosKeepAccountsThemeColor;
    self.tableScene.tableType = YosKeepAccountsOrderTableTypeMonth;
    WEAK_SELF
    self.tableScene.selectAction = ^(YosKeepAccountsOrderEntity * _Nonnull model) {
        STRONG_SELF
        NSDictionary *param = @{@"year": @(self.year).stringValue,
                                @"month": @(self.month).stringValue,
                                @"order_type_id": model.s_type_id};
        [[HJMediator shared] routeToURL:HJAPPURL(@"OrderMonthList") withParameters:param, nil];
    };
    [_chartBaseVw addSubview:self.lineScene];
    [_chartBaseVw addSubview:self.pieScene];
    [_chartBaseVw bringSubviewToFront:_changeBt];
    [_lineScene mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.chartBaseVw);
    }];
    [_pieScene mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.chartBaseVw);
    }];
    _lineScene.alpha = 1.0f;
    _pieScene.alpha = 0.0f;
    NSDate *today = [NSDate hj_getToday];
    _year = [today hj_year];
    _month = [today hj_month];
    [_dateSelectBtn setTitle:[self dateString] forState:UIControlStateNormal];
}
- (void)requestData {
    [_dateSelectBtn setTitle:[self dateString] forState:UIControlStateNormal];
    [[YosKeepAccountsSQLManager share] searchData:kSQLTableName
                                  year:@(self.year).stringValue
                                 month:@(self.month).stringValue
                                   day:nil
                                result:^(NSMutableArray<YosKeepAccountsOrderEntity *> *result, NSError *error) {
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
                                    self.totalWealth = sum;
                                    [self doWealthAnimation];
                                }];
}
#pragma mark - Notification Method
#pragma mark - Event & Target Methods
- (IBAction)setBtnClick {
        WEAK_SELF
        [YosKeepAccountsSettingScene showSettingSceneOnSuperPresenter:self.navigationController
                                                gotoVCHandler:^(UIViewController * _Nonnull viewController) {
                                                    STRONG_SELF
                                                    [self.navigationController pushViewController:viewController animated:YES];
                                                }];
}
- (IBAction)addOrderClick:(YosKeepAccountsLeapButton *)sender {
    [[HJMediator shared] routeToURL:HJAPPURL(@"EditOrder") withParameters:nil, nil];
}
- (IBAction)moreBtnClick:(UIButton *)sender {
    [[HJMediator shared] routeToURL:HJAPPURL(@"OrderList") withParameters:nil, nil];
}
- (IBAction)dateBtnClick {
    [self arrowAnimate];
    WEAK_SELF
    [YosKeepAccountsCustomDatePickerScene showDatePickerWithTitle:@"选择时间"
                                           dateType:YosKeepAccountsCustomDatePickerModeYM
                                    defaultSelValue:[self dateString]
                                            minDate:nil
                                            maxDate:nil
                                       isAutoSelect:NO
                                         themeColor:YosKeepAccountsThemeColor
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
        if (self.lineScene.alpha == 0.0f) {
            self.lineScene.alpha = 1.0f;
            self.pieScene.alpha = 0.0f;
        } else {
            self.lineScene.alpha = 0.0f;
            self.pieScene.alpha = 1.0f;
        }
        if (self.lineScene.alpha == 1.0f) {
            [self.lineScene animate];
        } else {
            [self.pieScene animate];
        }
    } completion:^(BOOL finished) {
    }];
}
#pragma mark -- UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if ([fromVC isKindOfClass:[YosKeepAccountsHomePresenter class]] &&
        [toVC isKindOfClass:[YosKeepAccountsEditOrderPresenter class]] &&
        operation == UINavigationControllerOperationPush) {
        return [YosKeepAccountsTranstionAnimationPush new];
    } else {
        return nil;
    }
}
@end
