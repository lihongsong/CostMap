//
//  NSArray+HJSafe.h
//  HJCategories
//
//  Created by yoser on 2017/12/19.
//

#import <Foundation/Foundation.h>

@interface NSArray (HJSafe)

-(id)hj_objectWithIndex:(NSUInteger)index;

- (NSString*)hj_stringWithIndex:(NSUInteger)index;

- (NSNumber*)hj_numberWithIndex:(NSUInteger)index;

- (NSDecimalNumber *)hj_decimalNumberWithIndex:(NSUInteger)index;

- (NSArray*)hj_arrayWithIndex:(NSUInteger)index;

- (NSDictionary*)hj_dictionaryWithIndex:(NSUInteger)index;

- (NSInteger)hj_integerWithIndex:(NSUInteger)index;

- (NSUInteger)hj_unsignedIntegerWithIndex:(NSUInteger)index;

- (BOOL)hj_boolWithIndex:(NSUInteger)index;

- (int16_t)hj_int16WithIndex:(NSUInteger)index;

- (int32_t)hj_int32WithIndex:(NSUInteger)index;

- (int64_t)hj_int64WithIndex:(NSUInteger)index;

- (char)hj_charWithIndex:(NSUInteger)index;

- (short)hj_shortWithIndex:(NSUInteger)index;

- (float)hj_floatWithIndex:(NSUInteger)index;

- (double)hj_doubleWithIndex:(NSUInteger)index;

- (NSDate *)hj_dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat;
//CG
- (CGFloat)hj_CGFloatWithIndex:(NSUInteger)index;

- (CGPoint)hj_pointWithIndex:(NSUInteger)index;

- (CGSize)hj_sizeWithIndex:(NSUInteger)index;

- (CGRect)hj_rectWithIndex:(NSUInteger)index;
@end


#pragma --mark NSMutableArray setter

@interface NSMutableArray(HJSafe)

-(void)hj_addObj:(id)i;

-(void)hj_addString:(NSString*)i;

-(void)hj_addBool:(BOOL)i;

-(void)hj_addInt:(int)i;

-(void)hj_addInteger:(NSInteger)i;

-(void)hj_addUnsignedInteger:(NSUInteger)i;

-(void)hj_addCGFloat:(CGFloat)f;

-(void)hj_addChar:(char)c;

-(void)hj_addFloat:(float)i;

-(void)hj_addPoint:(CGPoint)o;

-(void)hj_addSize:(CGSize)o;

-(void)hj_addRect:(CGRect)o;
@end

