//
//  DiscoverPageModel.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/21.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BannerModel, DiscoverItemModel;

@interface DiscoverPageModel : NSObject

/**
 发现列表
 */
@property(nonatomic, strong) NSArray <DiscoverItemModel *> *discoverList;

/**
 banner数据
 */
@property(nonatomic, strong) NSArray <BannerModel *> *banner;
@end

@interface BannerModel : NSObject

/**
 图片Url
 */
@property(nonatomic, copy) NSString *bigImageUrl;

/**
 阅读量
 */
@property(nonatomic, copy) NSString *readers;

/**
 小图
 */
@property(nonatomic, copy) NSString *smallImageUrl;

/**
 发布时间
 */
@property(nonatomic, copy) NSString *time;

/**
 banner底部文章名
 */
@property(nonatomic, copy) NSString *title;

/**
 articalId
 */
@property(nonatomic, copy) NSString *articalId;
@end

@interface DiscoverItemModel : NSObject

/**
 详情页大图片
 */
@property(nonatomic, copy) NSString *bigImageUrl;

/**
 阅读量
 */
@property(nonatomic, copy) NSString *readers;

/**
 列表图片
 */
@property(nonatomic, copy) NSString *smallImageUrl;

/**
 发布时间
 */
@property(nonatomic, copy) NSString *time;

/**
 标题
 */
@property(nonatomic, copy) NSString *title;

/**
 articalId
 */
@property(nonatomic, copy) NSString *articalId;
@end
