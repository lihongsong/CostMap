#import "YosKeepAccountsScrollDisplayPresenter.h"
@interface YosKeepAccountsScrollDisplayPresenter ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@end
@implementation YosKeepAccountsScrollDisplayPresenter
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpPageController];
}
-(void)setUpPageController{
    _pageVC=[[UIPageViewController alloc] initWithTransitionStyle:1 navigationOrientation:0 options:nil];
    _pageVC.delegate = self;
    _pageVC.dataSource = self;
    _pageVC.view.frame = CGRectMake(0,0,SWidth,SHeight);
    [self addChildViewController:_pageVC];
    [self.view addSubview:_pageVC.view];
    [_pageVC setViewControllers:@[_controllers.firstObject] direction:0 animated:YES completion:nil];
}
- (instancetype)initWithControllers:(NSArray *)controllers{
    if (self = [super init]) {
        _controllers = [controllers copy];
    }
    return self;
}
-(void)setCurrentPage:(NSInteger)currentPage{
    UIViewController *vc=_controllers[currentPage];
    if (currentPage > _currentPage){
        [_pageVC setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:true completion:nil];
    }else if (currentPage < _currentPage){
        [_pageVC setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:true completion:nil];
    }
    _currentPage = currentPage;
}
#pragma mark - UIPageViewController
- (void)pagePresenter:(UIPageViewController *)pagePresenter didFinishAnimating:(BOOL)finished previousPresenters:(NSArray<UIViewController *> *)previousPresenters transitionCompleted:(BOOL)completed{
    if (completed && finished) {
        NSInteger index=[_controllers indexOfObject: pagePresenter.viewControllers.firstObject];
        if ([self.delegate respondsToSelector:@selector(scrollDisplayPresenter:currentIndex:)] ) {
            [self.delegate scrollDisplayPresenter:self currentIndex:index];
            self.currentPage = index;
        }
    }
}
- (nullable UIViewController *)pagePresenter:(UIPageViewController *)pagePresenter viewControllerBeforePresenter:(UIViewController *)viewController{
    NSInteger index=[_controllers indexOfObject:viewController];
    if (index > 0){
        return _controllers[index -1];
    }else{
        return nil;
    }
}
- (nullable UIViewController *)pagePresenter:(UIPageViewController *)pagePresenter viewControllerAfterPresenter:(UIViewController *)viewController{
    NSInteger index=[_controllers indexOfObject:viewController];
    if (index < _controllers.count - 1) {
        return _controllers[index +1];
    }else{
        return nil;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
