//
//  DiscoverPageModel.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/21.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "DiscoverPageModel.h"

@implementation DiscoverPageModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
            @"discoverList": [DiscoverItemModel class],
            @"banner": [BannerModel class],
    };
}
@end

@implementation BannerModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{
             @"bigImageUrl":@"big_img_path",
             @"smallImageUrl":@"thumb_img_path",
             @"time":@"create_time",
             @"readers":@"read_num",
             @"articalId":@"id",
             };
}
@end


@implementation DiscoverItemModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{
             @"bigImageUrl":@"big_img_path",
             @"smallImageUrl":@"thumb_img_path",
             @"time":@"create_time",
             @"readers":@"read_num",
             @"articalId":@"id",
             };
}
@end


