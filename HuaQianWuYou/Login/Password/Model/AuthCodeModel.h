//
//  AuthCodeModel.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/6.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <Foundation/Foundation.h>

//短信验证码Model
@interface AuthCodeModel : NSObject

@end


//图形验证码Model
@interface ImageCodeModel : NSObject

/* 图片 base64 */
@property (nonatomic, copy) NSString  *outputImage;

/* 验证码唯一key     */
@property (nonatomic, copy) NSString  *serialNumber;


@end
