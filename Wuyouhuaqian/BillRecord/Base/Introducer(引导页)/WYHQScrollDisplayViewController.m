//
//  ScrollDisplayViewController.m
// WuYouQianBao
//
//  Created by jasonzhang on 2018/5/14.
//  Copyright © 2018年 jasonzhang. All rights reserved.
//

#import "WYHQScrollDisplayViewController.h"
@interface WYHQScrollDisplayViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@end

@implementation WYHQScrollDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

//传入视图控制器
- (instancetype)initWithControllers:(NSArray *)controllers{
    if (self = [super init]) {
        //为了防止实参是可变数组，需要复制一份出来。 这样可以保证属性不会因为可变数组在外部被修改，而导致随之也修改了
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
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed && finished) {
        NSInteger index=[_controllers indexOfObject: pageViewController.viewControllers.firstObject];
        //respondsToSelector可以判断 某个对象是否含有某个方法
        if ([self.delegate respondsToSelector:@selector(scrollDisplayViewController:currentIndex:)] ) {
            [self.delegate scrollDisplayViewController:self currentIndex:index];
            self.currentPage = index;
        }
        
    }
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index=[_controllers indexOfObject:viewController];
    if (index > 0){
        return _controllers[index -1];
    }else{
        return nil;
    }
    
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index=[_controllers indexOfObject:viewController];
    if (index < _controllers.count - 1) {
        return _controllers[index +1];
    }else{
        return nil;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
