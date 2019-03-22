#import "YosKeepAccountsIntroducePresenter.h"
#import "YosKeepAccountsScrollDisplayPresenter.h"
#import "YosKeepAccountsPagePresenter.h"
@interface YosKeepAccountsIntroducePresenter ()<YosKeepAccountsScrollDisplayPresenterDelegate>
@property(nonatomic,strong) YosKeepAccountsScrollDisplayPresenter *scrollVC;
@end
@implementation YosKeepAccountsIntroducePresenter
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:self.scrollVC];
    self.scrollVC.view.frame = CGRectMake(0,0, SWidth, SHeight);
    [self.view addSubview:self.scrollVC.view];
    self.view.userInteractionEnabled = YES;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(YosKeepAccountsScrollDisplayPresenter*)scrollVC{
    if (!_scrollVC) {
        NSArray*vcs = @[[self createPageVC:PageOneType],
                        [self createPageVC:PageTwoType],
                        [self createPageVC:PageThreeType],
                        ];
        _scrollVC =[[YosKeepAccountsScrollDisplayPresenter alloc] initWithControllers:vcs];
        _scrollVC.delegate = self;
    }
    return _scrollVC;
}
-(YosKeepAccountsPagePresenter *)createPageVC:(PageType)type{
    YosKeepAccountsPagePresenter *pageVC = [[YosKeepAccountsPagePresenter alloc]init];
    pageVC.rootStartVC = ^{
        self.rootStartVC();
    };
    pageVC.type = type;
    return pageVC;
}
- (void)scrollDisplayPresenter:(YosKeepAccountsScrollDisplayPresenter *)scrollDisplayPresenter didSelectedIndex:(NSInteger)index{
}
- (void)scrollDisplayPresenter:(YosKeepAccountsScrollDisplayPresenter *)scrollDisplayPresenter currentIndex:(NSInteger)index{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
