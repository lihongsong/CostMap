//
//  AuthCodeModel.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/6.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <Foundation/Foundation.h>
#define LoginType   @"21"
#define FixPassword   @"31"

//短信验证码Model
@interface AuthCodeModel : NSObject

///* 流水号 */
//@property (nonatomic, strong) NSString  *body;
//
///* 校验图形验证码结果result */
//@property (nonatomic, assign) BOOL  result;

@end


//图形验证码Model
@interface ImageCodeModel : NSObject

/* 图片 base64 */
@property (nonatomic, copy) NSString  *outputImage;

/* 验证码唯一key     */
@property (nonatomic, copy) NSString  *serialNumber;

/*     */
@property (nonatomic, copy) NSString  *reqId;

/*     */
@property (nonatomic, copy) NSString  *respDateTime;
@end
