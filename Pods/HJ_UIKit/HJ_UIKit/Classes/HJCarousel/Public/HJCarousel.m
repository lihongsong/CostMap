//
//  HJCarousel.m
//  HJCarousel
//
//  Created by yoser on 2017/12/26.
//  Copyright © 2017年 yoser. All rights reserved.
//

#import "HJCarousel.h"
#import "HJCarouselCell.h"
#import "HJCarouselLayoutManager.h"
#import "UIView+HJCarouselTool.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import <objc/runtime.h>

#define HJSystemAnimateDuration 0.7

#define HJNoMovePoint CGPointMake(1, 1)

@interface HJCarousel()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *cycleView;

@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) UIView *pageControlView;

@property (strong, nonatomic) NSArray <UIView *> *pageControlItems;

@property (strong, nonatomic) NSArray <UIView *> *pageControlSelectedItems;

@property (strong, nonatomic) NSArray <UIView *> *pageControlNormalItems;

@property (assign, nonatomic) BOOL isPanGestureRecognizer;

@property (assign, nonatomic) BOOL isAutoAnimation;

@property (strong, nonatomic) NSMutableArray *layoutConstraints;

@property (assign, nonatomic) CGPoint moveStartOffSet;

@property (assign, nonatomic) CGPoint moveEndOffSet;

@property (assign, nonatomic) BOOL isAutoScroll;

@end

@implementation HJCarousel

+ (instancetype)carouselWithMaker:(HJCarouselMaker)maker{
    
    HJCarousel *carousel = [HJCarousel new];
    [carousel initialization];
    
    if(maker){
        maker(carousel);
    }
    
    [carousel setUpUI];
    [carousel setUpLayout];
    
    return carousel;
}

- (void)initialization{
    
    //    self.clipsToBounds = NO;
    self.carouselType = HJCarouselTypeLinear;
    self.sectionInset = UIEdgeInsetsZero;
    self.itemSize = CGSizeMake(1, 1);
    self.minimumItemSpacing = 0;
    self.animated = YES;
    self.shadowColor = nil;
    self.shadowDirection = HJCarouselShadowDirectionBottom;
    self.shadowWidth = 0.0f;
    self.duration = 1.0f;
    self.sourceType = HJCarouselContentTypeUnknow;
    self.enableLog = YES;
    self.scrollType = HJCarouselScrollTypeViscosit;
    
    self.pageControlColor = [UIColor whiteColor];
    self.pageControlRadius = 5.0f;
    self.pageControlBorderColor = [UIColor clearColor];
    self.pageControlItemSpacing = 5.0f;
    self.pageControlBorderWidth = 1.0f;
    self.pageControlSeletedColor = [UIColor blackColor];
    self.pageControlBottomSpacing = 5.0f;
    self.pageControlSeletedBorderColor = [UIColor clearColor];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self initialization];
        [self setUpUI];
        [self setUpLayout];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    
    
}

- (void)layerWillDraw:(CALayer *)layer {
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
}

- (void)setUpUI{
    
    [self clearConstraint];
    
    [self setUpCycleView];
    
    [self setUpLayout];
    
    [self setUpPageView];
}

/**
 初始化 循环滚动视图
 */
- (void)setUpCycleView{
    
    self.cycleView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:[UICollectionViewLayout new]];
    self.cycleView.clipsToBounds = NO;
    self.cycleView.backgroundView.clipsToBounds = NO;
    
    // 隐藏滚动条
    self.cycleView.showsVerticalScrollIndicator = NO;
    self.cycleView.showsHorizontalScrollIndicator = NO;
    
    // 如果没有设置 itemSize 就使用
    if(CGSizeEqualToSize(self.itemSize, CGSizeMake(1, 1))){
        self.itemSize = self.frame.size;
    }
    
    // 用来监听滚动结束手势
    [self.cycleView.panGestureRecognizer addTarget:self action:@selector(panGestureRecognizer:)];
    self.cycleView.delegate = self;
    self.cycleView.dataSource = self;
    self.cycleView.bounces = NO;
    self.cycleView.backgroundColor = [UIColor clearColor];
    self.cycleView.translatesAutoresizingMaskIntoConstraints = NO;
    self.cycleView.scrollEnabled = _source.count != 1;
    [self.cycleView registerClass:[HJCarouselCell cellClass]
       forCellWithReuseIdentifier:[HJCarouselCell cellID]];
    
    [self addSubview:self.cycleView];
    
    NSArray *hLayoutConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_cycleView]-0-|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:NSDictionaryOfVariableBindings(_cycleView)];
    NSArray *vLayoutConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_cycleView]-0-|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:NSDictionaryOfVariableBindings(_cycleView)];
    
    [self addConstraints:hLayoutConstraints];
    [self addConstraints:vLayoutConstraints];
    
    [self.layoutConstraints addObjectsFromArray:hLayoutConstraints];
    [self.layoutConstraints addObjectsFromArray:vLayoutConstraints];
}

/**
 初始化 页数控制视图
 */
- (void)setUpPageView{
    
    if(self.source.count == 0){
        return;
    }
    
    CGFloat pageControldiameter = _pageControlRadius * 2;
    CGFloat pageControlW = pageControldiameter + (_source.count - 1) * (pageControldiameter + _pageControlItemSpacing);
    CGFloat pageControlH = pageControldiameter;
    
    CGRect pageControlRect =  CGRectMake(0, 0, pageControlW, pageControlH);
    
    self.pageControlView = [[UIView alloc] initWithFrame:pageControlRect];
    self.pageControlView.backgroundColor = [UIColor clearColor];
    self.pageControlView.translatesAutoresizingMaskIntoConstraints = NO;
    self.pageControlView.hidden = _source.count == 1;
    
    [self addSubview:self.pageControlView];
    
    NSString *Hformat = [NSString stringWithFormat:@"H:[_pageControlView(==%.f)]",pageControlW];
    NSString *Vformat = [NSString stringWithFormat:@"V:[_pageControlView(==%.f)]-(%.f)-|",pageControlH,_pageControlBottomSpacing];
    
    NSArray *hLayoutConstraints = [NSLayoutConstraint constraintsWithVisualFormat:Hformat
                                                                          options:0
                                                                          metrics:nil
                                                                            views:NSDictionaryOfVariableBindings(_pageControlView)];
    NSArray *vLayoutConstraints = [NSLayoutConstraint constraintsWithVisualFormat:Vformat
                                                                          options:0
                                                                          metrics:nil
                                                                            views:NSDictionaryOfVariableBindings(_pageControlView)];
    NSLayoutConstraint *xCenterConstraint = [NSLayoutConstraint constraintWithItem:_pageControlView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1 constant:0];
    
    // 居中的约束用 VisualFormat 添加简直就是特么的噩梦
    [self addConstraints:hLayoutConstraints];
    [self addConstraints:vLayoutConstraints];
    [self addConstraint:xCenterConstraint];
    
    [self.layoutConstraints addObjectsFromArray:hLayoutConstraints];
    [self.layoutConstraints addObjectsFromArray:vLayoutConstraints];
    [self.layoutConstraints addObject:xCenterConstraint];
    
    [self addPageItems];
    
    // 默认选中第一个
    [self pageControlSelectedIndex:0];
}

- (void)clearConstraint{
    if(self.layoutConstraints.count > 0){
        [self removeConstraints:self.layoutConstraints];
        [self.layoutConstraints removeAllObjects];
    }
}

/**
 添加 pageControl 的子视图
 */
- (void)addPageItems{
    
    NSMutableArray *tempArray = [NSMutableArray array];
    NSMutableArray *tempNormalArray = [NSMutableArray array];
    NSMutableArray *tempSelectedArray = [NSMutableArray array];
    for (int i = 0 ; i < _source.count; i++) {
        
        UIView *pageItem = [[UIView alloc] init];
        CGFloat itemW = _pageControlRadius * 2;
        CGFloat itemH = itemW;
        CGFloat itemX = (itemW + _pageControlItemSpacing) * i;
        CGFloat itemY = 0;
        CGRect itemRect = CGRectMake(itemX, itemY, itemW, itemH);
        pageItem.frame = itemRect;
        pageItem.layer.cornerRadius = _pageControlRadius;
        pageItem.layer.borderColor = _pageControlColor.CGColor;
        pageItem.layer.borderWidth = _pageControlBorderWidth;
        pageItem.layer.masksToBounds = YES;
        pageItem.backgroundColor = _pageControlColor;
        
        if([self.dataSource respondsToSelector:@selector(carouselPageControlItemForNormal)]){
            UIView *view = [self.dataSource carouselPageControlItemForNormal];
            view.frame = itemRect;
            [self.pageControlView addSubview:view];
            [tempNormalArray addObject:view];
        }
        
        if([self.dataSource respondsToSelector:@selector(carouselPageControlItemForSeleted)]){
            UIView *view = [self.dataSource carouselPageControlItemForSeleted];
            view.frame = itemRect;
            [self.pageControlView addSubview:view];
            [tempSelectedArray addObject:view];
        }
        
        [self.pageControlView addSubview:pageItem];
        [tempArray addObject:pageItem];
    }
    
    self.pageControlItems = [tempArray copy];
    self.pageControlNormalItems = [tempNormalArray copy];
    self.pageControlSelectedItems = [tempSelectedArray copy];
}

/**
 选中 pageControl 的 item
 
 @param index 选中的位置
 */
- (void)pageControlSelectedIndex:(NSInteger)index{
    
    if([self showSourceCount] == 0){
        return;
    }
    
    NSInteger trueIndex = index;
    if(index >= _pageControlItems.count){
        NSAssert(1, @"当前的 pageControl 无法满足 Index 需求!");
        
        // 转化为范围内的 index
        trueIndex = index % _pageControlItems.count;
    }
    
    __weak __typeof(self) weakSelf = self;
    [self.pageControlItems enumerateObjectsUsingBlock:^(UIView * _Nonnull pageItem, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        pageItem.backgroundColor =
        (idx == trueIndex) ? weakSelf.pageControlSeletedColor : weakSelf.pageControlColor;
        pageItem.layer.borderColor =
        (idx == trueIndex) ? weakSelf.pageControlSeletedBorderColor.CGColor : weakSelf.pageControlBorderColor.CGColor;
        if(idx == trueIndex &&
           [strongSelf.dataSource respondsToSelector:@selector(carouselPageControlItemForSeleted)] &&
           [strongSelf.dataSource carouselPageControlItemForSeleted]){
            pageItem.hidden = YES;
        }else if (idx != trueIndex &&
                  [strongSelf.dataSource respondsToSelector:@selector(carouselPageControlItemForNormal)] &&
                  [strongSelf.dataSource carouselPageControlItemForNormal]){
            pageItem.hidden = YES;
        }else{
            pageItem.hidden = NO;
        }
    }];
    
    [self.pageControlSelectedItems enumerateObjectsUsingBlock:^(UIView * _Nonnull pageItem, NSUInteger idx, BOOL * _Nonnull stop) {
        pageItem.hidden = (idx != trueIndex);
    }];
    
    [self.pageControlNormalItems enumerateObjectsUsingBlock:^(UIView * _Nonnull pageItem, NSUInteger idx, BOOL * _Nonnull stop) {
        pageItem.hidden = (idx == trueIndex);
    }];
}

/**
 移除所有UI
 */
- (void)removeUI{
    
    if(_cycleView){
        _cycleView.delegate = nil;
        _cycleView.dataSource = nil;
        
        [_cycleView removeFromSuperview];
        _cycleView = nil;
    }
    
    if(_pageControlView){
        [_pageControlView removeFromSuperview];
        _pageControlView = nil;
    }
    
    if(_pageControlItems){
        _pageControlItems = [NSArray array];
    }
    
    if(_pageControlNormalItems){
        _pageControlNormalItems = [NSArray array];
    }
    
    if(_pageControlSelectedItems){
        _pageControlSelectedItems = [NSArray array];
    }
}

#pragma mark - Set

- (void)setSource:(NSArray <HJCarouselItemModel *> *)source {
    
    _source = source;
    
    BOOL flag = NO;
    for (int i = 0 ; i < source.count ; i++){
        HJCarouselItemModel *model = source[i];
        if (![model isKindOfClass:[HJCarouselItemModel class]]) {
            return;
        }
        if (HJCarouselContentTypeUnknow == model.sourceType &&
            HJCarouselContentTypeUnknow == self.sourceType) {
            flag = YES;
        }
    }
    
    if(![self isLayoutEnd] || flag){
        return;
    }
    
    [self refreshLayout];
}

- (void)setSourceType:(HJCarouselContentType)sourceType {
    _sourceType = sourceType;
    
    if(![self isLayoutEnd] || _sourceType == HJCarouselContentTypeUnknow){
        return;
    }
    [self refreshLayout];
}

- (void)setEnableLog:(BOOL)enableLog{
    _enableLog = enableLog;
    _log = enableLog;
}


/**
 刷新所有的UI布局
 */
- (void)refreshLayout{
    [self removeUI];
    [self setUpUI];
}

- (BOOL)isLayoutEnd{
    return (_cycleView != nil);
}

- (void)setUpLayout{
    
    UICollectionViewLayout *layout = [HJCarouselLayoutManager layoutWithType:_carouselType
                                                                    itemSize:_itemSize
                                                                 lineSpacing:_minimumItemSpacing
                                                                sectionInset:_sectionInset];
    [self.cycleView setCollectionViewLayout:layout];
    
    
    if(_source.count > 0){
        [self.cycleView reloadData];
        __weak __typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong __typeof(weakSelf) strongSelf = weakSelf;
                
                if (strongSelf.source.count == 1) {
                    CGFloat space = (strongSelf.cycleView.frame.size.width - strongSelf.itemSize.width) * 0.5;
                    [strongSelf.cycleView setContentOffset:CGPointMake(-space, 0)];
                    [strongSelf.cycleView setContentInset:UIEdgeInsetsMake(0, space, 0, 0)];
                } else {
                    [strongSelf scrollItemToCenter:strongSelf.cycleView atIndex:0 animated:NO];
                    [strongSelf.cycleView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
                }
            });
        });
    }
}

- (NSInteger)showSourceCount{
    return _source.count <= 1 ? _source.count : _source.count + 2;
}

#pragma mark - UICollectionView DataSource & Delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HJCarouselCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HJCarouselCell cellID]
                                                                     forIndexPath:indexPath];
    cell.imageView.layer.cornerRadius = _cornerRadius;
    cell.imageView.layer.borderWidth = _borderWidth;
    cell.imageView.layer.borderColor = _borderColor.CGColor;
    cell.imageView.layer.masksToBounds = YES;
    cell.shadowDirection = _shadowDirection;
    cell.shadowWidth = _shadowWidth;
    cell.shadowColor = _shadowColor;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self showSourceCount];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger indexValue = indexPath.row - 1;
    
    if(indexValue < 0){
        indexValue = _source.count - 1;
    }else if([self showSourceCount] - 1 == indexPath.row){
        indexValue = 0;
    }
    
    HJCarouselCell *hjCell = (HJCarouselCell *)cell;
    
    HJCarouselItemModel *model = _source[indexValue];
    
    if (![model isKindOfClass:[HJCarouselItemModel class]]) {
        return;
    }
    
    HJCarouselContentType sourceType = model.sourceType;
    
    UIImage *imagePlaceHolder = model.imagePlaceHolder;
    
    if (!imagePlaceHolder) {
        imagePlaceHolder = _imagePlaceHolder;
    }
    
    if (HJCarouselContentTypeUnknow == sourceType) {
        sourceType = self.sourceType;
    }
    
    if(sourceType == HJCarouselContentTypeUrl){
        
        if (model.source &&
            [model.source isKindOfClass:[NSString class]] &&
            [NSURL URLWithString:model.source]) {
            NSURL *imageUrl = [NSURL URLWithString:model.source];
            [hjCell.imageView sd_setImageWithURL:imageUrl placeholderImage:imagePlaceHolder];
        } else {
            HJCLog(@"图片资源加载失败");
            if(imagePlaceHolder) { hjCell.imageView.image = imagePlaceHolder; }
        }
    }else if (sourceType == HJCarouselContentTypeImage){
        
        UIImage *image = (UIImage *)model.source;
        if(!image || ![image isKindOfClass:[UIImage class]]){
            HJCLog(@"图片资源加载失败");
            if(imagePlaceHolder) { hjCell.imageView.image = imagePlaceHolder; }
        }else{
            hjCell.imageView.image = image;
        }
    }else if (sourceType == HJCarouselContentTypeImageName){
        
        NSString *imageName = (NSString *)model.source;
        UIImage *image = [UIImage imageNamed:imageName];
        if(!image){
            HJCLog(@"图片资源加载失败");
            if(imagePlaceHolder) { hjCell.imageView.image = imagePlaceHolder; }
        }else{
            hjCell.imageView.image = image;
        }
    }
    
    if([self.delegate respondsToSelector:@selector(carouselWillDisplayItem:atIndex:)]){
        [self.delegate carouselWillDisplayItem:(HJCarouselCell *)cell atIndex:indexValue];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger index = 0;
    if(indexPath.row == [self showSourceCount] - 1){
        index = 0;
    }else if (indexPath.row == 0){
        index = _source.count - 1;
    }else{
        index = indexPath.row - 1;
    }
    
    if([self.delegate respondsToSelector:@selector(carouselDidSelectedItem:atIndex:)]){
        HJCarouselCell *cell = (HJCarouselCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
        [self.delegate carouselDidSelectedItem:cell atIndex:index];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(CGSizeEqualToSize(scrollView.contentSize, CGSizeZero) || ![self enoughScroll]){
        return;
    }
    
    // 更新 pageControl
    NSInteger indexValue = [self indexByContentOffSet];
    [self pageControlSelectedIndex:indexValue];
    
    if([self.delegate respondsToSelector:@selector(carouselDidDisplayItemAtIndex:)]){
        [self.delegate carouselDidDisplayItemAtIndex:indexValue];
    }
    
    CGFloat contentOffSetX = scrollView.contentOffset.x;
    CGFloat contentOffSetY = scrollView.contentOffset.y;
    
    // 当滚动到第一个 item 一半的时候开始偷偷修改 contentOffSet
    CGFloat firstHalfScreen = _itemSize.width + _minimumItemSpacing * 0.5 - scrollView.hjc_width * 0.5;
    CGFloat lastHalfScreen = scrollView.contentSize.width - (_itemSize.width +
                                                             _minimumItemSpacing * 0.5 +
                                                             _cycleView.hjc_width * 0.5);
    
    if(contentOffSetX < firstHalfScreen){
        CGPoint lastWidthPoint = CGPointMake(lastHalfScreen - 1, contentOffSetY);
        [scrollView setContentOffset:lastWidthPoint animated:NO];
        
        if(!_isPanGestureRecognizer){
            [UIView animateWithDuration:0.1 animations:^{
                [self scrollCurrentItemToCenter:scrollView animated:NO];
            }];
        }
    }
    
    // 当滚动到最后一个 item 一半的时候开始偷偷修改 contentOffSet
    if(contentOffSetX > lastHalfScreen){
        CGPoint firstWidthPoint = CGPointMake(firstHalfScreen + 1, contentOffSetY);
        [scrollView setContentOffset:firstWidthPoint animated:NO];
        
        if(!_isPanGestureRecognizer){
            [UIView animateWithDuration:0.1 animations:^{
                [self scrollCurrentItemToCenter:scrollView animated:NO];
            }];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self carouselScrollDidEndDecelerating];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self carouselScrollGestureEnd:HJNoMovePoint];
}

#pragma mark - Auto
- (void)run {
    
    if(!self.superview){
        NSAssert(NO, @"你需要把 carousel 添加到视图上");
        return;
    }
    
    if(_source.count == 1){
        return;
    }
    
    [self startTimer];
}

- (void)stop{
    [self endTimer];
}

- (void)step{
    
    if(_isPanGestureRecognizer || _isAutoAnimation){
        return;
    }
    
    if(_source.count == 1){
        return;
    }
    
    // 当前所在的下标
    NSInteger currentIndex = [self indexByContentOffSet];
    
    // 下一个位置的下标
    NSInteger nextIndex = currentIndex + 1;
    
    // 滚动处理
    [self scrollToPage:nextIndex];
}

- (void)scrollToPage:(NSInteger)pageNumber{
    
    // 下一个位置所移动到的位置
    CGPoint contentOffSet = [self contentOffSetByIndex:pageNumber];
    
    // 开始自动滚动处理
    [self.cycleView setContentOffset:contentOffSet animated:_animated];
}

- (void)startTimer{
    
    if(![self enoughScroll]){
        return;
    }
    if (_timer == nil) {
        //_duration
        _timer = [NSTimer scheduledTimerWithTimeInterval:_duration target:self selector:@selector(step) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)endTimer{
    
    if(_timer){
        
        // 取消之前的step操作
        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(step) object:nil];
        
        [_timer invalidate];
        
        _timer = nil;
    }
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    
    // 如果是被移除掉的
    if(self.superview){
        [self endTimer];
    }
}

#pragma mark - Tool

- (void)setAutoAnimateNO {
    self.isAutoAnimation = NO;
}

- (void)setAutoAnimateYes {
    self.isAutoAnimation = YES;
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)pan{
    
    switch (pan.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            
            [self setAutoAnimateYes];
            _isPanGestureRecognizer = NO;
            [self performSelector:@selector(setAutoAnimateNO) withObject:nil afterDelay:3.0f];
            
            CGPoint movePoint = [pan translationInView:self.cycleView];
            
            [self carouselScrollGestureEnd:movePoint];
        }
            break;
        case UIGestureRecognizerStateBegan: {
            
            [[self class] cancelPreviousPerformRequestsWithTarget:self
                                                         selector:@selector(setAutoAnimateNO)
                                                           object:nil];
            [self setAutoAnimateYes];
            self.isPanGestureRecognizer = YES;
            [self carouselScrollGestureBegan];
            
        }
            break;
            
        case UIGestureRecognizerStateFailed:{
            
        }
            break;
            
        default:
            break;
    }
}

- (void)carouselScrollDidEndDecelerating {
    
    switch (_scrollType) {
        case HJCarouselScrollTypeViscosit:
            [self carouselScrollViscositDidEndDecelerating];
            break;
        case HJCarouselScrollTypeInertia:
            [self carouselScrollInertiaDidEndDecelerating];
            break;
        default:
            break;
    }
}

- (void)carouselScrollGestureEnd:(CGPoint)movePoint {
    
    switch (_scrollType) {
        case HJCarouselScrollTypeViscosit:
            [self carouselScrollViscositGestureEnd];
            break;
        case HJCarouselScrollTypeInertia:
            [self carouselScrollInertiaGestureEnd:movePoint];
            break;
        default:
            break;
    }
}

- (void)carouselScrollGestureBegan {
    
    switch (_scrollType) {
        case HJCarouselScrollTypeInertia:
            [self carouselScrollInertiaGestureBegan];
            break;
        case HJCarouselScrollTypeViscosit:
            [self carouselScrollInertiaGestureBegan];
            break;
        default:
            break;
    }
}

#pragma mark - 粘性滚动
- (void)carouselScrollViscositGestureBegan {
    
}

- (void)carouselScrollViscositGestureEnd {
    [self scrollCurrentItemToCenter:_cycleView animated:_animated];
}

- (void)carouselScrollViscositDidEndDecelerating {
    [self scrollCurrentItemToCenter:_cycleView animated:_animated];
}

static NSInteger scrollFromIndex;

#pragma mark - 惯性滚动
/**
 惯性滚动
 */
- (void)carouselScrollInertiaGestureBegan {
    
    // 标记当前位置 用于计算滚动方向
    scrollFromIndex = [self indexByContentOffSet];
}

/**
 惯性滚动
 */
- (void)carouselScrollInertiaGestureEnd:(CGPoint)movePoint {
    
    if (CGPointEqualToPoint(movePoint, CGPointZero)) {
        NSInteger currentIndex = [self indexByContentOffSet];
        [self scrollItemToCenter:_cycleView atIndex:currentIndex animated:YES];
        return;
    }
    
    if (CGPointEqualToPoint(movePoint, HJNoMovePoint)) {
        return;
    }
    
    // 标记是否滚向下一个 item
    BOOL isNext = NO;
    
    if (_scrollDirection == HJCarouselDirectionScrollDirectionVertical) {
        // 滚动大致方向 -> 垂直
        isNext = movePoint.y < 0;
    } else {
        // 滚动大致方向 -> 水平
        isNext = movePoint.x < 0;
        
        // 当前所在的下标
        NSInteger currentIndex = [self indexByContentOffSet];
        
        if (currentIndex != scrollFromIndex && scrollFromIndex != NSNotFound) {
            
            NSInteger currentIndex = [self indexByContentOffSet];
            [self scrollItemToCenter:_cycleView atIndex:currentIndex animated:YES];
            return;
        }
        
        NSInteger nextIndex;
        
        if (isNext) {
            
            // 下一个位置的下标
            nextIndex = currentIndex + 1;
            
        } else {
            
            // 下一个位置的下标
            nextIndex = currentIndex - 1;
        }
        
        // 滚动处理
        [self scrollToPage:nextIndex];
        
        scrollFromIndex = NSNotFound;
    }
}

/**
 惯性滚动
 */
- (void)carouselScrollInertiaDidEndDecelerating {
    [self scrollCurrentItemToCenter:_cycleView animated:YES];
}

- (BOOL)enoughScroll{
    
    if(self.itemSize.width * self.source.count < self.frame.size.width + self.itemSize.width * 0.5){
        return NO;
    }
    return YES;
}

- (NSInteger)indexByContentOffSet{
    
    NSInteger index = 0;
    
    if (_scrollDirection == HJCarouselDirectionScrollDirectionHorizontal){
        // 水平滚动
        CGFloat currentOffsetX = self.cycleView.contentOffset.x;
        
        // 一个单位的间隔
        CGFloat unitWitdh = self.itemSize.width + self.minimumItemSpacing;
        
        index = (currentOffsetX + _cycleView.hjc_width * 0.5 + self.minimumItemSpacing * 0.5) / unitWitdh;
        
        if(index == [self showSourceCount] - 1){
            index = 1;
        }
    }else{
        // 垂直滚动
        CGFloat currentOffsetY = self.cycleView.contentOffset.y;
        
        // 一个单位的间隔
        CGFloat unitHeight = self.itemSize.height + self.minimumItemSpacing;
        
        index = (currentOffsetY + _cycleView.hjc_height * 0.5 + self.minimumItemSpacing * 0.5) / unitHeight;
        
        if(index == [self showSourceCount] - 1){
            index = 1;
        }
        
    }
    return index - 1;
}

- (CGPoint)contentOffSetByIndex:(NSInteger)index{
    
    CGPoint offset = CGPointZero;
    
    if(_scrollDirection == HJCarouselDirectionScrollDirectionHorizontal){
        // 水平滚动
        CGFloat unitWitdh = _itemSize.width + _minimumItemSpacing;
        CGFloat tempX = unitWitdh + self.itemSize.width * 0.5 - self.cycleView.hjc_width * 0.5;
        CGFloat offsetX = unitWitdh * index + tempX;
        offset = CGPointMake(offsetX, 0);
    }else{
        // 垂直滚动
        CGFloat unitWitdh = _itemSize.height + _minimumItemSpacing;
        CGFloat tempY = unitWitdh + self.itemSize.height * 0.5 - self.cycleView.hjc_height * 0.5;
        CGFloat offsetY = unitWitdh * index + tempY;
        offset = CGPointMake(0,offsetY);
    }
    
    return offset;
}

- (BOOL)isRun{
    return !!_timer;
}

- (NSMutableArray *)layoutConstraints{
    if(!_layoutConstraints){
        _layoutConstraints = [NSMutableArray array];
    }
    return _layoutConstraints;
}

static BOOL _log = NO;

void HJCLog(NSString * _Nonnull format, ...){
    if(_log){
        va_list list;
        va_start(list, format);
        NSLogv(format, list);
    }
}

- (void)scrollItemToCenter:(UIScrollView *)scrollView atIndex:(NSInteger)index animated:(BOOL)animated{
    
    CGPoint centerOffset = [self contentOffSetByIndex:index];
    
    [scrollView setContentOffset:centerOffset animated:animated];
}

- (void)scrollCurrentItemToCenter:(UIScrollView *)scrollView animated:(BOOL)animated{
    
    NSInteger currentIndex = [self indexByContentOffSet];
    
    [self scrollItemToCenter:scrollView atIndex:currentIndex animated:animated];
}

@end
