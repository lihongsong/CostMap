#import "CostMapDeviceTypes.h"
#import <sys/utsname.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@implementation DeviceTypes
+ (NSString*)deviceEntityName {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *machineName = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSDictionary *commonNamesDictionary =
    @{
      @"i386":     @"i386 Simulator",
      @"x86_64":   @"x86_64 Simulator",
      @"iPhone1,1":    @"iPhone 1G",
      @"iPhone1,2":    @"iPhone 3G",
      @"iPhone2,1":    @"iPhone 3GS",
      @"iPhone3,1":    @"iPhone 4(GSM)",
      @"iPhone3,2":    @"iPhone 4(GSM Rev A)",
      @"iPhone3,3":    @"iPhone 4(CDMA)",
      @"iPhone4,1":    @"iPhone 4S",
      @"iPhone5,1":    @"iPhone 5(GSM)",
      @"iPhone5,2":    @"iPhone 5(Global)",
      @"iPhone5,3":    @"iPhone 5c(GSM)",
      @"iPhone5,4":    @"iPhone 5c(Global)",
      @"iPhone6,1":    @"iPhone 5s(GSM)",
      @"iPhone6,2":    @"iPhone 5s(Global)",
      @"iPhone7,1":    @"iPhone 6Plus",
      @"iPhone7,2":    @"iPhone 6",
      @"iPhone8,1":    @"iPhone 6S",
      @"iPhone8,2":    @"iPhone 6SPlus",
      @"iPhone8,4":    @"iPhone SE",
      @"iPhone9,1":    @"iPhone 7",
      @"iPhone9,3":    @"iPhone 7",
      @"iPhone9,2":    @"iPhone 7Plus",
      @"iPhone9,4":    @"iPhone 7Plus",
      @"iPhone10,1":   @"iPhone 8",
      @"iPhone10,4":   @"iPhone 8",
      @"iPhone10,2":   @"iPhone 8Plus",
      @"iPhone10,5":   @"iPhone 8Plus",
      @"iPhone10,3":   @"iPhone X",
      @"iPhone10,6":   @"iPhone X",
      @"iPad1,1":  @"iPad",
      @"iPad2,1":  @"iPad 2(WiFi)",
      @"iPad2,2":  @"iPad 2(GSM)",
      @"iPad2,3":  @"iPad 2(CDMA)",
      @"iPad2,4":  @"iPad 2(WiFi Rev A)",
      @"iPad2,5":  @"iPad mini 1G (Wi-Fi)",
      @"iPad2,6":  @"iPad mini 1G (GSM)",
      @"iPad2,7":  @"iPad mini 1G (Global)",
      @"iPad3,1":  @"iPad 3(WiFi)",
      @"iPad3,2":  @"iPad 3(Global)",
      @"iPad3,3":  @"iPad 3(GSM)",
      @"iPad3,4":  @"iPad 4(WiFi)",
      @"iPad3,5":  @"iPad 4(GSM)",
      @"iPad3,6":  @"iPad 4(Global)",
      @"iPad4,1":  @"iPad Air(WiFi)",
      @"iPad4,2":  @"iPad Air(GSM)",
      @"iPad4,3":  @"iPad Air(Cellular)",
      @"iPad4,4":  @"iPad mini 2G (Wi-Fi)",
      @"iPad4,5":  @"iPad mini 2G (Cellular)",
      @"iPad4,6":  @"iPad mini 2G (Cellular)",
      @"iPad4,7":  @"iPad mini 3G (Wi-Fi)",
      @"iPad4,8":  @"iPad mini 3G (Cellular+Wi-Fi)",
      @"iPad4,9":  @"iPad mini 3G (Cellular)",
      @"iPad5,1":  @"iPad mini 4G (Wi-Fi)",
      @"iPad5,2":  @"iPad mini 4G (Cellular)",
      @"iPad5,3":  @"iPad Air 2 (WiFi)",
      @"iPad5,4":  @"iPad Air 2 (Cellular)",
      @"iPad6,3":  @"iPad Pro (9.7 inch) 1G (Wi-Fi)",
      @"iPad6,4":  @"iPad Pro (9.7 inch) 1G (Cellular)",
      @"iPad6,7":  @"iPad Pro (12.9 inch) 1G (Wi-Fi)",
      @"iPad6,8":  @"iPad Pro (12.9 inch) 1G (Cellular)",
      @"iPad6,11": @"iPad 5 (WiFi)",
      @"iPad6,12": @"iPad 5 (Cellular)",
      @"iPad7,1":  @"iPad Pro (12.9 inch) 2(WiFi)",
      @"iPad7,2":  @"iPad Pro (12.9 inch) 2(Cellular)",
      @"iPad7,3":  @"iPad Pro (10.5 inch) (WiFi)",
      @"iPad7,4":  @"iPad Pro (10.5 inch) (Cellular)",
      @"iPod1,1":  @"iPod touch 1G",
      @"iPod2,1":  @"iPod touch 2G",
      @"iPod3,1":  @"iPod touch 3G",
      @"iPod4,1":  @"iPod touch 4G",
      @"iPod5,1":  @"iPod touch 5G",
      @"iPod7,1":  @"iPod touch 6G",
      };
    NSString *deviceName = commonNamesDictionary[machineName];
    if (deviceName == nil) {
        deviceName = machineName;
    }
    return deviceName;
}
+ (BOOL)isIPhone5SizedDevice {
    if (DEVICE_TYPE_NUMBER == 1) {
        return YES;
    }
    if ([[DeviceTypes deviceEntityName] isEqualToString:@"iPhone 5(GSM)"] ||
        [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone 5(Global)"] ||
        [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone 5c(GSM)"] ||
        [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone 5c(Global)"] ||
        [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone 5s(GSM)"] ||
        [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone 5s(Global)"] ||
        [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone SE"]) {
        return YES;
    } else if ([[DeviceTypes deviceEntityName] isEqualToString:@"iPhone5,1"] ||
               [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone5,2"] ||
               [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone5,3"] ||
               [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone5,4"] ||
               [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone6,1"] ||
               [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone6,2"] ||
               [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone8,4"]) {
        return YES;
    } else {
        return NO;
    }
}
+ (BOOL)isIPhone6SizedDevice {
    if (DEVICE_TYPE_NUMBER == 2) {
        return YES;
    }
    if ([[DeviceTypes deviceEntityName] isEqualToString:@"iPhone 6"] ||
        [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone 6S"] ||
        [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone 7"] ||
        [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone 8"]) {
        return YES;
    } else if ([[DeviceTypes deviceEntityName] isEqualToString:@"iPhone7,2"] ||
               [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone8,1"] ||
               [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone9,1"] ||
               [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone9,3"] ||
               [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone10,1"] ||
               [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone10,4"]) {
        return YES;
    } else {
        return NO;
    }
}
+ (BOOL)isIPhone6PlusSizedDevice {
    if (DEVICE_TYPE_NUMBER == 3) {
        return YES;
    }
    if ([[DeviceTypes deviceEntityName] isEqualToString:@"iPhone 6Plus"] ||
        [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone 6SPlus"] ||
        [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone 7Plus"] ||
        [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone 8Plus"]) {
        return YES;
    } else if ([[DeviceTypes deviceEntityName] isEqualToString:@"iPhone7,1"] ||
               [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone8,2"] ||
               [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone9,2"] ||
               [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone9,4"] ||
               [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone10,2"] ||
               [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone10,5"]) {
        return YES;
    } else {
        return NO;
    }
}
+ (BOOL)isIPhoneXSizedDevice{
    if (DEVICE_TYPE_NUMBER == 5) {
        return YES;
    }
    if ([[DeviceTypes deviceEntityName] isEqualToString:@"iPhone X"] ||
        [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone X"]) {
        return YES;
    } else if ([[DeviceTypes deviceEntityName] isEqualToString:@"iPhone10,3"] ||
               [[DeviceTypes deviceEntityName] isEqualToString:@"iPhone10,6"]) {
        return YES;
    } else {
        return NO;
    }
}
+ (BOOL)isIPad {
    if (DEVICE_TYPE_NUMBER == 4) {
        return YES;
    }
    NSArray *arrMachineNames = @[@"iPad1,1", @"iPad2,1", @"iPad2,2", @"iPad2,3", @"iPad2,4", @"iPad2,5", @"iPad2,6", @"iPad2,7", @"iPad3,1", @"iPad3,2", @"iPad3,3", @"iPad3,4", @"iPad3,5", @"iPad3,6", @"iPad4,1", @"iPad4,2", @"iPad4,3", @"iPad5,3", @"iPad5,4", @"iPad4,4", @"iPad4,5", @"iPad4,6", @"iPad4,7", @"iPad4,8", @"iPad4,9", @"iPad5,1", @"iPad5,2", @"iPad5,3", @"iPad5,4", @"iPad6,3", @"iPad6,4", @"iPad6,7", @"iPad6,8"];
    NSArray *arrDeviceNames = @[@"iPad", @"iPad 2(WiFi)", @"iPad 2(GSM)", @"iPad 2(CDMA)", @"iPad 2(WiFi Rev A)", @"iPad Mini 1G (WiFi)", @"iPad Mini 1G (GSM)", @"iPad Mini 1G (Global)", @"iPad 3(WiFi)", @"iPad 3(Global)", @"iPad 3(GSM)", @"iPad 4(WiFi)", @"iPad 4(GSM)", @"iPad 4(Global)", @"iPad Air(WiFi)", @"iPad Air(GSM)", @"iPad Air(Cellular)", @"iPad mini 2G (Wi-Fi)", @"iPad mini 2G (Cellular)", @"iPad mini 3G (Wi-Fi)", @"iPad mini 3G (Cellular)", @"iPad mini 4G (Wi-Fi)", @"iPad mini 4G (Cellular)", @"iPad Air 2 (WiFi)", @"iPad Air 2 (Cellular)", @"iPad Pro (9.7 inch) 1G (Wi-Fi)", @"iPad Pro (9.7 inch) 1G (Cellular)", @"iPad Pro (12.9 inch) 1G (Wi-Fi)", @"iPad Pro (12.9 inch) 1G (Cellular)"];
    BOOL result = NO;
    if ([arrDeviceNames containsObject:[DeviceTypes deviceEntityName]]) {
        result = YES;
    } else if ([arrMachineNames containsObject:[DeviceTypes deviceEntityName]]) {
        result = YES;
    }
    return result;
}
+ (NSString *)getDeviceType {
    NSString *deviceName = [DeviceTypes deviceEntityName];
    if ([deviceName hasPrefix:@"iPhone"]) {
        return @"iPhone";
    } else if ([deviceName hasPrefix:@"iPod"]) {
        return @"iPod";
    } else if ([deviceName hasPrefix:@"iPad"]) {
        return @"iPad";
    } else {
        return [[UIDevice currentDevice] model];
    }
    return @"UNKNOWN";
}
@end
