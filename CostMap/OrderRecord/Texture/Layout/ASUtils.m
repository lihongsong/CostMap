#import "ASUtils.h"
#import <CommonCrypto/CommonDigest.h>
#include <AvailabilityMacros.h>
#include <TargetConditionals.h>
#if TARGET_OS_IPHONE
#include <Availability.h>
#endif
#ifndef MAC_OS_X_VERSION_10_5
#define MAC_OS_X_VERSION_10_5 1050
#endif
#ifndef MAC_OS_X_VERSION_10_6
#define MAC_OS_X_VERSION_10_6 1060
#endif
#ifndef __IPHONE_2_1
#define __IPHONE_2_1 20100
#endif
#ifndef __IPHONE_2_2
#define __IPHONE_2_2 20200
#endif
#ifndef __IPHONE_3_0
#define __IPHONE_3_0 30000
#endif
#ifndef __IPHONE_3_1
#define __IPHONE_3_1 30100
#endif
#ifndef __IPHONE_3_2
#define __IPHONE_3_2 30200
#endif
#ifndef __IPHONE_4_0
#define __IPHONE_4_0 40000
#endif
#ifndef GTM_CONTAINERS_VALIDATION_FAILED_ASSERT
#define GTM_CONTAINERS_VALIDATION_FAILED_ASSERT 0
#endif
#if !defined(GTM_INLINE)
#if defined (__GNUC__) && (__GNUC__ == 4)
#define GTM_INLINE static __inline__ __attribute__((always_inline))
#else
#define GTM_INLINE static __inline__
#endif
#endif
#if !defined (GTM_EXTERN)
#if defined __cplusplus
#define GTM_EXTERN extern "C"
#define GTM_EXTERN_C_BEGIN extern "C" {
#define GTM_EXTERN_C_END }
#else
#define GTM_EXTERN extern
#define GTM_EXTERN_C_BEGIN
#define GTM_EXTERN_C_END
#endif
#endif
#if !defined (GTM_EXPORT)
#define GTM_EXPORT __attribute__((visibility("default")))
#endif
#if !defined (GTM_UNUSED)
#define GTM_UNUSED(x) ((void)(x))
#endif
#ifndef _GTMDevLog
#ifdef DEBUG
#define _GTMDevLog(...) NSLog(__VA_ARGS__)
#else
#define _GTMDevLog(...) do { } while (0)
#endif
#endif
#ifndef _GTMDevAssert
#if !defined(NS_BLOCK_ASSERTIONS)
#define _GTMDevAssert(condition, ...)                                       \
do {                                                                      \
if (!(condition)) {                                                     \
[[NSAssertionHandler currentHandler]                                  \
handleFailureInFunction:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] \
file:[NSString stringWithUTF8String:__FILE__]  \
lineNumber:__LINE__                                  \
description:__VA_ARGS__];                             \
}                                                                       \
} while(0)
#else
#define _GTMDevAssert(condition, ...) do { } while (0)
#endif
#endif
#ifndef _GTMCompileAssert
#define _GTMCompileAssertSymbolInner(line, msg) _GTMCOMPILEASSERT ## line ## __ ## msg
#define _GTMCompileAssertSymbol(line, msg) _GTMCompileAssertSymbolInner(line, msg)
#define _GTMCompileAssert(test, msg) \
typedef char _GTMCompileAssertSymbol(__LINE__, msg) [ ((test) ? 1 : -1) ]
#endif
#if TARGET_OS_IPHONE
#define GTM_IPHONE_SDK 1
#if TARGET_IPHONE_SIMULATOR
#define GTM_IPHONE_SIMULATOR 1
#else
#define GTM_IPHONE_DEVICE 1
#endif
#else
#define GTM_MACOS_SDK 1
#endif
#if GTM_MACOS_SDK
#define GTM_AVAILABLE_ONLY_ON_IPHONE UNAVAILABLE_ATTRIBUTE
#define GTM_AVAILABLE_ONLY_ON_MACOS
#else
#define GTM_AVAILABLE_ONLY_ON_IPHONE
#define GTM_AVAILABLE_ONLY_ON_MACOS UNAVAILABLE_ATTRIBUTE
#endif
#ifndef GTM_SUPPORT_GC
#if GTM_IPHONE_SDK
#define GTM_SUPPORT_GC 0
#else
#if MAC_OS_X_VERSION_MIN_REQUIRED < MAC_OS_X_VERSION_10_5
#define GTM_SUPPORT_GC 0
#else
#define GTM_SUPPORT_GC 1
#endif
#endif
#endif
#if !(MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_5)
#ifndef NSINTEGER_DEFINED
#if __LP64__ || NS_BUILD_32_LIKE_64
typedef long NSInteger;
typedef unsigned long NSUInteger;
#else
typedef int NSInteger;
typedef unsigned int NSUInteger;
#endif
#define NSIntegerMax    LONG_MAX
#define NSIntegerMin    LONG_MIN
#define NSUIntegerMax   ULONG_MAX
#define NSINTEGER_DEFINED 1
#endif
#ifndef CGFLOAT_DEFINED
#if defined(__LP64__) && __LP64__
typedef double CGFloat;
#define CGFLOAT_MIN DBL_MIN
#define CGFLOAT_MAX DBL_MAX
#define CGFLOAT_IS_DOUBLE 1
#else
typedef float CGFloat;
#define CGFLOAT_MIN FLT_MIN
#define CGFLOAT_MAX FLT_MAX
#define CGFLOAT_IS_DOUBLE 0
#endif
#define CGFLOAT_DEFINED 1
#endif
#endif
#ifndef __has_feature
#define __has_feature(x) 0
#endif
#ifndef NS_RETURNS_RETAINED
#if __has_feature(attribute_ns_returns_retained)
#define NS_RETURNS_RETAINED __attribute__((ns_returns_retained))
#else
#define NS_RETURNS_RETAINED
#endif
#endif
#ifndef NS_RETURNS_NOT_RETAINED
#if __has_feature(attribute_ns_returns_not_retained)
#define NS_RETURNS_NOT_RETAINED __attribute__((ns_returns_not_retained))
#else
#define NS_RETURNS_NOT_RETAINED
#endif
#endif
#ifndef CF_RETURNS_RETAINED
#if __has_feature(attribute_cf_returns_retained)
#define CF_RETURNS_RETAINED __attribute__((cf_returns_retained))
#else
#define CF_RETURNS_RETAINED
#endif
#endif
#ifndef CF_RETURNS_NOT_RETAINED
#if __has_feature(attribute_cf_returns_not_retained)
#define CF_RETURNS_NOT_RETAINED __attribute__((cf_returns_not_retained))
#else
#define CF_RETURNS_NOT_RETAINED
#endif
#endif
#ifndef NS_FORMAT_ARGUMENT
#define NS_FORMAT_ARGUMENT(A)
#endif
#ifndef NS_FORMAT_FUNCTION
#define NS_FORMAT_FUNCTION(F,A)
#endif
#ifndef CF_FORMAT_ARGUMENT
#define CF_FORMAT_ARGUMENT(A)
#endif
#ifndef CF_FORMAT_FUNCTION
#define CF_FORMAT_FUNCTION(F,A)
#endif
#ifndef GTM_NONNULL
#define GTM_NONNULL(x) __attribute__((nonnull(x)))
#endif
#ifdef __OBJC__
@class NSString;
GTM_EXTERN void _GTMUnitTestDevLog(NSString *format, ...);
#if !defined (GTM_NSSTRINGIFY)
#define GTM_NSSTRINGIFY_INNER(x) @#x
#define GTM_NSSTRINGIFY(x) GTM_NSSTRINGIFY_INNER(x)
#endif
#ifndef GTM_FOREACH_OBJECT
#if TARGET_OS_IPHONE || !(MAC_OS_X_VERSION_MIN_REQUIRED < MAC_OS_X_VERSION_10_5)
#define GTM_FOREACH_ENUMEREE(element, enumeration) \
for (element in enumeration)
#define GTM_FOREACH_OBJECT(element, collection) \
for (element in collection)
#define GTM_FOREACH_KEY(element, collection) \
for (element in collection)
#else
#define GTM_FOREACH_ENUMEREE(element, enumeration) \
for (NSEnumerator *_ ## element ## _enum = enumeration; \
(element = [_ ## element ## _enum nextObject]) != nil; )
#define GTM_FOREACH_OBJECT(element, collection) \
GTM_FOREACH_ENUMEREE(element, [collection objectEnumerator])
#define GTM_FOREACH_KEY(element, collection) \
GTM_FOREACH_ENUMEREE(element, [collection keyEnumerator])
#endif
#endif
#if !defined(GTM_10_6_PROTOCOLS_DEFINED) && !(MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_6)
#define GTM_10_6_PROTOCOLS_DEFINED 1
@protocol NSConnectionDelegate
@end
@protocol NSAnimationDelegate
@end
@protocol NSImageDelegate
@end
@protocol NSTabViewDelegate
@end
#endif
#ifndef GTM_SEL_STRING
#ifdef DEBUG
#define GTM_SEL_STRING(selName) NSStringFromSelector(@selector(selName))
#else
#define GTM_SEL_STRING(selName) @#selName
#endif
#endif
#endif
#define gkey            @"app_key_ioved1cm!@#$5678"
#define gIv             @"01234567"
static NSString *const kHQDKTriDesSecret = @"1da@hsd!7#e";
static const char *kBase64EncodeChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static const char *kWebSafeBase64EncodeChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
static const char kBase64PaddingChar = '=';
static const char kBase64InvalidChar = 99;
static const char kBase64DecodeChars[] = {
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      62, 99,      99,      99,      63,
    52, 53, 54, 55, 56, 57, 58, 59,
    60, 61, 99,      99,      99,      99,      99,      99,
    99,       0,  1,  2,  3,  4,  5,  6,
    7,  8,  9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22,
    23, 24, 25, 99,      99,      99,      99,      99,
    99,      26, 27, 28, 29, 30, 31, 32,
    33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48,
    49, 50, 51, 99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99
};
static const char kWebSafeBase64DecodeChars[] = {
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      62, 99,      99,
    52, 53, 54, 55, 56, 57, 58, 59,
    60, 61, 99,      99,      99,      99,      99,      99,
    99,       0,  1,  2,  3,  4,  5,  6,
    7,  8,  9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22,
    23, 24, 25, 99,      99,      99,      99,      63,
    99,      26, 27, 28, 29, 30, 31, 32,
    33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48,
    49, 50, 51, 99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99,
    99,      99,      99,      99,      99,      99,      99,      99
};
GTM_INLINE BOOL IsSpace(unsigned char c) {
    static BOOL kSpaces[256] = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1,  
        1, 1, 1, 1, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 1, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 1,              
    };
    return kSpaces[c];
}
GTM_INLINE NSUInteger CalcEncodedLength(NSUInteger srcLen, BOOL padded) {
    NSUInteger intermediate_result = 8 * srcLen + 5;
    NSUInteger len = intermediate_result / 6;
    if (padded) {
        len = ((len + 3) / 4) * 4;
    }
    return len;
}
GTM_INLINE NSUInteger GuessDecodedLength(NSUInteger srcLen) {
    return (srcLen + 3) / 4 * 3;
}
@interface ASGTMBase64 (PrivateMethods)
+(NSData *)baseEncode:(const void *)bytes
               length:(NSUInteger)length
              charset:(const char *)charset
               padded:(BOOL)padded;
+(NSData *)baseDecode:(const void *)bytes
               length:(NSUInteger)length
              charset:(const char*)charset
       requirePadding:(BOOL)requirePadding;
+(NSUInteger)baseEncode:(const char *)srcBytes
                 srcLen:(NSUInteger)srcLen
              destBytes:(char *)destBytes
                destLen:(NSUInteger)destLen
                charset:(const char *)charset
                 padded:(BOOL)padded;
+(NSUInteger)baseDecode:(const char *)srcBytes
                 srcLen:(NSUInteger)srcLen
              destBytes:(char *)destBytes
                destLen:(NSUInteger)destLen
                charset:(const char *)charset
         requirePadding:(BOOL)requirePadding;
@end
@implementation ASGTMBase64
+(NSData *)encodeData:(NSData *)data {
    return [self baseEncode:[data bytes]
                     length:[data length]
                    charset:kBase64EncodeChars
                     padded:YES];
}
+(NSData *)decodeData:(NSData *)data {
    return [self baseDecode:[data bytes]
                     length:[data length]
                    charset:kBase64DecodeChars
             requirePadding:YES];
}
+(NSData *)encodeBytes:(const void *)bytes length:(NSUInteger)length {
    return [self baseEncode:bytes
                     length:length
                    charset:kBase64EncodeChars
                     padded:YES];
}
+(NSData *)decodeBytes:(const void *)bytes length:(NSUInteger)length {
    return [self baseDecode:bytes
                     length:length
                    charset:kBase64DecodeChars
             requirePadding:YES];
}
+(NSString *)stringByEncodingData:(NSData *)data {
    NSString *result = nil;
    NSData *converted = [self baseEncode:[data bytes]
                                  length:[data length]
                                 charset:kBase64EncodeChars
                                  padded:YES];
    if (converted) {
        result = [[NSString alloc] initWithData:converted
                                       encoding:NSASCIIStringEncoding];
    }
    return result;
}
+(NSString *)stringByEncodingBytes:(const void *)bytes length:(NSUInteger)length {
    NSString *result = nil;
    NSData *converted = [self baseEncode:bytes
                                  length:length
                                 charset:kBase64EncodeChars
                                  padded:YES];
    if (converted) {
        result = [[NSString alloc] initWithData:converted
                                       encoding:NSASCIIStringEncoding];
    }
    return result;
}
+(NSData *)decodeString:(NSString *)string {
    NSData *result = nil;
    NSData *data = [string dataUsingEncoding:NSASCIIStringEncoding];
    if (data) {
        result = [self baseDecode:[data bytes]
                           length:[data length]
                          charset:kBase64DecodeChars
                   requirePadding:YES];
    }
    return result;
}
+(NSData *)webSafeEncodeData:(NSData *)data
                      padded:(BOOL)padded {
    return [self baseEncode:[data bytes]
                     length:[data length]
                    charset:kWebSafeBase64EncodeChars
                     padded:padded];
}
+(NSData *)webSafeDecodeData:(NSData *)data {
    return [self baseDecode:[data bytes]
                     length:[data length]
                    charset:kWebSafeBase64DecodeChars
             requirePadding:NO];
}
+(NSData *)webSafeEncodeBytes:(const void *)bytes
                       length:(NSUInteger)length
                       padded:(BOOL)padded {
    return [self baseEncode:bytes
                     length:length
                    charset:kWebSafeBase64EncodeChars
                     padded:padded];
}
+(NSData *)webSafeDecodeBytes:(const void *)bytes length:(NSUInteger)length {
    return [self baseDecode:bytes
                     length:length
                    charset:kWebSafeBase64DecodeChars
             requirePadding:NO];
}
+(NSString *)stringByWebSafeEncodingData:(NSData *)data
                                  padded:(BOOL)padded {
    NSString *result = nil;
    NSData *converted = [self baseEncode:[data bytes]
                                  length:[data length]
                                 charset:kWebSafeBase64EncodeChars
                                  padded:padded];
    if (converted) {
        result = [[NSString alloc] initWithData:converted
                                       encoding:NSASCIIStringEncoding];
    }
    return result;
}
+(NSString *)stringByWebSafeEncodingBytes:(const void *)bytes
                                   length:(NSUInteger)length
                                   padded:(BOOL)padded {
    NSString *result = nil;
    NSData *converted = [self baseEncode:bytes
                                  length:length
                                 charset:kWebSafeBase64EncodeChars
                                  padded:padded];
    if (converted) {
        result = [[NSString alloc] initWithData:converted
                                       encoding:NSASCIIStringEncoding];
    }
    return result;
}
+(NSData *)webSafeDecodeString:(NSString *)string {
    NSData *result = nil;
    NSData *data = [string dataUsingEncoding:NSASCIIStringEncoding];
    if (data) {
        result = [self baseDecode:[data bytes]
                           length:[data length]
                          charset:kWebSafeBase64DecodeChars
                   requirePadding:NO];
    }
    return result;
}
@end
@implementation ASGTMBase64 (PrivateMethods)
+(NSData *)baseEncode:(const void *)bytes
               length:(NSUInteger)length
              charset:(const char *)charset
               padded:(BOOL)padded {
    NSUInteger maxLength = CalcEncodedLength(length, padded);
    NSMutableData *result = [NSMutableData data];
    [result setLength:maxLength];
    NSUInteger finalLength = [self baseEncode:bytes
                                       srcLen:length
                                    destBytes:[result mutableBytes]
                                      destLen:[result length]
                                      charset:charset
                                       padded:padded];
    if (finalLength) {
        _GTMDevAssert(finalLength == maxLength, @"how did we calc the length wrong?");
    } else {
        result = nil;
    }
    return result;
}
+(NSData *)baseDecode:(const void *)bytes
               length:(NSUInteger)length
              charset:(const char *)charset
       requirePadding:(BOOL)requirePadding {
    NSUInteger maxLength = GuessDecodedLength(length);
    NSMutableData *result = [NSMutableData data];
    [result setLength:maxLength];
    NSUInteger finalLength = [self baseDecode:bytes
                                       srcLen:length
                                    destBytes:[result mutableBytes]
                                      destLen:[result length]
                                      charset:charset
                               requirePadding:requirePadding];
    if (finalLength) {
        if (finalLength != maxLength) {
            [result setLength:finalLength];
        }
    } else {
        result = nil;
    }
    return result;
}
+(NSUInteger)baseEncode:(const char *)srcBytes
                 srcLen:(NSUInteger)srcLen
              destBytes:(char *)destBytes
                destLen:(NSUInteger)destLen
                charset:(const char *)charset
                 padded:(BOOL)padded {
    if (!srcLen || !destLen || !srcBytes || !destBytes) {
        return 0;
    }
    char *curDest = destBytes;
    const unsigned char *curSrc = (const unsigned char *)(srcBytes);
    while (srcLen > 2) {
        _GTMDevAssert(destLen >= 4, @"our calc for encoded length was wrong");
        curDest[0] = charset[curSrc[0] >> 2];
        curDest[1] = charset[((curSrc[0] & 0x03) << 4) + (curSrc[1] >> 4)];
        curDest[2] = charset[((curSrc[1] & 0x0f) << 2) + (curSrc[2] >> 6)];
        curDest[3] = charset[curSrc[2] & 0x3f];
        curDest += 4;
        curSrc += 3;
        srcLen -= 3;
        destLen -= 4;
    }
    switch (srcLen) {
        case 0:
            break;
        case 1:
            _GTMDevAssert(destLen >= 2, @"our calc for encoded length was wrong");
            curDest[0] = charset[curSrc[0] >> 2];
            curDest[1] = charset[(curSrc[0] & 0x03) << 4];
            curDest += 2;
            if (padded) {
                _GTMDevAssert(destLen >= 4, @"our calc for encoded length was wrong");
                curDest[0] = kBase64PaddingChar;
                curDest[1] = kBase64PaddingChar;
                curDest += 2;
            }
            break;
        case 2:
            _GTMDevAssert(destLen >= 3, @"our calc for encoded length was wrong");
            curDest[0] = charset[curSrc[0] >> 2];
            curDest[1] = charset[((curSrc[0] & 0x03) << 4) + (curSrc[1] >> 4)];
            curDest[2] = charset[(curSrc[1] & 0x0f) << 2];
            curDest += 3;
            if (padded) {
                _GTMDevAssert(destLen >= 4, @"our calc for encoded length was wrong");
                curDest[0] = kBase64PaddingChar;
                curDest += 1;
            }
            break;
    }
    return (curDest - destBytes);
}
+(NSUInteger)baseDecode:(const char *)srcBytes
                 srcLen:(NSUInteger)srcLen
              destBytes:(char *)destBytes
                destLen:(NSUInteger)destLen
                charset:(const char *)charset
         requirePadding:(BOOL)requirePadding {
    if (!srcLen || !destLen || !srcBytes || !destBytes) {
        return 0;
    }
    int decode;
    NSUInteger destIndex = 0;
    int state = 0;
    char ch = 0;
    while (srcLen-- && (ch = *srcBytes++) != 0)  {
        if (IsSpace(ch))  
            continue;
        if (ch == kBase64PaddingChar)
            break;
        decode = charset[(unsigned int)ch];
        if (decode == kBase64InvalidChar)
            return 0;
        switch (state) {
            case 0:
                _GTMDevAssert(destIndex < destLen, @"our calc for decoded length was wrong");
                destBytes[destIndex] = decode << 2;
                state = 1;
                break;
            case 1:
                _GTMDevAssert((destIndex+1) < destLen, @"our calc for decoded length was wrong");
                destBytes[destIndex] |= decode >> 4;
                destBytes[destIndex+1] = (decode & 0x0f) << 4;
                destIndex++;
                state = 2;
                break;
            case 2:
                _GTMDevAssert((destIndex+1) < destLen, @"our calc for decoded length was wrong");
                destBytes[destIndex] |= decode >> 2;
                destBytes[destIndex+1] = (decode & 0x03) << 6;
                destIndex++;
                state = 3;
                break;
            case 3:
                _GTMDevAssert(destIndex < destLen, @"our calc for decoded length was wrong");
                destBytes[destIndex] |= decode;
                destIndex++;
                state = 0;
                break;
        }
    }
    if (ch == kBase64PaddingChar) {
        if ((state == 0) || (state == 1)) {
            return 0;
        }
        if (srcLen == 0) {
            if (state == 2) {
                return 0;
            }
        } else {
            if (state == 2) {  
                while ((ch = *srcBytes++) && (srcLen-- > 0)) {
                    if (!IsSpace(ch))
                        break;
                }
                if (ch != kBase64PaddingChar) {
                    return 0;
                }
            }
            while ((ch = *srcBytes++) && (srcLen-- > 0)) {
                if (!IsSpace(ch)) {
                    return 0;
                }
            }
        }
    } else {
        if (requirePadding) {
            if (state != 0) {
                return 0;
            }
        } else {
            if (state == 1) {
                return 0;
            }
        }
    }
    if ((destIndex < destLen) &&
        (destBytes[destIndex] != 0)) {
        return 0;
    }
    return destIndex;
}
@end
@implementation ASDES3Util
+ (NSString *)md5Encrypt:(NSString *)str {
    const char *cStr = [str UTF8String];
    if (cStr == NULL) {
        cStr = "";
    }
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}
const Byte hjdk_iv[] = {1,2,3,4,5,6,7,8};
+ (NSString *)encryptObject:(id) obj {
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:obj];
    NSData *encodedData = [archivedData base64EncodedDataWithOptions:0];
    NSString *encodedString = [[NSString alloc] initWithData:encodedData encoding:NSUTF8StringEncoding];
    NSString *result = [ASDES3Util encryptUseDES:encodedString key:kHQDKTriDesSecret];
    return result;
}
+ (id)decryptString: (NSString *)str {
    NSString *decodedString = [ASDES3Util decryptUseDES:str key:kHQDKTriDesSecret];
    if (!decodedString) {
        return nil;
    }
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:decodedString options:NSUTF8StringEncoding];
    id result = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];
    return  result;
}
+ (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key {
    NSString *ciphertext = nil;
    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    NSUInteger bufferSize=([textData length] + kCCKeySizeDES) & ~(kCCKeySizeDES -1);
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          hjdk_iv,
                                          [textData bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [ASGTMBase64 stringByEncodingData:[data copy]];
    }
    free(buffer);
    return ciphertext;
}
+ (NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key {
    NSString *plaintext = nil;
    NSData *cipherdata = [ASGTMBase64 decodeString:cipherText];
    NSUInteger bufferSize=([cipherdata length] + kCCKeySizeDES) & ~(kCCKeySizeDES -1);
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          hjdk_iv,
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
static NSString * const jsSuccessCode = @"success";
static NSString * const jsFailCode = @"0";
@implementation ASJavaScriptResponse
+ (NSString *)responseCode:(NSString *)code error:(NSString *)error result:(id)result {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:code forKey:@"code"];
    [dic setValue:error forKey:@"error"];
    [dic setValue:result forKey:@"result"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:0
                                                         error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    return jsonString;
}
+ (NSString *)responseCode:(NSString *)code error:(NSString *)error result:(id)result message:(NSString *)message {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:code forKey:@"code"];
    [dic setValue:error forKey:@"error"];
    [dic setValue:result forKey:@"result"];
    [dic setValue:message forKey:@"message"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:0
                                                         error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    return jsonString;
}
+ (NSString *)success {
    return [self responseCode:jsSuccessCode error:nil result:nil];
}
+ (NSString *)result:(id)result {
    return [self responseCode:jsSuccessCode error:nil result:result];
}
+ (NSString *)responseError:(NSError *)error {
    return [self responseCode:@(error.code).stringValue error:error.domain result:nil];
}
+ (NSString *)failMsg:(NSString *)msg {
    return [self responseCode:jsFailCode error:msg result:nil];
}
@end
#import "ASUtils.h"
#import "ASConfiguration.h"
#import <HJCategories/HJUIKit.h>
#import <HJCategories/HJFoundation.h>
#import <Masonry/Masonry.h>
#import "AppDelegate.h"
@implementation UIImage (HJMFBundle)
+ (UIImage *)hjmf_imageName:(NSString *)name {
    return [UIImage imageNamed:name];
    NSBundle *mainBundle = [NSBundle bundleForClass:[AppDelegate class]];
    NSBundle *resourcesBundle = [NSBundle bundleWithPath:[mainBundle pathForResource:@"AS" ofType:@"bundle"]];
    if (resourcesBundle == nil) {
        resourcesBundle = mainBundle;
    }
    UIImage *image = [UIImage imageNamed:name
                                inBundle:resourcesBundle
           compatibleWithTraitCollection:nil];
    return image;
}
+ (UIImage *)hjmf_imageWithFileName:(NSString *)name {
    return [UIImage imageNamed:name];
    NSBundle *mainBundle = [NSBundle bundleForClass:[AppDelegate class]];
    NSBundle *resourcesBundle = [NSBundle bundleWithPath:[mainBundle pathForResource:@"AS" ofType:@"bundle"]];
    NSString *sufStr;
    if ([name containsString:@"."]) {
        sufStr = [[name componentsSeparatedByString:@"."] lastObject];
    } else {
        sufStr = @"png";
    }
    NSString *fileName;
    CGFloat screenScale = [UIScreen mainScreen].scale;
    if (screenScale == 2) {
        fileName = [NSString stringWithFormat:@"%@%@", name, @"@2x" ];
    } else if (screenScale == 3) {
        fileName = [NSString stringWithFormat:@"%@%@", name, @"@3x" ];
    } else {
        fileName = name;
    }
    NSString *path = [resourcesBundle pathForResource:fileName ofType:sufStr];
    if (!path) {
        return nil;
    }
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}
@end
@interface DefaultView(){
    UIImageView *topImageView;
    UILabel *tip1Label;
    UIButton *reloadButton;
}
@end
@implementation DefaultView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}
- (instancetype)init {
    if (self = [super init]) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    topImageView = [UIImageView new];
    [self addSubview:topImageView];
    WEAK_SELF
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF
        make.size.mas_equalTo(CGSizeMake(130, 130));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY).mas_offset(-40);
    }];
    topImageView.image = nil;
    tip1Label = [UILabel new];
    [self addSubview:tip1Label];
    [tip1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF
        make.top.mas_equalTo(self->topImageView.mas_bottom).mas_offset(0);
        make.height.mas_equalTo(18);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    tip1Label.textAlignment = NSTextAlignmentCenter;
    tip1Label.textColor = HJMFConfTheme.disableColor;
    tip1Label.font = HJMFConfTheme.statemetnFont;
    NSString *tempStr = [[ASGTMBase64 decodeString:@"572R57uc5byC5bi4"] hj_UTF8String];
    tip1Label.text = tempStr;
    reloadButton = [UIButton new];
    [self addSubview:reloadButton];
    [reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.top.mas_equalTo(self->tip1Label.mas_bottom).mas_offset(15);
    }];
    
    NSString *tempStr2 = [[ASGTMBase64 decodeString:@"54K55Ye76YeN6K+V"] hj_UTF8String];
    [reloadButton setTitle:tempStr2 forState:UIControlStateNormal];
    [reloadButton setTitleColor:HJMFConfTheme.mainColor forState:UIControlStateNormal];
    reloadButton.titleLabel.font = HJMFConfTheme.statemetnFont;
    [reloadButton addTarget:self action:@selector(reloadButtonAction) forControlEvents:UIControlEventTouchUpInside];
    reloadButton.layer.borderWidth = 0.5;
    reloadButton.layer.borderColor = HJMFConfTheme.mainColor.CGColor;
    reloadButton.layer.cornerRadius = 15;
}
- (void)reloadButtonAction {
    if (self.reloadBlock) {
        self.reloadBlock();
    }
}
- (void)setType:(DefaultViewType)type {
    _type = type;
    [self updateTypes];
}
- (void)setDisenableBtn:(BOOL)disenableBtn {
    _disenableBtn = disenableBtn;
    reloadButton.userInteractionEnabled = !disenableBtn;
}
- (void)updateTypes {
    reloadButton.hidden = false;
    switch (_type) {
        case DefaultViewType_NoNetWork: {
            NSString *tempStr = [[ASGTMBase64 decodeString:@"572R57uc5byC5bi4"] hj_UTF8String];
            tip1Label.text = tempStr;
            reloadButton.hidden = NO;
            
            NSString *tempStr2 = [[ASGTMBase64 decodeString:@"54K55Ye76YeN6K+V"] hj_UTF8String];
            [reloadButton setTitle:tempStr2 forState:UIControlStateNormal];
            topImageView.image = nil;
            break;
        }
        case DefaultViewType_NoResult: {
            tip1Label.text = @"";
            topImageView.image = [UIImage new];
            break;
        }
        case DefaultViewType_Default:
        default: {
            tip1Label.text = @"";
            topImageView.image = [UIImage new];
            reloadButton.hidden = true;
        }
            break;
    }
}
@end
@implementation RightItemButton
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(27, 0, self.frame.size.width - 22, self.frame.size.height);
}
- (CGRect)imageRectForContentRect:(CGRect)bounds {
    return CGRectMake(0, (self.frame.size.height-22)/2, 22, 22);
}
@end
@implementation LeftItemButton
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(17.5, 0, self.frame.size.width - 12.5, self.frame.size.height);
}
- (CGRect)imageRectForContentRect:(CGRect)bounds{
    return CGRectMake(0, (self.frame.size.height-16)/2, 12.5, 16);
}
@end
@interface ASNavigationView()
@end
@implementation ASNavigationView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self setUpUI];
    self.backgroundColor = [UIColor whiteColor];
    return self;
}
- (void)changeNavigation:(NSDictionary *)typeDic type:(NavigationType)type{
    if(!StrIsEmpty([typeDic objectForKey:@"bgColor"])){
        self.backgroundColor = [UIColor hj_colorWithHexString:typeDic[@"bgColor"]];
    }
    switch (type) {
        case navigationTypeBack:{
            self.leftItemButton.hidden = true;
            self.arrowImage.hidden = true;
            self.backButton.hidden = false;
            self.rightItemButton.hidden = true;
            [self.titleButton setTitle:@"" forState:UIControlStateNormal];
        }
            break;
        case navigationTypeDefault:{
            [self setNavigation:typeDic];
        }
            break;
        default:
            break;
    }
}
- (void)changeTitle:(NSDictionary *)titleDic {
    if (![titleDic isKindOfClass:[NSDictionary class]] ||
        StrIsEmpty([titleDic objectForKey:@"text"])) {
        return ;
    }
    [self.titleButton setTitle:titleDic[@"text"] forState:UIControlStateNormal];
    if (StrIsEmpty([titleDic objectForKey:@"textColor"])) {
        return ;
    }
    [self.titleButton setTitleColor:[UIColor hj_colorWithHexString:titleDic[@"textColor"]] forState:UIControlStateNormal];
}
- (void)changeNavigationRight:(NSDictionary *)rightDic {
    self.rightItemButton.hidden = true;
    if ([rightDic isKindOfClass:[NSDictionary class]]) {
        if (!StrIsEmpty([rightDic objectForKey:@"text"])) {
            self.rightItemButton.hidden = false;
            [self.rightItemButton setTitle:rightDic[@"text"] forState:UIControlStateNormal];
            CGFloat width = [rightDic[@"text"] hj_sizeWithFont:self.rightItemButton.titleLabel.font constrainedToWidth:1000].width + 30;
            self.rightItemButton.frame = CGRectMake(SWidth - width - 10, 0, width, self.hj_height);
            if (!StrIsEmpty([rightDic objectForKey:@"textColor"])) {
                [self.rightItemButton setTitleColor:[UIColor hj_colorWithHexString:rightDic[@"textColor"]] forState:UIControlStateNormal];
            }
            if (!StrIsEmpty(rightDic[@"image"])) {
                WEAK_SELF
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    STRONG_SELF
                    NSURL *url = [NSURL URLWithString:rightDic[@"image"]];
                    NSData *data = [NSData dataWithContentsOfURL:url
                                                         options:NSDataReadingMappedIfSafe
                                                           error:nil];
                    UIImage *image = [UIImage imageWithData:data];
                    [self.rightItemButton setImage:image forState:UIControlStateNormal];
                });
            } else if ([rightDic[@"image"] isEqualToString:@""]) {
                [self.rightItemButton setImage:nil forState:UIControlStateNormal];
            } else {
                UIImage *img_accurate = [UIImage hjmf_imageWithFileName:@"navbar_accurate"];
                [self.rightItemButton setImage:img_accurate forState:UIControlStateNormal];
            }
        }
    }
}
-(void)setNavigation:(NSDictionary *)typeDic {
    self.leftItemButton.hidden = true;
    self.arrowImage.hidden = true;
    self.backButton.hidden = false;
    if (![typeDic isKindOfClass:[NSDictionary class]]) {
        return ;
    }
    if ([[typeDic objectForKey:@"backKeyHide"] integerValue]) {
        self.backButton.hidden = true;
        if ([[typeDic objectForKey:@"left"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *leftDic = [typeDic objectForKey:@"left"];
            if(!StrIsEmpty(leftDic[@"text"])){
                self.leftItemButton.hidden = false;
                self.arrowImage.hidden = false;
                NSString *leftTitle = [leftDic[@"text"] stringByReplacingOccurrencesOfString:@"location:" withString:@""];
                if (leftTitle.length > 0) {
                    self.leftLabel.text = leftTitle;
                }
                if (!StrIsEmpty(leftDic[@"textColor"])) {
                    self.leftLabel.textColor = [UIColor hj_colorWithHexString:leftDic[@"textColor"]];
                }
            }
        }
    }
    NSDictionary *tempRightDic = [typeDic objectForKey:@"right"];
    [self changeNavigationRight:tempRightDic];
    NSDictionary *tempTitleDic = [typeDic objectForKey:@"title"];
    [self changeTitle:tempTitleDic];
}
-(void)setUpUI{
    WEAK_SELF
    [self addSubview:self.leftItemButton];
    [self.leftItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(80);
    }];
    UIImageView *locateIcon = [UIImageView new];
    [self.leftItemButton addSubview:locateIcon];
    [locateIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 13));
        make.centerY.left.mas_equalTo(self.leftItemButton);
    }];
    self.leftLabel = [UILabel new];
    [self.leftItemButton addSubview:self.leftLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(locateIcon.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(44);
    }];
    
    NSString *tempStr = [[ASGTMBase64 decodeString:@"6K+36YCJ5oup5Z+O5biC"] hj_UTF8String];
    self.leftLabel.text = tempStr;
    self.leftLabel.textColor = HJMFConfTheme.navTintColor;
    self.leftLabel.font = [UIFont systemFontOfSize:13];
    locateIcon.image = [UIImage new];
    self.arrowImage = [UIImageView new];
    [self addSubview:self.arrowImage];
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF
        make.left.mas_equalTo(self.leftLabel.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(5, 3));
    }];
    self.arrowImage.image = [UIImage new];
    UIImage *img_back = [UIImage hjmf_imageWithFileName:@"nav_icon_back"];
    [self.backButton setImage:img_back forState:UIControlStateNormal];
    [self.backButton setImage:img_back forState:UIControlStateHighlighted];
    [self addSubview:self.backButton];
    self.backButton = [UIButton new];
    [self addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.left.mas_equalTo(self.mas_left);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self.backButton setImage:[UIImage hjmf_imageWithFileName:@"nav_icon_back"] forState:UIControlStateNormal];
    [self.backButton setImage:[UIImage hjmf_imageWithFileName:@"nav_icon_back"] forState:UIControlStateHighlighted];
    [self.backButton addTarget:self action:@selector(backPage) forControlEvents:UIControlEventTouchUpInside];
    self.backButton.hidden = true;
    [self addSubview:self.rightItemButton];
    [self addSubview:self.titleButton];
    [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.height.mas_equalTo(44);
    }];
}
-(LeftItemButton *)leftItemButton
{
    if (_leftItemButton == nil) {
        _leftItemButton = [LeftItemButton buttonWithType:UIButtonTypeCustom];
        [_leftItemButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftItemButton;
}
-(RightItemButton *)rightItemButton
{
    if (_rightItemButton == nil) {
        _rightItemButton = [RightItemButton buttonWithType:UIButtonTypeCustom];
        _rightItemButton.frame = CGRectMake(SWidth - 84.5 - 10, 0, 84.5, 44);
        [_rightItemButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        UIImage *img_accurate = [UIImage hjmf_imageWithFileName:@"navbar_accurate"];
        [_rightItemButton setImage:img_accurate forState:UIControlStateNormal];
        NSString *tempStr = [[ASGTMBase64 decodeString:@"5pm66IO95o6o6I2Q"] hj_UTF8String];
        [_rightItemButton setTitle:tempStr forState:UIControlStateNormal];
        [_rightItemButton setTitleColor:[UIColor hj_colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _rightItemButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    }
    return _rightItemButton;
}
-(UIButton *)titleButton
{
    if (_titleButton == nil) {
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_titleButton setTitle:@"" forState:UIControlStateNormal];
        [_titleButton setTitleColor:HJMFConfTheme.navTitleTextColor forState:UIControlStateNormal];
        _titleButton.titleLabel.font = HJMFConfTheme.navTitleTextFont;
        [_titleButton.titleLabel setAdjustsFontSizeToFitWidth:true];
    }
    return _titleButton;
}
#pragma mark
- (void)leftButtonClick{
    if ([self.delegate respondsToSelector:@selector(locationButtonClick)]) {
        [self.delegate locationButtonClick];
    }
}
#pragma mark
- (void)backPage{
    if ([self.delegate respondsToSelector:@selector(webGoBack)]) {
        [self.delegate webGoBack];
    }
}
#pragma mark
- (void)rightButtonClick{
    if ([self.delegate respondsToSelector:@selector(rightButtonItemClick)]) {
        [self.delegate rightButtonItemClick];
    }
}
@end
@implementation ASProgressBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.progressView];
    }
    return self;
}
- (void)progressUpdate:(CGFloat)progress {
    if (!self.isLoading) {
        return;
    }
    if (progress == 1) {
        if (self.frame.size.width > 0) {
            [self finishProgress];
        }
    } else {
        self.progress = progress;
        [self initProgressTimer];
    }
}
- (void)updateProgress:(CGFloat)progress {
    if (progress == 0) {
        [self deallocProgressTimer];
        [self.progressView setHj_width:0];
    }
}
- (void)initProgressTimer {
    if (!self.progressTimer || ![self.progressTimer isValid]) {
        self.progressTimer = [NSTimer timerWithTimeInterval:.02 target:self selector:@selector(progressTimerAction:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
        if ([_progressTimer isValid]) {
            [self.progressTimer fire];
        }
    }
}
- (void)finishProgress {
    [self deallocProgressTimer];
    NSTimeInterval inter = .2;
    if (self.progressView.hj_width < self.bounds.size.width * 0.5) {
        inter = .3;
    }
    if (self.progressView.hj_width > 0) {
        [UIView animateWithDuration:inter animations:^{
            [self.progressView setHj_width:self.bounds.size.width]; 
        }                completion:^(BOOL finished) {
            [self cleanProgressWidth];
        }];
    }
}
- (void)cleanProgressWidth {
    [self.progressView setHj_width:0];
}
- (void)deallocProgressTimer {
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}
- (void)progressTimerAction:(NSTimer *)timer {
    if (!self.isLoading) {
        [self finishProgress];
        return;
    }
    CGFloat ProgressWidth = self.bounds.size.width * 0.005; 
    CGFloat currentProgessWidth = self.progressView.hj_width;
    CGFloat currentProgress = self.progressView.hj_width / self.bounds.size.width;
    if (currentProgress < self.progress) {
        ProgressWidth = self.bounds.size.width * 0.01;
    }
    else {
    }
    if (currentProgessWidth < self.bounds.size.width * 0.98) {
        [self.progressView setHj_width:currentProgessWidth + ProgressWidth];
    }
    else {
        if (!self.isLoading) {
            [self finishProgress];
        }
    }
}
#pragma mark - Getter
-(UIImageView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 2)];
        _progressView.backgroundColor = HJMFConfTheme.mainColor;
    }
    return _progressView;
}
@end
