#import "CostMapBasePresenter.h"
@interface CostMapBasePresenter ()
@end
@implementation CostMapBasePresenter
- (id)init {
    self = [super init];
    if (self) {
        [self setupBackBarButtonItem];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupBackBarButtonItem];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self adjustsScrollSceneInsets];
    [self setNeedsStatusBarAppearanceUpdate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlerThemeChangeNoti) name:@"kNotificationChangeThemeColor" object:nil];
}

- (void)handlerThemeChangeNoti {
    [self changeThemeColor];
}

- (void)changeThemeColor {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self setpNavBarWhenSceneWillAppear];
}
- (void)setpNavBarWhenSceneWillAppear {
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : CostMapThemeTitleColor}];
    [self.navigationController.navigationBar setTintColor:CostMapThemeTitleColor];
    [self.navigationController.navigationBar setBarTintColor:CostMapThemeColor];
    [self.navigationController.navigationBar setBackgroundColor:CostMapThemeColor];
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"yka_navbar_back_02"]];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"yka_navbar_back_02"]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage hj_imageWithColor:[UIColor clearColor]]];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : CostMapThemeTitleColor } forState:UIControlStateNormal];
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
}
- (void)adjustsScrollSceneInsets {
    adjustsScrollSceneInsets_NO([self getFirstScrollSceneFromVC], self);
}
- (UIScrollView *)getFirstScrollSceneFromVC {
    UIScrollView * scrollScene = nil;
    for (UIView * view  in self.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            scrollScene = (UIScrollView *)view;
            break;
        }
    }
    return scrollScene;
}
- (void)setupBackBarButtonItem {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}
- (void)setupCustomLeftWithImage:(UIImage *)image target:(id)tar action:(SEL)act {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 20);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:tar action:act forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)setupCustomRightWithImage:(UIImage *)image target:(id)tar action:(SEL)act {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 0);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:tar action:act forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}
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
