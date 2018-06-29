//
//  NSDictionary+HJSafe.h
//  HJCategories
//
//  Created by yoser on 2017/12/19.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (HJSafe)

- (BOOL)hj_hasKey:(NSString *)key;

- (NSString*)hj_stringForKey:(id)key;

- (NSNumber*)hj_numberForKey:(id)key;

- (NSDecimalNumber *)hj_decimalNumberForKey:(id)key;

- (NSArray*)hj_arrayForKey:(id)key;

- (NSDictionary*)hj_dictionaryForKey:(id)key;

- (NSInteger)hj_integerForKey:(id)key;

- (NSUInteger)hj_unsignedIntegerForKey:(id)key;

- (BOOL)hj_boolForKey:(id)key;

- (int16_t)hj_int16ForKey:(id)key;

- (int32_t)hj_int32ForKey:(id)key;

- (int64_t)hj_int64ForKey:(id)key;

- (char)hj_charForKey:(id)key;

- (short)hj_shortForKey:(id)key;

- (float)hj_floatForKey:(id)key;

- (double)hj_doubleForKey:(id)key;

- (long long)hj_longLongForKey:(id)key;

- (unsigned long long)hj_unsignedLongLongForKey:(id)key;

- (NSDate *)hj_dateForKey:(id)key dateFormat:(NSString *)dateFormat;

//CG
- (CGFloat)hj_CGFloatForKey:(id)key;

- (CGPoint)hj_pointForKey:(id)key;

- (CGSize)hj_sizeForKey:(id)key;

- (CGRect)hj_rectForKey:(id)key;

@end

@interface NSMutableDictionary(SafeAccess)

-(void)hj_setObj:(id)i forKey:(NSString*)key;

-(void)hj_setString:(NSString*)i forKey:(NSString*)key;

-(void)hj_setBool:(BOOL)i forKey:(NSString*)key;

-(void)hj_setInt:(int)i forKey:(NSString*)key;

-(void)hj_setInteger:(NSInteger)i forKey:(NSString*)key;

-(void)hj_setUnsignedInteger:(NSUInteger)i forKey:(NSString*)key;

-(void)hj_setCGFloat:(CGFloat)f forKey:(NSString*)key;

-(void)hj_setChar:(char)c forKey:(NSString*)key;

-(void)hj_setFloat:(float)i forKey:(NSString*)key;

-(void)hj_setDouble:(double)i forKey:(NSString*)key;

-(void)hj_setLongLong:(long long)i forKey:(NSString*)key;

-(void)hj_setPoint:(CGPoint)o forKey:(NSString*)key;

-(void)hj_setSize:(CGSize)o forKey:(NSString*)key;

-(void)hj_setRect:(CGRect)o forKey:(NSString*)key;
@end

