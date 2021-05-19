#import "CostMapLocation.h"
#import <CoreLocation/CoreLocation.h>
@interface CostMapLocation ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *manager;
@property (copy, nonatomic) NSString *cityName;
@property (strong, nonatomic) NSMutableArray <CostMapLocationResult> *results;
@end
@implementation CostMapLocation
+ (instancetype)sharedInstance {
    static CostMapLocation *location;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [CostMapLocation new];
    });
    return location;
}
- (CLLocationManager *)manager {
    if (!_manager) {
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
    }
    return _manager;
}
- (void)locate {
    if ([CLLocationManager locationServicesEnabled]) {
        [self.manager startUpdatingLocation];
    }
}
- (void)location:(CostMapLocationResult)result {
    if (_cityName) {
        !result?:result(_cityName);
        return ;
    }
    [self.results addObject:result];
    [self locate];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {

    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            [_manager requestWhenInUseAuthorization];
            break;
        case kCLAuthorizationStatusRestricted:
            _manager = nil;
            break;
        case kCLAuthorizationStatusDenied:
            _manager = nil;
            break;
        default:
            break;
    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (manager.location) {
        CLLocationCoordinate2D coordinate = manager.location.coordinate;
        WEAK_SELF
        [self reverseGeocoder:@(coordinate.longitude).stringValue
                     latitude:@(coordinate.latitude).stringValue
                       result:^(NSString * _Nonnull city) {
                           STRONG_SELF
                           self.cityName = city;
                           [[self results] enumerateObjectsUsingBlock:^(CostMapLocationResult  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                               !obj?:obj(city);
                           }];
                           [[self results] removeAllObjects];
        }];
        [_manager stopUpdatingLocation];
        _manager = nil;
    }
}
- (void)reverseGeocoder:(NSString *)longitude latitude:(NSString *)latitude result:(CostMapLocationResult)resuslt {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error != nil || placemarks.count == 0) {
            NSLog(@"%@",error);
            return ;
        }
        for (CLPlacemark *placemark in placemarks) {
            NSString *city = placemark.subLocality;
            !resuslt?:resuslt(city);
        }
    }];
}
- (NSMutableArray<CostMapLocationResult> *)results {
    if (!_results) {
        _results = [NSMutableArray array];
    }
    return _results;
}
@end
