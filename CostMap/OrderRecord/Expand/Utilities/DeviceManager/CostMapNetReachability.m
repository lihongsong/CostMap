#import "CostMapNetReachability.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
NSString *const LNRiskNetworkingReachabilityDidChangeNotification = @"com.LNRisk.networking.reachability.change";
NSString *const LNRiskNetworkingReachabilityNotificationStatusItem = @"LNRiskNetworkingReachabilityNotificationStatusItem";
typedef void (^LNRiksNetworkReachabilityStatusBlock)(LNRiskReachabilityStatus status);
NSString *LNRiksStringFromNetworkReachabilityStatus(LNRiskReachabilityStatus status) {
    switch (status) {
        case LNRiskReachabilityStatusNotReachable:
            return NSLocalizedStringFromTable(@"Not Reachable", @"AFNetworking", nil);
        case LNRiskReachabilityStatusReachableVia2G:
            return @"2G";
        case LNRiskReachabilityStatusReachableVia3G:
            return @"3G";
        case LNRiskReachabilityStatusReachableVia4G:
            return @"4G";
        case LNRiskReachabilityStatusReachableViaWiFi:
            return NSLocalizedStringFromTable(@"Reachable via WiFi", @"AFNetworking", nil);
        case LNRiskReachabilityStatusUnknown:
        default:
            return NSLocalizedStringFromTable(@"Unknown", @"AFNetworking", nil);
    }
}
static LNRiskReachabilityStatus LNRiskNetworkReachabilityStatusForFlags(SCNetworkReachabilityFlags flags) {
    BOOL isReachable = ((flags & kSCNetworkReachabilityFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkReachabilityFlagsConnectionRequired) != 0);
    BOOL canConnectionAutomatically = (((flags & kSCNetworkReachabilityFlagsConnectionOnDemand) != 0) || ((flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0));
    BOOL canConnectWithoutUserInteraction = (canConnectionAutomatically && (flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0);
    BOOL isNetworkReachable = (isReachable && (!needsConnection || canConnectWithoutUserInteraction));
    LNRiskReachabilityStatus status = LNRiskReachabilityStatusUnknown;
    if (isNetworkReachable == NO) {
        status = LNRiskReachabilityStatusNotReachable;
    }
#if TARGET_OS_IPHONE
    else if ((flags & kSCNetworkReachabilityFlagsIsWWAN) != 0) {
        {
            NSArray *typeStrings2G = @[ CTRadioAccessTechnologyEdge,
                                        CTRadioAccessTechnologyGPRS,
                                        CTRadioAccessTechnologyCDMA1x ];
            NSArray *typeStrings3G = @[ CTRadioAccessTechnologyHSDPA,
                                        CTRadioAccessTechnologyWCDMA,
                                        CTRadioAccessTechnologyHSUPA,
                                        CTRadioAccessTechnologyCDMAEVDORev0,
                                        CTRadioAccessTechnologyCDMAEVDORevA,
                                        CTRadioAccessTechnologyCDMAEVDORevB,
                                        CTRadioAccessTechnologyeHRPD ];
            NSArray *typeStrings4G = @[ CTRadioAccessTechnologyLTE ];
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
                CTTelephonyNetworkInfo *teleInfo = [[CTTelephonyNetworkInfo alloc] init];
                NSString *accessString = teleInfo.currentRadioAccessTechnology;
                if ([typeStrings4G containsObject:accessString]) {
                    status = LNRiskReachabilityStatusReachableVia4G;
                } else if ([typeStrings3G containsObject:accessString]) {
                    status = LNRiskReachabilityStatusReachableVia3G;
                } else if ([typeStrings2G containsObject:accessString]) {
                    status = LNRiskReachabilityStatusReachableVia2G;
                } else {
                    return LNRiskReachabilityStatusUnknown;
                }
            } else {
                return LNRiskReachabilityStatusUnknown;
            }
        }
    }
#endif
    else {
        status = LNRiskReachabilityStatusReachableViaWiFi;
    }
    return status;
}
static void LNRiskPostReachabilityStatusChange(SCNetworkReachabilityFlags flags, LNRiksNetworkReachabilityStatusBlock block) {
    LNRiskReachabilityStatus status = LNRiskNetworkReachabilityStatusForFlags(flags);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (block) {
            block(status);
        }
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        NSDictionary *userInfo = @{ LNRiskNetworkingReachabilityNotificationStatusItem : @(status) };
        [notificationCenter postNotificationName:LNRiskNetworkingReachabilityDidChangeNotification object:nil userInfo:userInfo];
    });
}
static void LNRiksNetworkReachabilityCallback(SCNetworkReachabilityRef __unused target, SCNetworkReachabilityFlags flags, void *info) {
    LNRiskPostReachabilityStatusChange(flags, (__bridge LNRiksNetworkReachabilityStatusBlock)info);
}
static const void *LNRiskNetworkReachabilityRetainCallback(const void *info) {
    return Block_copy(info);
}
static void LNRiskNetworkReachabilityReleaseCallback(const void *info) {
    if (info) {
        Block_release(info);
    }
}
@interface CostMapNetReachability ()
@property (readonly, nonatomic, assign) SCNetworkReachabilityRef networkReachability;
@property (readwrite, nonatomic, assign) LNRiskReachabilityStatus networkReachabilityStatus;
@property (readwrite, nonatomic, copy) LNRiksNetworkReachabilityStatusBlock networkReachabilityStatusBlock;
@end
@implementation CostMapNetReachability
+ (instancetype)sharedManager {
    static CostMapNetReachability *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [self manager];
    });
    return _sharedManager;
}
+ (instancetype)managerForDomain:(NSString *)domain {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, [domain UTF8String]);
    CostMapNetReachability *manager = [[self alloc] initWithReachability:reachability];
    CFRelease(reachability);
    return manager;
}
+ (instancetype)managerForAddress:(const void *)address {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)address);
    CostMapNetReachability *manager = [[self alloc] initWithReachability:reachability];
    CFRelease(reachability);
    return manager;
}
+ (instancetype)manager {
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000) || (defined(__MAC_OS_X_VERSION_MIN_REQUIRED) && __MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    struct sockaddr_in6 address;
    bzero(&address, sizeof(address));
    address.sin6_len = sizeof(address);
    address.sin6_family = AF_INET6;
#else
    struct sockaddr_in address;
    bzero(&address, sizeof(address));
    address.sin_len = sizeof(address);
    address.sin_family = AF_INET;
#endif
    return [self managerForAddress:&address];
}
- (instancetype)initWithReachability:(SCNetworkReachabilityRef)reachability {
    self = [super init];
    if (!self) {
        return nil;
    }
    _networkReachability = CFRetain(reachability);
    self.networkReachabilityStatus = LNRiskReachabilityStatusUnknown;
    return self;
}
- (instancetype)init NS_UNAVAILABLE {
    return nil;
}
- (void)dealloc {
    [self stopMonitoring];
    if (_networkReachability != NULL) {
        CFRelease(_networkReachability);
    }
}

- (BOOL)isReachable {
    return [self isReachableViaWWAN] || [self isReachableViaWiFi];
}
- (BOOL)isReachableViaWWAN {
    return (self.networkReachabilityStatus == LNRiskReachabilityStatusReachableVia4G) || (self.networkReachabilityStatus == LNRiskReachabilityStatusReachableVia3G) || self.networkReachabilityStatus == LNRiskReachabilityStatusReachableVia2G;
}
- (BOOL)isReachableViaWiFi {
    return self.networkReachabilityStatus == LNRiskReachabilityStatusReachableViaWiFi;
}

- (void)startMonitoring {
    [self stopMonitoring];
    if (!self.networkReachability) {
        return;
    }
    __weak __typeof(self) weakSelf = self;
    LNRiksNetworkReachabilityStatusBlock callback = ^(LNRiskReachabilityStatus status) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.networkReachabilityStatus = status;
        if (strongSelf.networkReachabilityStatusBlock) {
            strongSelf.networkReachabilityStatusBlock(status);
        }
    };
    SCNetworkReachabilityContext context = {0, (__bridge void *)callback, LNRiskNetworkReachabilityRetainCallback, LNRiskNetworkReachabilityReleaseCallback, NULL};
    SCNetworkReachabilitySetCallback(self.networkReachability, LNRiksNetworkReachabilityCallback, &context);
    SCNetworkReachabilityScheduleWithRunLoop(self.networkReachability, CFRunLoopGetMain(), kCFRunLoopCommonModes);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(self.networkReachability, &flags)) {
            LNRiskPostReachabilityStatusChange(flags, callback);
        }
    });
}
- (void)stopMonitoring {
    if (!self.networkReachability) {
        return;
    }
    SCNetworkReachabilityUnscheduleFromRunLoop(self.networkReachability, CFRunLoopGetMain(), kCFRunLoopCommonModes);
}

- (NSString *)localizedNetworkReachabilityStatusString {
    return LNRiksStringFromNetworkReachabilityStatus(self.networkReachabilityStatus);
}

- (void)setReachabilityStatusChangeBlock:(void (^)(LNRiskReachabilityStatus status))block {
    self.networkReachabilityStatusBlock = block;
}
+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    if ([key isEqualToString:@"reachable"] || [key isEqualToString:@"reachableViaWWAN"] || [key isEqualToString:@"reachableViaWiFi"]) {
        return [NSSet setWithObject:@"networkReachabilityStatus"];
    }
    return [super keyPathsForValuesAffectingValueForKey:key];
}
@end
