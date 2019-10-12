//
//  CostMapChartPresenter.m
//  CostMap
//
//

#import "CostMapChartPresenter.h"
#import "CostMapChartBrokenLineScene.h"
#import "CostMapChartLineSceneModel.h"
#import "CostMapChartLineScene.h"
#import "CostMapChartPieScene.h"
#import "CostMapOrderList.h"
#import "CostMapOrderEntity+CostMapService.h"

#import <HJMediator/HJMediator.h>
#import <HMSegmentedControl/HMSegmentedControl.h>

#define kLineButtonTag 1000
#define kPieButtonTag 2000

@interface CostMapChartPresenter ()
<
UIScrollViewDelegate,
HJMediatorTargetInstance
>

@property (strong, nonatomic) CostMapChartLineSceneModel *viewModel;
@property (weak, nonatomic) IBOutlet UIView *segmentBaseView;

@property (weak, nonatomic) IBOutlet CostMapOrderList *tableScene;

@property (weak, nonatomic) IBOutlet UIScrollView *chartScrollView;

@property (strong, nonatomic) CostMapChartLineScene *lineScene;

@property (strong, nonatomic) CostMapChartPieScene *pieScene;

@property (strong, nonatomic) UIImage *pieBtnImage;

@property (strong, nonatomic) UIImage *lineBtnImage;

@property (weak, nonatomic) IBOutlet UIView *pieChartScene;
@property (weak, nonatomic) IBOutlet UIView *lineChartScene;

@property (strong, nonatomic) NSMutableDictionary *charts;

@property (strong, nonatomic) HMSegmentedControl *segmentedControl;

@end

@implementation CostMapChartPresenter

+ (instancetype)instance {
    return StoryBoardLoaderRoot(@"Chart");
}

+ (id)targetInstance {
    return [CostMapChartPresenter instance];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    [self setUpRAC];
    
}

- (void)changeThemeColor {
    [super changeThemeColor];
    
    self.navigationItem.title = @"Total";
    self.chartScrollView.delegate = self;
    self.chartScrollView.pagingEnabled = YES;
    
    self.view.backgroundColor = HJHexColor(k0xf5f5f5);
    
    [[self pieScene] removeFromSuperview];
    [[self lineScene] removeFromSuperview];
    [self.segmentedControl removeFromSuperview];
    
    [self setUpUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self requestData];
}

- (void)setUpRAC {
    
    _viewModel = [CostMapChartLineSceneModel new];
    _viewModel.type = CostMapChartDay;
}

- (void)setUpUI {
    
    self.navigationItem.title = @"Total";
    self.title = @"Total";
    self.navigationController.title = @"Total";
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

- (void)createChartOnView:(UIView *)superview key:(CostMapChartType)type {
    
    CostMapChartBrokenLineScene *chartLineScene = [CostMapChartBrokenLineScene new];
    CostMapChartLineScene *lineScene = [CostMapChartLineScene new];
    CostMapChartPieScene *pieScene = [CostMapChartPieScene new];
    
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



- (CostMapChartLineScene *)lineScene {
    if (!_lineScene) {
        _lineScene = [CostMapChartLineScene new];
    }
    return _lineScene;
}

- (CostMapChartPieScene *)pieScene {
    if (!_pieScene) {
        _pieScene = [CostMapChartPieScene new];
    }
    return _pieScene;
}

- (HMSegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [HMSegmentedControl new];
        _segmentedControl.sectionTitles = @[@"Histogram",
                                            @"Sector Diagram"];
        
        _segmentedControl.selectedTitleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15],
                                                          NSForegroundColorAttributeName: CostMapThemeColor};
        _segmentedControl.titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15],
                                                  NSForegroundColorAttributeName: HJHexColor(0x666666)};
        _segmentedControl.selectionIndicatorColor = CostMapThemeColor;
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
        UIImage *themeImage = [UIImage hj_imageWithColor:CostMapThemeColor];
        themeImage = [themeImage hj_imageScaledToSize:lineIcon.size];
        themeImage = [themeImage hj_imageWithMask:lineIcon];
        _pieBtnImage = themeImage;
    }
    return _pieBtnImage;
}
- (UIImage *)lineBtnImage {
    if (!_lineBtnImage) {
        UIImage *lineIcon = [UIImage imageNamed:@"line_view"];
        UIImage *themeImage = [UIImage hj_imageWithColor:CostMapThemeColor];
        themeImage = [themeImage hj_imageScaledToSize:lineIcon.size];
        themeImage = [themeImage hj_imageWithMask:lineIcon];
        _lineBtnImage = themeImage;
    }
    return _lineBtnImage;
}

- (void)requestData {
    
    CostMapOrderEntity *model = [CostMapOrderEntity new];
//    model.yka_username = @"nobody";
    
    NSMutableArray<CostMapOrderEntity *> *result =
    [[CostMapSQLManager share] searchData:model tableName:kSQLTableName];
    
    NSArray *allOrderArray = result;
    if (allOrderArray.count == 0) {
        self.tableScene.entitys = @[];
        self.pieScene.entitys = @[];
        self.lineScene.entitys = @[];
        [self.tableScene cyl_reloadData];
        return ;
    }
    double sum;
    NSArray *tempArray = [CostMapOrderEntity templateOrderArrayWithOrders:result sumWealth:&sum];
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

@end
