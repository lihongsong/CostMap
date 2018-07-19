//
//  DeviceTypes.h
//  DeviceType
//
//  Created by Kasun Randika on 6/28/16.
//  Copyright © 2016 Kasun Randika. All rights reserved.
//

#import <Foundation/Foundation.h>

// For the releases or real device testing following constant must be set to Zero
// 0 -> Real Device
// 1 -> iPhone5
// 2 -> iPhone6
// 3 -> iPhone6+
// 4 -> iPads
// 5 -> iPhoneX
#define DEVICE_TYPE_NUMBER 0

@interface DeviceTypes : NSObject

+ (NSString*)deviceModelName;
+ (BOOL)isIPhone5SizedDevice;
+ (BOOL)isIPhone6SizedDevice;
+ (BOOL)isIPhone6PlusSizedDevice;
+ (BOOL)isIPhoneXSizedDevice;
+ (BOOL)isIPad;
+ (NSString *)getDeviceType;

@end

