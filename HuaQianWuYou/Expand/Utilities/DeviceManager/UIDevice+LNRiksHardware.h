//
//  UIDevice+Hardware.h
//  TestTable
//
//  Created by Inder Kumar Rathore on 19/01/13.
//  Copyright (c) 2013 Rathore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (LNRiksHardware)

/**
 设备的名称
 @return 返回设备的iPhone硬件信息
 */
- (NSString *)hardwareString;

/**
 CPU的频率
 @return CPU的频率
 */
+ (NSUInteger)cpuFrequency;

/**

 @return Bus 的频率
 */
+ (NSUInteger)busFrequency;
/**
 @return RAM的大小
 */
+ (NSUInteger)ramSize;

/**
 @return CPU的大小
 */
+ (NSUInteger)cpuNumber;

/**
 cpu的类型
 @return 返回CPU类型
 */
+ (NSString *)cpuType;

/**
 @return 是否拥有相机
 */
+ (BOOL)hasCamera;

/**
 @return 手机机内存总量
 */
+ (NSUInteger)totalMemoryBytes;

/**
 @return 手机可用内存
 */
+ (NSUInteger)freeMemoryBytes;

/**
 @return 手机硬盘空闲空间
 */
+ (long long)freeDiskSpaceBytes;

/**
 @return 手机硬盘总空间
 */
+ (long long)totalDiskSpaceBytes;



/**
 @return 设备的 类型
 */
+ (NSString *)getDeviceType;
@end
