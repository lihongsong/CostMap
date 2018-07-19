//
//  DiscoverDetailModel.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/22.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoverDetailModel : NSObject
@property (nonatomic,copy) NSString *articalId;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *theme;
@property (nonatomic,copy) NSString *come_from;
@property (nonatomic,copy) NSString *from_path;
@property (nonatomic,copy) NSString *thumb_img_path;
@property (nonatomic,copy) NSString *original_img_path;
@property (nonatomic,copy) NSString *big_img_path;
@property (nonatomic,copy) NSString *create_time;
@property (nonatomic,copy) NSString *update_time;
@property (nonatomic,copy) NSString *read_num;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *is_banner;
@property (nonatomic,copy) NSString *is_show;
@end
