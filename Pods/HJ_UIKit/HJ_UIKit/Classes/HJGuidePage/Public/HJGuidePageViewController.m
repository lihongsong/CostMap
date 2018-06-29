//
//  HJGuidePageViewController.m
//  HJNetWorkingDemo
//
//  Created by 姜奎 on 2017/12/17.
//  Copyright © 2017年 姜奎. All rights reserved.
//

#import "HJGuidePageViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImage+GIF.h"
#import "UIImageView+WebCache.h"
#import "HJGuidePageWindow.h"
#import "HJGuidePageWKScriptMessageHandler.h"
#import "HJGuidePageViewController+WKWebDelegate.h"
@interface HJCollectionViewCell : UICollectionViewCell
/**image*/
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *centerBtn;
@end

@implementation HJCollectionViewCell
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _imageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}
@end

@interface HJGuidePageViewController ()
/**计时时间*/
@property (assign) NSInteger timeMax;
/**计时时间*/
@property (nonatomic, assign) NSInteger timeDelay;
/**是否纵向滚动*/
@property (nonatomic,assign) BOOL scrollDirectionVertical;//default is NO
/**展示图片数组*/
@property (nonatomic, strong) NSMutableArray *imageArr;
/**展示图片数组*/
@property (nonatomic, assign) BOOL isURL;
/**展示图片数组*/
@property (nonatomic, assign) BOOL isGif;
/**collection*/
@property (nonatomic, strong) UICollectionView *collectionView;
/**web*/
@property (nonatomic, strong) WKWebView *webView;
/**avUrl*/
@property (nonatomic, strong) NSURL *avUrl;
/**AV*/
@property (nonatomic, strong) AVAsset *avAset;
/**avUrl*/
@property (nonatomic, assign) CGRect avFrame;
/**Btn*/
@property (nonatomic, strong) UIButton *countdownBtn;
/**Btn*/
@property (nonatomic, strong) UIButton *centerBtn;
/***/
@property (nonatomic,assign) BOOL hasCenterBtn;
/***/
@property (nonatomic,assign) HJGuiPageCenterBtnPositionType centerBtnPositionType;
/**btn默认按钮*/
@property (nonatomic, strong) NSString *btnTitle;
/**秒数后面的文字*/
@property (nonatomic, strong) NSString *timerTitle;
/**是否隐藏立即跳过文字提示**/
@property (nonatomic, assign) BOOL isHiddenTimerTitle;
/**URL*/
@property (nonatomic, strong) NSURL *webUrl;
/**custom*/
@property (nonatomic, strong) UIView *customView;
/**backGroundImage*/
@property (nonatomic, strong) UIImageView *backGroundImageView;
@property (nonatomic, strong) CABasicAnimation *animate;
/**Timer*/
@property (nonatomic, strong) NSTimer *timer;
/**AVplayer*/
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
/**图片点击事件*/
@property (nonatomic,copy) ClickImageActionBlock clickImageActionBlock;
/**Description*/
@property (nonatomic,copy) BtnActionBlock countdownBtnActionBlock;
/**Description*/
@property (nonatomic,copy) BtnActionBlock centerBtnActionBlock;
/**app启动状态*/
//@property (nonatomic,assign) GuidePageAPPLaunchStateOptions options;
@property(nonatomic,copy) HJGuidePageImageBlock backgroundImageBlock;

@property(nonatomic,strong) UIImageView *defaultImageView;

@end

@implementation HJGuidePageViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.defaultImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
}
- (void)reloadData{
    [self.view addSubview:self.customView];
    self.view.backgroundColor = [UIColor clearColor];
    [self.customView addSubview:self.backGroundImageView];
    if (_collectionView) {
        [self.customView addSubview:self.collectionView];
        [self.collectionView reloadData];
    }
    if (_webView&&self.webUrl) [self.customView addSubview:self.webView];
    if (!_countdownBtn) {
        self.setCountdownBtnBlock(^(UIButton *btn) {
            btn.layer.cornerRadius = btn.frame.size.height/2;
        });
    }
    if (self.avAset) {
        [self addAVAset];
    }else{
        if (self.hasCenterBtn&&self.centerBtnPositionType == HJGuiPageCenterBtnPositionInCustomView)  [self.customView addSubview:self.centerBtn];
        [self.customView addSubview:self.countdownBtn];
    }
    [HJGuidePageWindow  show];
    if (!(self.imageArr.count>0 || self.webUrl.absoluteString.length>0 || self.avAset)) [self addTimer];

}

-(void)addAVAset{
    [self.avAset loadValuesAsynchronouslyForKeys:@[@"tracks"] completionHandler:^{
        AVKeyValueStatus stacks=[self.avAset statusOfValueForKey:@"tracks" error:nil];
        if (stacks==AVKeyValueStatusLoaded) {
            [self avAsetAddCenterBtn:YES];
        }else if (stacks==AVKeyValueStatusFailed||stacks==AVKeyValueStatusCancelled){
            [self avAsetAddCenterBtn:NO];
        }
    }];
}
-(void)avAsetAddCenterBtn:(BOOL)startAV{
    if (startAV) {
        AVPlayerItem*item = [AVPlayerItem playerItemWithAsset:self.avAset];
        AVPlayer*player = [[AVPlayer alloc]initWithPlayerItem:item];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
        self.playerLayer.frame = self.avFrame;
        [self.customView.layer addSublayer:self.playerLayer];
        [player play];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.backGroundImageView.hidden = startAV;
        if (self.hasCenterBtn&&self.centerBtnPositionType == HJGuiPageCenterBtnPositionInCustomView)  [self.customView addSubview:self.centerBtn];
        [self.customView addSubview:self.countdownBtn];
        [self addTimer];
    });
}
- (void)addTimer{
    if (!_timer) {
        
        NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:self.timeDelay];
        _timer = [[NSTimer alloc]initWithFireDate:fireDate interval:1 target:self selector:@selector(doSomething:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr=[NSMutableArray arrayWithCapacity:0];
    }
    return _imageArr;
}

- (UIView *)customView{
    if (!_customView) {
        _customView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _customView.backgroundColor = [UIColor clearColor];
        self.defaultImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        self.defaultImageView.image = [UIImage imageNamed:HJGetLaunchImageName()];
        [_customView addSubview:self.defaultImageView];
    }
    return _customView;
}
- (UIButton *)countdownBtn{
    if (!_countdownBtn) {
        _countdownBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _countdownBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        [_countdownBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        _countdownBtn.frame = CGRectMake(self.view.bounds.size.width-100, 64, 66, 28);
        [_countdownBtn setTitle:@"立即前往" forState:(UIControlStateNormal)];
        _countdownBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_countdownBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _countdownBtn.clipsToBounds = YES;
        //_countdownBtn.layer.borderWidth = 0.5;
        //_countdownBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _countdownBtn.layer.cornerRadius = 14;
        [_countdownBtn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        _countdownBtn.hidden = _isHiddenTimerTitle;
        
    }
    return _countdownBtn;
}

- (void)setIsHiddenTimerTitle:(BOOL)isHiddenTimerTitle
{
    self.countdownBtn.hidden = isHiddenTimerTitle;
    _isHiddenTimerTitle = isHiddenTimerTitle;
    if (_isHiddenTimerTitle == NO) {
        if (self.timeMax > 0) {
            //[self.countdownBtn setTitle:nil forState:UIControlStateNormal];
            [self.countdownBtn setTitle:[NSString stringWithFormat:@"%ds跳过",self.timeMax] forState:nil];
        }
    }
}

- (UIButton *)centerBtn{
    if (!_centerBtn) {
        _centerBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _centerBtn.backgroundColor = [UIColor clearColor];
        [_centerBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        _centerBtn.frame = CGRectMake(0, self.view.bounds.size.height-120, self.view.bounds.size.width, 120);
        [_centerBtn setTitle:@"立即前往" forState:(UIControlStateNormal)];
        [_centerBtn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _centerBtn;
}

- (WKWebView *)webView{
    if (!_webView) {
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        WKWebViewConfiguration* configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = userContentController;
        HJGuidePageWKScriptMessageHandler* handler = [[HJGuidePageWKScriptMessageHandler alloc]initWith:self];
        [configuration.userContentController addScriptMessageHandler:handler name:kGuidePageWKScriptMessageHandler];
        _webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:configuration];
        _webView.UIDelegate=self;
        _webView.navigationDelegate=self;
        [_webView setMultipleTouchEnabled:YES];
        [_webView setAutoresizesSubviews:YES];
        _webView.scrollView.bounces = NO;
        _webView.hidden = YES;
        [_webView.scrollView setAlwaysBounceVertical:YES];
    }
    return _webView;
}

- (UIImageView *)backGroundImageView{
    if (!_backGroundImageView) {
        CGRect bgImageFrame = self.view.bounds;
        bgImageFrame.size.height = bgImageFrame.size.height - 125;
        _backGroundImageView = [[UIImageView alloc]initWithFrame:bgImageFrame];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundImageClicked)];
        tap.numberOfTapsRequired = 1;
        _backGroundImageView.userInteractionEnabled = YES;
        [_backGroundImageView addGestureRecognizer:tap];
    }
    return _backGroundImageView;
}

- (void)backgroundImageClicked
{
    if (self.backgroundImageBlock == nil) {
        
    }else{
        self.backgroundImageBlock();
    }
}

- (BackGroundImageBlock)setBackGroundImage{
    return ^(NSString *url,BOOL isURL,BOOL isGif,HJGuidePageImageBlock block){
        self.backgroundImageBlock = block;
        self.isURL = isURL;
        self.isGif = isGif;
        if (!url) return self;
        if(self.isURL){
            HJGuidePageDlog(@"网络图片");
            if (self.isGif) {
                [self.backGroundImageView setImage:[UIImage imageNamed:HJGetLaunchImageName()]];
                [SDWebImageManager.sharedManager loadImageWithURL:[NSURL URLWithString:url] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                    [self.backGroundImageView setImage:[UIImage sd_animatedGIFWithData:data]];
                }];
            }else{
                __block UIImage *image = [[SDImageCache sharedImageCache]imageFromCacheForKey:url];
                __block BOOL hasLoadImage;
                [self.backGroundImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    hasLoadImage = YES;
                }];
                if (image == nil) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if (hasLoadImage == NO) {
                            [HJGuidePageWindow dismiss];
                        }else{
                            image = [[SDImageCache sharedImageCache]imageFromCacheForKey:url];
                            self.backGroundImageView.image = image;
                        }
                    });
                }
            }
        }else if (self.isGif){
            UIImage * image= nil;
            NSString *path = [[NSBundle mainBundle] pathForResource:url ofType:@"gif"];
            NSData* data = [NSData dataWithContentsOfFile:path];
            if (data) image = [UIImage sd_animatedGIFWithData:data];
            HJGuidePageDlog(@"BackGround本地gif");
            [self.backGroundImageView setImage:image?image:[UIImage imageNamed:HJGetLaunchImageName()]];
        }else{
            self.backGroundImageView.frame = [UIScreen mainScreen].bounds;
            [self.backGroundImageView setImage:[UIImage imageNamed:HJGetLaunchImageName()]];
        }
        return self;
    };
}

- (TimerBlock)setTimer{
    return ^(NSInteger timeMax,NSInteger timeDelay,NSString* timerTitle,BOOL isHiddenTimerTitle){
        self.timeMax = timeMax;
        self.timeDelay = timeDelay;
        self.timerTitle = timerTitle;
        self.isHiddenTimerTitle = isHiddenTimerTitle;
        return self;
    };
}

- (SetBtnBlock)setCountdownBtnBlock{
    return ^(UploadBtnBlock block){
        block(self.countdownBtn);
        return self;
    };
}

- (SetCenterBtnBlock)setCenterBtnBlock{
    return ^(BOOL hasCenterBtn, HJGuiPageCenterBtnPositionType centerBtnPositionType, UploadBtnBlock block){
        self.hasCenterBtn = hasCenterBtn;
        self.centerBtnPositionType = centerBtnPositionType;
        block(self.centerBtn);
        return self;
    };
}

- (ScrollViewStyleBlock)setScrollViewStyle{
    return ^(UICollectionViewFlowLayout* layout,CGRect frame,CGSize itemSize,BOOL scrollDirectionVertical){
        if (!layout) {
            layout = [[UICollectionViewFlowLayout alloc]init];
            self.scrollDirectionVertical = scrollDirectionVertical;
            layout.scrollDirection = scrollDirectionVertical?UICollectionViewScrollDirectionVertical:UICollectionViewScrollDirectionHorizontal;
            if (itemSize.height != 0.0&&itemSize.width != 0.0) {
                layout.itemSize = itemSize;
            }else if(frame.size.height != 0.0&&frame.size.width != 0.0){
                layout.itemSize = frame.size;
            }else{
                layout.itemSize = self.customView.bounds.size;
            }
            layout.minimumInteritemSpacing = 0.0;
            layout.minimumLineSpacing = 0.0;
        }
        if (frame.size.height != 0.0&&frame.size.width != 0.0) {
            _collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
        }else{
            _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        }
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_collectionView  registerClass:[HJCollectionViewCell class] forCellWithReuseIdentifier:@"HJCollectionViewCell"];
        return self;
    };
}
-(ImageArrBlock)setImageArr{
    return ^(NSArray *imageArr,BOOL isURL,BOOL isGif){
        self.imageArr = [imageArr mutableCopy];
        self.isURL = isURL;
        self.isGif = isGif;
        if (!_collectionView) self.setScrollViewStyle(nil, self.view.bounds, self.view.bounds.size, NO);
        return self;
    };
}
- (WKWebViewBlock)setWKWebView{
    return ^(CGRect frame, NSURL *url){
        if (url) {
            self.webUrl = url;
            if(frame.size.height != 0.0&&frame.size.width != 0.0){
                self.webView.frame = frame;
            }else{
                self.webView.frame = self.view.bounds;
            }
            self.backGroundImageView.hidden = NO;
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [self.webView loadRequest:request];
        }
        return self;
    };
}
- (AVPlayerBlock)setAVPlayer{
    return ^(CGRect frame, NSURL *url){
        self.avUrl = url;
        if (url.absoluteString)  self.avAset = [AVAsset assetWithURL:url];
        if(frame.size.height != 0.0&&frame.size.width != 0.0){
            self.avFrame = frame;
        }else{
            self.avFrame = self.view.bounds;
        }
        return self;
    };
}
-(CustomViewBlock)setCustomView{
    return ^(CreateViewBlock block){
        _customView = block();
        return self;
    };
}
- (CustomViewAnimateWhenHiddenBlock)setCustomViewAnimateWhenHiddenBlock{
    return ^(CreateAnimateBlock block){
        self.animate = block();
        return self;
    };
}
-(SetClickImageActionBlock)setClickImageActionBlock{
    return ^(ClickImageActionBlock block){
        self.clickImageActionBlock = block;
        return self;
    };
}
-(SetBtnActionBlock)setCountdownBtnActionBlock{
    return ^(BtnActionBlock block){
        self.countdownBtnActionBlock = block;
        return self;
    };
}
- (SetBtnActionBlock)setCenterBtnActionBlock{
    return ^(BtnActionBlock block){
        self.centerBtnActionBlock = block;
        return self;
    };
}
-(SetAnimateFinishedBlock)setAnimateFinishedBlock{
    return ^(AnimateFinishedBlock block){
        _animateFinishedBlock = block;
        return self;
    };
}

#pragma mark -- UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HJCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HJCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    if(self.isURL&&self.imageArr.count>indexPath.item&&self.imageArr[indexPath.item]){
        HJGuidePageDlog(@"网络图片");
        if (self.isGif) {
            [cell.imageView setImage:[UIImage imageNamed:HJGetLaunchImageName()]];
            [SDWebImageManager.sharedManager loadImageWithURL:[NSURL URLWithString:self.imageArr[indexPath.item]] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                [cell.imageView setImage:[UIImage sd_animatedGIFWithData:data]];
            }];
        }else{
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageArr[indexPath.item]] placeholderImage:[UIImage imageNamed:HJGetLaunchImageName()]];
        }
    }else if (self.isGif&&self.imageArr.count>indexPath.item&&self.imageArr[indexPath.item]){
        UIImage * image= nil;
        NSString *path = [[NSBundle mainBundle] pathForResource:self.imageArr[indexPath.item] ofType:@"gif"];
        NSData* data = [NSData dataWithContentsOfFile:path];
        if (data) image = [UIImage sd_animatedGIFWithData:data];
        HJGuidePageDlog(@"本地gif");
        [cell.imageView setImage:image?image:[UIImage imageNamed:HJGetLaunchImageName()]];
        
    }else if(self.imageArr.count>indexPath.item&&self.imageArr[indexPath.item]){
        HJGuidePageDlog(@"本地图片");
        UIImage* image = [UIImage imageNamed:self.imageArr[indexPath.item]];
        [cell.imageView setImage:image?image:[UIImage imageNamed:HJGetLaunchImageName()]];
    }else{
        [cell.imageView setImage:[UIImage imageNamed:HJGetLaunchImageName()]];
    }
    if (self.hasCenterBtn&&self.centerBtnPositionType == HJGuiPageCenterBtnPositionInCollectionViewCell) {
        if (self.imageArr.count == indexPath.item+1) {
            [cell.contentView addSubview:self.centerBtn];
            cell.centerBtn = self.centerBtn;
            cell.centerBtn.hidden = NO;
        }else{
            cell.centerBtn.hidden = YES;
        }
    }
    if (self.imageArr.count==1)[self scrollViewDidScroll:collectionView];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.clickImageActionBlock) self.clickImageActionBlock(indexPath.item, self.imageArr[indexPath.item],nil);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ((!self.scrollDirectionVertical)&&scrollView.contentOffset.x == scrollView.contentSize.width-scrollView.frame.size.width) {
        [self addTimer];
    }else if (self.scrollDirectionVertical&&scrollView.contentOffset.y == scrollView.contentSize.height-scrollView.frame.size.height) {
        [self addTimer];
    }
}

#pragma mark -1. WKNavigationDelegate
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    HJGuidePageDlog(@"加载成功");
    self.webView.hidden =NO;
    if (self.hasCenterBtn&&self.centerBtnPositionType == HJGuiPageCenterBtnPositionInWebView) [self.customView addSubview:self.centerBtn];
    [self addTimer];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    HJGuidePageDlog(@"加载失败");
    self.backGroundImageView.hidden = NO;
    if (self.hasCenterBtn&&self.centerBtnPositionType == HJGuiPageCenterBtnPositionInWebView) [self.customView addSubview:self.centerBtn];
    [self addTimer];
}

#pragma mark -- TimerDelegate
- (void)doSomething:(NSTimer*)timer{
    

    if (self.timeMax==0) {
        [self btnAction:nil];
        return;
    }else {
        if (self.timerTitle) {
            NSRange range = [self.timerTitle rangeOfString:@"?"];
            if (range.length) {
                NSMutableString* timerStr=[[NSMutableString alloc]initWithString:self.timerTitle];
                [timerStr replaceCharactersInRange:range withString:[NSString stringWithFormat:@"%d",(int)self.timeMax]];
                [self.countdownBtn setTitle:timerStr forState:(UIControlStateNormal)];
            }else{
                [self.countdownBtn setTitle:[NSString stringWithFormat:@"%d%@",(int)self.timeMax,self.timerTitle] forState:(UIControlStateNormal)];
            }
        }
    }
    self.countdownBtn.hidden=_isHiddenTimerTitle;
    self.timeMax--;
}

- (void)btnAction:(UIButton* )btn{
    [self invalidate];
    if (btn&&(btn == _countdownBtn)&&self.countdownBtnActionBlock) {
        self.countdownBtnActionBlock(nil);
    }else if (btn&&(btn == _centerBtn)&&self.centerBtnActionBlock) {
        self.centerBtnActionBlock(nil);
    }
    if (_animate)[self.customView.layer addAnimation:_animate forKey:@"animate"];
    [HJGuidePageWindow dismiss];
}

- (void)invalidate {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)dealloc{
    if (_webView) [_webView.configuration.userContentController removeScriptMessageHandlerForName:kGuidePageWKScriptMessageHandler];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

