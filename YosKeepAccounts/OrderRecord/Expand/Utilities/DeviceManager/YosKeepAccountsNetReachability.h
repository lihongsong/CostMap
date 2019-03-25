#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
typedef NS_ENUM(NSInteger, LNRiskReachabilityStatus) {
    LNRiskReachabilityStatusUnknown = -1,
    LNRiskReachabilityStatusNotReachable = 0,
    LNRiskReachabilityStatusReachableVia2G = 1,
    LNRiskReachabilityStatusReachableVia3G = 2,
    LNRiskReachabilityStatusReachableVia4G = 3,
    LNRiskReachabilityStatusReachableViaWiFi = 4,
};
NS_ASSUME_NONNULL_BEGIN
@interface YosKeepAccountsNetReachability : NSObject
@property (readonly, nonatomic, assign) LNRiskReachabilityStatus networkReachabilityStatus;
@property (readonly, nonatomic, assign, getter=isReachable) BOOL reachable;
@property (readonly, nonatomic, assign, getter=isReachableViaWWAN) BOOL reachableViaWWAN;
@property (readonly, nonatomic, assign, getter=isReachableViaWiFi) BOOL reachableViaWiFi;
+ (instancetype)sharedManager;
+ (instancetype)manager;
+ (instancetype)managerForDomain:(NSString *)domain;
+ (instancetype)managerForAddress:(const void *)address;
- (instancetype)initWithReachability:(SCNetworkReachabilityRef)reachability NS_DESIGNATED_INITIALIZER;
- (void)startMonitoring;
- (void)stopMonitoring;
- (NSString *)localizedNetworkReachabilityStatusString;
- (void)setReachabilityStatusChangeBlock:(nullable void (^)(LNRiskReachabilityStatus status))block;
@end
NS_ASSUME_NONNULL_END
