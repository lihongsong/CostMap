//
//  WYHQLocation.h
//  WYHQLocation
//
//  Created by yoser on 2018/10/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^WYHQLocationResult) (NSString *city);

@interface WYHQLocation : NSObject

/**
 单例类

 @return 实例
 */
+ (instancetype)sharedInstance;

/**
 获取当前的定位信息

 @param result 城市回调
 */
- (void)location:(WYHQLocationResult)result;


@end

NS_ASSUME_NONNULL_END
