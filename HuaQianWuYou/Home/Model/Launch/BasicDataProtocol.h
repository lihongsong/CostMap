//
//  BasicDataProtocol.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/2.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BasicDataProtocol <NSObject>
@required
@property (nonatomic, copy) NSString  *address;

/* 广告图片存储路径 */
@property (nonatomic, copy) NSString  *imgUrl;

/* 产品名称 */
@property (nonatomic, copy) NSString  *description;

/* 产品id */
@property (nonatomic, strong) NSNumber  *productId;

/* 产品分类中的排序 */
@property (nonatomic, strong) NSNumber   *sort;

/* 1：请求分类列表 2：请求H5页面 */
@property (nonatomic, strong) NSNumber   *type;
@end
