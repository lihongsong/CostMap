#import "YosKeepAccountsBasePresenter.h"
@interface YosKeepAccountsBasePresenter ()
@end
@implementation YosKeepAccountsBasePresenter
#pragma mark - life circle
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
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self setpNavBarWhenSceneWillAppear];
}
- (void)setpNavBarWhenSceneWillAppear {
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : YosKeepAccountsThemeTitleColor}];
    [self.navigationController.navigationBar setTintColor:YosKeepAccountsThemeTitleColor];
    [self.navigationController.navigationBar setBarTintColor:YosKeepAccountsThemeColor];
    [self.navigationController.navigationBar setBackgroundColor:YosKeepAccountsThemeColor];
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"yka_navbar_back_02"]];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"yka_navbar_back_02"]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage hj_imageWithColor:[UIColor clearColor]]];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : YosKeepAccountsThemeTitleColor } forState:UIControlStateNormal];
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
#pragma mark - iOS11-ScrollScene内边距设置兼容
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
