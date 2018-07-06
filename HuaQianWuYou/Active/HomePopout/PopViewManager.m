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
@interface PopViewManager()

///* <#cintent#> */
//@property (nonatomic, strong) UIView  *backGroungView;

/* 弹款 */
@property (nonatomic, strong) PopView  *popView;

/* 悬浮广告 */
@property (nonatomic, strong) SuspendView  *suspendView;



@end

@implementation PopViewManager

+ (nonnull instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static PopViewManager *singleton;
    dispatch_once(&onceToken, ^{
        singleton = [[[self class] alloc] init];
    });
    return singleton;
}


+ (void)showType:(AdvertisingType)type fromVC:(UIViewController *)controller{
   
    [PopViewManager requstDataType:type fromVC:controller];
}


+ (void)showType:(AdvertisingType)type contentModel:(BasicDataModel*)model fromVC:(UIViewController *)controller{
    PopViewManager *manage = [PopViewManager sharedInstance];
    if (model == nil || model.AdvertisingVO == nil) {
        return;
    }
    [PopViewManager cacheToLoacl:model withType:type];
    switch (type) {
        case AdvertisingTypeAlert:
            if (controller) {
                manage.popView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
                [manage.popView.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.AdvertisingVO.imgUrl] placeholderImage:nil];
                WeakObj(manage);
                manage.popView.block = ^{
                    StrongObj(manage);
                    if (manage.delegate && [manage.delegate respondsToSelector:@selector(didSelectedContentUrl:popType:)]) {
                        [manage.delegate didSelectedContentUrl:model.AdvertisingVO.address popType:type];
                    }
                };
                
            }
            break;
        case AdvertisingTypeSuspensionWindow:
            if (controller) {
                [controller.view addSubview:manage.suspendView];
                [manage.suspendView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(-30);
                    make.right.mas_equalTo(-10);
                    make.height.mas_equalTo(80);
                    make.width.mas_equalTo(80);
                }];
                [manage.suspendView.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.AdvertisingVO.imgUrl] placeholderImage:nil];
                WeakObj(manage);
                manage.suspendView.block = ^{
                    StrongObj(manage);
                    if (manage.delegate && [manage.delegate respondsToSelector:@selector(didSelectedContentUrl:popType:)]) {
                        [manage.delegate didSelectedContentUrl:model.AdvertisingVO.address popType:type];
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
    BasicDataModel *model = [PopViewManager getCacheModel:type];
    [BasicDataModel requestBasicData:type productId:model.AdvertisingVO.productId sort:model.AdvertisingVO.sort Completion:^(BasicDataModel * _Nullable result, NSError * _Nullable error) {
        [PopViewManager showType:type contentModel:result fromVC:controller];
    }];
    
}

+ (void)cacheToLoacl:(BasicDataModel *)model withType:(AdvertisingType)type{
    NSData *jsonData = [model yy_modelToJSONData];
    NSString  *cacheKey = [NSString stringWithFormat:@"dataList%ld",(long)type];
    UserDefaultSetObj(jsonData, cacheKey);
}

+ (BasicDataModel *)getCacheModel:(AdvertisingType)type{
    NSString  *cacheKey = [NSString stringWithFormat:@"dataList%ld",(long)type];
    NSData *jsonData = UserDefaultGetObj(cacheKey);
    return  [BasicDataModel yy_modelWithJSON:jsonData];
}



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
