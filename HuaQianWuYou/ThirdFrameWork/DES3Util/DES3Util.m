//
//  DES3Util.m
//  DES
//
//  Created by Toni on 12-12-27.
//  Copyright (c) 2012年 sinofreely. All rights reserved.
//

#import "DES3Util.h"

#define gkey            @"app_key_ioved1cm!@#$5678"
#define gIv             @"01234567"

static NSString *const TriDesSecretKey = @"1da@hsd!7#e";

@implementation DES3Util


 const Byte iv[] = {1,2,3,4,5,6,7,8};

// Des加密对象成为字符串
+ (NSString *)encryptObject:(id) obj {
    
    // 将obj转化为NSString
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:obj];
    NSData *encodedData = [archivedData base64EncodedDataWithOptions:0];
    NSString *encodedString = [[NSString alloc] initWithData:encodedData encoding:NSUTF8StringEncoding];
    NSString *result = [DES3Util encryptUseDES:encodedString key:TriDesSecretKey];
    
    return result;
}

// Des解密字符串，并转化为对象
+ (id)decryptString: (NSString *)str {
    
    NSString *decodedString = [DES3Util decryptUseDES:str key:TriDesSecretKey];
    if (!decodedString) {
        return nil;
    }
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:decodedString options:NSUTF8StringEncoding];
    
    id result = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];
    return  result;
}

//Des加密
 +(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key
 {
    
     NSString *ciphertext = nil;
     NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
     NSUInteger dataLength = [textData length];
     NSUInteger bufferSize=([textData length] + kCCKeySizeDES) & ~(kCCKeySizeDES -1);
//     unsigned char buffer[bufferSize];
     void *buffer = malloc(bufferSize);
//     memset(buffer, 0, sizeof(char));
     size_t numBytesEncrypted = 0;
     CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                                kCCOptionPKCS7Padding,
                                              [key UTF8String], kCCKeySizeDES,
                                                            iv,
                                                [textData bytes], dataLength,
                                                        buffer, bufferSize,
                                                    &numBytesEncrypted);
         if (cryptStatus == kCCSuccess) {
                 NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
                 ciphertext = [GTMBase64 stringByEncodingData:[data copy]];
             }
     free(buffer);
         return ciphertext;
     }



//Des解密
 +(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key
 {
         NSString *plaintext = nil;
         NSData *cipherdata = [GTMBase64 decodeString:cipherText];
         NSUInteger bufferSize=([cipherdata length] + kCCKeySizeDES) & ~(kCCKeySizeDES -1);
//         unsigned char buffer[bufferSize];
//         memset(buffer, 0, sizeof(char));
        void *buffer = malloc(bufferSize);
         size_t numBytesDecrypted = 0;
         CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                                           kCCOptionPKCS7Padding,
                                                           [key UTF8String], kCCKeySizeDES,
                                                           iv,
                                                           [cipherdata bytes], [cipherdata length],
                                                           buffer, bufferSize,
                                                           &numBytesDecrypted);
         if(cryptStatus == kCCSuccess)
         {
                NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
                 plaintext = [[NSString alloc]initWithData:[plaindata copy] encoding:NSUTF8StringEncoding];
         }
     free(buffer);
     return plaintext;
     }


@end
