//
//  NSUserDefaults+HJSafe.h
//  HJCategories
//
//  Created by yoser on 2017/12/19.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (HJSafe)

#define HJ_UF_SetObjc(_value,_key) [NSUserDefaults hj_setObject:_value forKey:_key]

#define HJ_UF_GetObc(_key) [NSUserDefaults hj_objectforKey:_key]

+ (NSString *)hj_stringForKey:(NSString *)defaultName;

+ (NSArray *)hj_arrayForKey:(NSString *)defaultName;

+ (NSDictionary *)hj_dictionaryForKey:(NSString *)defaultName;

+ (NSData *)hj_dataForKey:(NSString *)defaultName;

+ (NSArray *)hj_stringArrayForKey:(NSString *)defaultName;

+ (NSInteger)hj_integerForKey:(NSString *)defaultName;

+ (float)hj_floatForKey:(NSString *)defaultName;

+ (double)hj_doubleForKey:(NSString *)defaultName;

+ (BOOL)hj_boolForKey:(NSString *)defaultName;

+ (NSURL *)hj_URLForKey:(NSString *)defaultName;

#pragma mark - WRITE FOR STANDARD

+ (void)hj_setObject:(id)value forKey:(NSString *)defaultName;

#pragma mark - WRITE ARCHIVE FOR STANDARD

+ (id)hj_objectforKey:(NSString *)defaultName;

#pragma mark - WRITE ARCHIVE FOR STANDARD

+ (void)hj_setArcObject:(id)value forKey:(NSString *)defaultName;

#pragma mark - READ ARCHIVE FOR STANDARD

+ (id)hj_arcObjectForKey:(NSString *)defaultName;



@end
