 //
//  PopViewManager.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/4.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "PopViewManager.h"
#import "PopView.h"
#import "SuspendView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BasicDataModel+Service.h"
#import "YYModel.h"
@interface PopViewManager()

///* <#cintent#> */
//@property (nonatomic, strong) UIView  *backGroungView;

/* 弹款 */
@property (nonatomic, strong) PopView  *popView;

/* 悬浮广告 */
@property (nonatomic, strong) SuspendView  *suspendView;

@property (nonatomic,strong) BasicDataModel *resultModel;
@property (nonatomic,assign) BOOL isFinish;//加载这个弹窗页面是否loading完
@property (nonatomic,assign) BOOL urlLodingFinish;//图片加载完成
@end

@implementation PopViewManager

+ (nonnull instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static PopViewManager *singleton;
    dispatch_once(&onceToken, ^{
        singleton = [[[self class] alloc] init];
        singleton.urlLodingFinish = false;
        singleton.isFinish = false;
    });
    return singleton;
}

+ (void)showType:(AdvertisingType)type fromVC:(UIViewController *)controller{
    [PopViewManager requstDataType:type fromVC:controller];
}

+ (void)isHiddenCustomView:(BOOL)isHidden withType:(AdvertisingType)type{
    PopViewManager *manage = [PopViewManager sharedInstance];
    manage.isFinish = !isHidden;
    if(isHidden || manage.urlLodingFinish){
        manage.urlLodingFinish = false;
        if (type == AdvertisingTypeAlert){
            manage.popView.hidden = isHidden;
        }else if (type ==AdvertisingTypeSuspensionWindow){
            manage.suspendView.hidden = isHidden;
        }
    }
}

+ (void)showType:(AdvertisingType)type contentModel:(BasicDataModel*)model fromVC:(UIViewController *)controller{
    PopViewManager *manage = [PopViewManager sharedInstance];
    if (model == nil) {
        return;
    }
    switch (type) {
        case AdvertisingTypeAlert:
            if (controller) {
                manage.popView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
                [manage.popView.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    if( error != nil || image == nil){
                        [manage.popView removeFromSuperview];
                        manage.urlLodingFinish = false;
                    }else{
                        manage.urlLodingFinish = true;
                        if (manage.isFinish)
                        {
                            manage.popView.hidden = false;
                        }
                    }
                }];
                WeakObj(manage);
                manage.popView.block = ^(BOOL isClose){
                    if (isClose) {
                        [self eventId:HQWY_Home_AdvertiseClose_click];
                    }else{
                    StrongObj(manage);
                    [self eventId:[NSString stringWithFormat:@"%@%@", HQWY_Home_Advertisement_click,model.productId]];
                    if (manage.delegate && [manage.delegate respondsToSelector:@selector(didSelectedContent:popType:)]) {
                        [manage.delegate didSelectedContent:model popType:type];
                    }
                    }
                };
                
            }
            break;
        default:
            break;
    }
}

# pragma mark 弹框数据显示逻辑
+ (void)requstDataType:(AdvertisingType)type fromVC:(UIViewController *)controller{
    BasicDataModel *model = [BasicDataModel getCacheModel:type];
    if (type == AdvertisingTypeAlert) {
        if (![GetUserDefault(@"advertisementDate") isEqualToString:[NSDate hj_stringWithDate:[NSDate date] format:@"yyyyMMdd"]]){
            model.sort = @0;
            model.productId = @0;
        }
    }else{
        if (model.productId == nil) {
            model.productId = @0;
        }
        if (model.sort == nil) {
            model.sort = @0;
        }
    }
    [BasicDataModel requestBasicData:type productId:model.productId sort:model.sort Completion:^(BasicDataModel * _Nullable result, NSError * _Nullable error) {
        if (error) {
            [PopViewManager sharedInstance].resultModel = nil;
            return;
        }
        if (result) {
            [PopViewManager sharedInstance].resultModel = result;
             [PopViewManager showType:type contentModel:result fromVC:controller];
        }
    }];
    
}

//+ (void)cacheToLoacl:(BasicDataModel *)model withType:(AdvertisingType)type{
//    NSData *jsonData = [model yy_modelToJSONData];
//    NSString  *cacheKey = [NSString stringWithFormat:@"dataList%ld",(long)type];
//    UserDefaultSetObj(jsonData, cacheKey);
//}
//
//+ (BasicDataModel *)getCacheModel:(AdvertisingType)type{
//    NSString  *cacheKey = [NSString stringWithFormat:@"dataList%ld",(long)type];
//    NSData *jsonData = UserDefaultGetObj(cacheKey);
//    return  [BasicDataModel yy_modelWithJSON:jsonData];
//}



# pragma mark subView

- (PopView *)popView{
    if (!_popView) {
        _popView = [[NSBundle mainBundle] loadNibNamed:@"PopView" owner:nil options:nil].firstObject;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        _popView.frame = window.bounds;
        [window addSubview:_popView];
    }
    return _popView;
}

- (SuspendView *)suspendView{
    if (!_suspendView) {
        _suspendView = [[NSBundle mainBundle] loadNibNamed:@"SuspendView" owner:nil options:nil].firstObject;
    }
    return _suspendView;
}

//- (UIView *)backGroungView{
//    if (!_backGroungView) {
//        _backGroungView = [UIView new];
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
//        _backGroungView.frame = window.bounds;
//        _backGroungView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
//        [window addSubview:_backGroungView];
//    }
//    return _backGroungView;
//}

@end
