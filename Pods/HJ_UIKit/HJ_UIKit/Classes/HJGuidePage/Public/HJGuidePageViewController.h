//
//  HJGuidePageViewController.h
//  HJNetWorkingDemo
//
//  Created by 姜奎 on 2017/12/17.
//  Copyright © 2017年 姜奎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "HJGuidePageUtility.h"

typedef NS_ENUM(NSInteger, HJGuiPageCenterBtnPositionType) {
    HJGuiPageCenterBtnPositionInCustomView = 1,
    HJGuiPageCenterBtnPositionInWebView,
    HJGuiPageCenterBtnPositionInCollectionViewCell
};
@class HJGuidePageViewController;
typedef void(^HJGuidePageImageBlock)(void);
typedef HJGuidePageViewController *(^BackGroundImageBlock)(NSString *url,BOOL isURL,BOOL isGif,HJGuidePageImageBlock backgroundImageBlock);

typedef HJGuidePageViewController *(^TimerBlock)(NSInteger timeMax,NSInteger timeDelay,NSString* timerTitle,BOOL isHiddenTitle);
typedef HJGuidePageViewController *(^ImageArrBlock)(NSArray *imageArr,BOOL isURL,BOOL isGif);
typedef HJGuidePageViewController *(^ScrollViewStyleBlock)(UICollectionViewFlowLayout *layout,CGRect frame,CGSize itemSize,BOOL scrollDirectionVertical);
typedef HJGuidePageViewController *(^WKWebViewBlock)(CGRect frame, NSURL *url);
typedef HJGuidePageViewController *(^AVPlayerBlock)(CGRect frame, NSURL *url);

typedef void (^UploadBtnBlock)(UIButton* btn);
typedef HJGuidePageViewController *(^SetBtnBlock)(UploadBtnBlock block);
typedef HJGuidePageViewController *(^SetCenterBtnBlock)(BOOL hasCenterBtn, HJGuiPageCenterBtnPositionType centerBtnPositionType, UploadBtnBlock block);
typedef UIView*(^CreateViewBlock)(void);
typedef HJGuidePageViewController *(^CustomViewBlock)(CreateViewBlock block);

typedef CABasicAnimation*(^CreateAnimateBlock)(void);
typedef HJGuidePageViewController *(^CustomViewAnimateWhenHiddenBlock)(CreateAnimateBlock block);

typedef void(^ClickImageActionBlock)(NSInteger selectIndex,NSString *selectImageStr ,id info);
typedef HJGuidePageViewController *(^SetClickImageActionBlock)(ClickImageActionBlock block);

typedef void(^BtnActionBlock)(id info);
typedef HJGuidePageViewController *(^SetBtnActionBlock)(BtnActionBlock block);

typedef void(^AnimateFinishedBlock)(id info);
typedef HJGuidePageViewController *(^SetAnimateFinishedBlock)(AnimateFinishedBlock block);

typedef HJGuidePageViewController *(^SetGuidePageAPPLaunchStateOptions)(GuidePageAPPLaunchStateOptions block);
@interface HJGuidePageViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WKUIDelegate,WKNavigationDelegate>

/**设置加载图片／gif相关属性
 imageArr 图片数组
 isURL 是否为链接
 isGif 是否为Gif
 */
@property (nonatomic,copy,readonly) BackGroundImageBlock setBackGroundImage;

/**设置计时器相关属性
 timeMax 倒计时 时间
 timerTitle 倒计时 秒数后的文字
 */
@property (nonatomic,copy,readonly) TimerBlock setTimer;

/**设置ismissBtn按钮部分属性
 block btn属性设置
 */
@property (nonatomic,copy,readonly) SetBtnBlock setCountdownBtnBlock;
/**设置ismissBtn按钮部分属性
 hasCenterBtn  是否需要CenterBtn 默认NO
 block btn属性设置
 */
@property (nonatomic,copy,readonly) SetCenterBtnBlock setCenterBtnBlock;

/**设置滚动视图相关属性
 layout 滚动视图布局样式
 frame 滚动视图相对位置
 itemSize item大小
 scrollDirectionVertical 是否垂直滚动
 */
@property (nonatomic,copy,readonly) ScrollViewStyleBlock setScrollViewStyle;

/**设置加载图片／gif相关属性
 imageArr 图片数组
 isURL 是否为链接
 isGif 是否为Gif
 */
@property (nonatomic,copy,readonly) ImageArrBlock setImageArr;

/**WKWeb
 frame WKWeb 显示位置
 url 加载链接
 */
@property (nonatomic,copy,readonly) WKWebViewBlock setWKWebView;

/**视频播放
 frame 播放器坐标
 url 播放链接 网络／本地
 */
@property (nonatomic,copy,readonly) AVPlayerBlock setAVPlayer;

/**自定义视图
 block 返回一个定制的视图
 使用自定义视图，以上均不可用
 */
@property (nonatomic,copy,readonly) CustomViewBlock setCustomView;

/**设置视图消失动画
 block 返回一个自定义的动画
 */
@property (nonatomic,copy,readonly) CustomViewAnimateWhenHiddenBlock setCustomViewAnimateWhenHiddenBlock;

/**点击页面图片回调
 包含图片index，图片链接
 */
@property (nonatomic,copy,readonly) SetClickImageActionBlock setClickImageActionBlock;

/**点击右上角倒计时按钮回调
 自定义右上角按钮属性
 */
@property (nonatomic,copy,readonly) SetBtnActionBlock setCountdownBtnActionBlock;

/**点击中间的按钮的回调
 自定义中间按钮属性，默认贴在滚动视图最后一页的下面
 */
@property (nonatomic,copy,readonly) SetBtnActionBlock setCenterBtnActionBlock;

/**dismiss动画结束回调
 */
@property (nonatomic,copy,readonly) SetAnimateFinishedBlock setAnimateFinishedBlock;

/**目前，暴露出来给guideWindow调用的，
 */
@property (nonatomic,copy,readonly) AnimateFinishedBlock animateFinishedBlock;
/**设置启动图弹出时机，默认首次安装app
 三种状态：首次安装，每次启动，更新启动
 */
//@property (nonatomic,copy,readonly) SetGuidePageAPPLaunchStateOptions setGuidePageAPPLaunchStateOptions;

/**
 刷新视图
 */
- (void)reloadData;

@end


