//
//  FBLocation.m
//  Feedback
//
//  Created by yoser on 2018/10/18.
//

#import "WYHQLocation.h"

#import <CoreLocation/CoreLocation.h>

@interface WYHQLocation ()<CLLocationManagerDelegate>

/**
 定位管理器，在权限被拒或者定位成功后会被销毁
 */
@property (nonatomic, strong) CLLocationManager *manager;

/**
 定位信息
 */
@property (copy, nonatomic) NSString *cityName;

/**
 定位信息回调
 */
@property (strong, nonatomic) NSMutableArray <WYHQLocationResult> *results;

@end

@implementation WYHQLocation

+ (instancetype)sharedInstance {
    static WYHQLocation *location;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [WYHQLocation new];
    });
    return location;
}

#pragma mark - Getter

- (CLLocationManager *)manager {
    if (!_manager) {
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
    }
    return _manager;
}

#pragma mark - Action

- (void)locate {
    if ([CLLocationManager locationServicesEnabled]) {
        /**
         *  只有在开始定位时才会去获取定位权限，所以这里不去判断用户是否确定过权限
         *  如果用户”允许“了，系统则会继续该次请求，所以不需要再去请求一次
         */
        [self.manager startUpdatingLocation];
    }
}

- (void)location:(WYHQLocationResult)result {
    
    if (_cityName) {
        !result?:result(_cityName);
        return ;
    }
    
    [self.results addObject:result];
    
    [self locate];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            // 请求“使用中”权限
            [_manager requestWhenInUseAuthorization];
            break;
        case kCLAuthorizationStatusRestricted:
            // 访问受限
            _manager = nil;
            break;
        case kCLAuthorizationStatusDenied:
            // 用户拒绝使用定位服务
            _manager = nil;
            break;
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    /**
     *  定位成功后获取位置信息
     *  这里取 manager.location 和 locations.lastObject 是一样的
     */
    if (manager.location) {
        CLLocationCoordinate2D coordinate = manager.location.coordinate;
        
        WEAK_SELF
        [self reverseGeocoder:@(coordinate.longitude).stringValue
                     latitude:@(coordinate.latitude).stringValue
                       result:^(NSString * _Nonnull city) {
                           STRONG_SELF
                           self.cityName = city;
                           [[self results] enumerateObjectsUsingBlock:^(WYHQLocationResult  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                               !obj?:obj(city);
                           }];
                           [[self results] removeAllObjects];
        }];
        
        [_manager stopUpdatingLocation];
        _manager = nil;
    }
}

/**
 地理反编码
 */
- (void)reverseGeocoder:(NSString *)longitude latitude:(NSString *)latitude result:(WYHQLocationResult)resuslt {
    
    // 创建地理编码对象
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    // 创建位置
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
    
    //反地理编码
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //判断是否有错误或者placemarks是否为空
        if (error != nil || placemarks.count == 0) {
            NSLog(@"%@",error);
            return ;
        }
        for (CLPlacemark *placemark in placemarks) {
            //详细地址
            NSString *city = placemark.subLocality;
            !resuslt?:resuslt(city);
        }
    }];
}

- (NSMutableArray<WYHQLocationResult> *)results {
    if (!_results) {
        _results = [NSMutableArray array];
    }
    return _results;
}
@end
