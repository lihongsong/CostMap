//
//  DES3Util.h
//  DES
//
//  Created by Toni on 12-12-27.
//  Copyright (c) 2012年 sinofreely. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMBase64.h"
#import <CommonCrypto/CommonCryptor.h>

static NSString *const kEncryptKey = @"1qaz!@#$";

@interface DES3Util : NSObject

// Des加密对象成为字符串
+ (NSString *)encryptObject:(id) obj;
// Des解密字符串，并转化为对象
+ (id)decryptString: (NSString *)str;
//加密方法
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
//解密方法
+(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key;
@end
