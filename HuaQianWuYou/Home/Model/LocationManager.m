//
//  LocationManager.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/3.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "LocationManager.h"
#import <BMKLocationkit/BMKLocationComponent.h>
@interface LocationManager()<BMKLocationManagerDelegate>
@property(nonatomic,strong)BMKLocationManager *locationManager;
@end

@implementation LocationManager

#pragma - mark 初始化位置信息
 - (void)initLocationService {
 //初始化BMKLocationService
     //初始化实例
     self.locationManager = [[BMKLocationManager alloc] init];
     
     self.locationManager.delegate = self;
     
     self.locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
     self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
     self.locationManager.activityType = CLActivityTypeAutomotiveNavigation;
     self.locationManager.pausesLocationUpdatesAutomatically = NO;
     self.locationManager.allowsBackgroundLocationUpdates = NO;// YES的话是可以进行后台定位的，但需要项目配置，否则会报错，具体参考开发文档
     self.locationManager.locationTimeout = 10;
     self.locationManager.reGeocodeTimeout = 10;
     [self.locationManager startUpdatingLocation];
 }


#pragma - mark BMKLocationManagerDelegate

/**
 *用户位置更新后，会调用此函数
 *
 */

- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didUpdateLocation:(BMKLocation * _Nullable)location orError:(NSError * _Nullable)error

{

    if (error)
    {
        NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
    } if (location) {//得到定位信息，添加annotation
        if (location.location) {
            NSLog(@"LOC = %@",location.location);
        }
        if (location.rgcData) {
            NSLog(@"rgc = %@",[location.rgcData description]);
        }
    }
}

/**
 *  @brief 当定位发生错误时，会调用代理的此方法。
 *  @param manager 定位 BMKLocationManager 类。
 *  @param error 返回的错误，参考 CLError 。
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didFailWithError:(NSError * _Nullable)error{
    NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
}

/**
 *  @brief 定位权限状态改变时回调函数
 *  @param manager 定位 BMKLocationManager 类。
 *  @param status 定位权限状态。
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    NSLog(@"locStatus:{%d};",status);
}
#pragma - mark BMKGeoCodeSearchDelegate

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
/*
 - (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
 if (error == BMK_SEARCH_NO_ERROR) {
 UIView *rightItemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 40)];
 UILabel *locationLabel = [UILabel new];
 UIImageView *locationImage = [UIImageView new];
 [rightItemView addSubview:locationLabel];
 [rightItemView addSubview:locationImage];
 [locationImage mas_makeConstraints:^(MASConstraintMaker *make) {
 make.size.mas_equalTo(CGSizeMake(10, 13));
 make.centerY.mas_equalTo(rightItemView.mas_centerY);
 }];
 [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
 make.height.mas_equalTo(40);
 make.left.mas_equalTo(locationImage.mas_right).mas_offset(5);
 make.right.mas_equalTo(rightItemView.mas_right);
 make.centerY.mas_equalTo(rightItemView.mas_centerY);
 }];
 locationImage.image = [UIImage imageNamed:@"navbar_location_02"];
 locationLabel.text = result.addressDetail.city;
 locationLabel.textColor = HJHexColor(0xffffff);
 locationLabel.adjustsFontSizeToFitWidth = YES;
 locationLabel.textAlignment = NSTextAlignmentRight;
 locationLabel.font = [UIFont systemFontOfSize:13];
 UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItemView];
 self.navigationItem.rightBarButtonItem = barButtonItem;
 } else {
 NSLog(@"地理位置反编码出错 ---> %@",[NSString stringWithFormat:@"%d", error]);
 }
 }
 */
 
@end
