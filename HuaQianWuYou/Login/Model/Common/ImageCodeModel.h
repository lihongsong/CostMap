//
//  ImageCodeModel.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/16.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "BaseModel.h"

@interface ImageCodeModel : BaseModel
//图形验证码Model

/* 图片 base64 */
@property (nonatomic, copy) NSString  *outputImage;

/* 验证码唯一key     */
@property (nonatomic, copy) NSString  *serialNumber;

/*     */
@property (nonatomic, copy) NSString  *reqId;

/*     */
@property (nonatomic, copy) NSString  *respDateTime;

@end
