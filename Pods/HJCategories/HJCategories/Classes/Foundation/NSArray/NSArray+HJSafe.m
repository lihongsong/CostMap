//
//  NSArray+HJSafe.m
//  HJCategories
//
//  Created by yoser on 2017/12/19.
//

#import "NSArray+HJSafe.h"

@implementation NSArray (HJSafe)

-(id)hj_objectWithIndex:(NSUInteger)index{
    if (index <self.count) {
        return self[index];
    }else{
        return nil;
    }
}

- (NSString*)hj_stringWithIndex:(NSUInteger)index
{
    id value = [self hj_objectWithIndex:index];
    if (value == nil || value == [NSNull null] || [[value description] isEqualToString:@"<null>"])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString*)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    
    return nil;
}


- (NSNumber*)hj_numberWithIndex:(NSUInteger)index
{
    id value = [self hj_objectWithIndex:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    return nil;
}

- (NSDecimalNumber *)hj_decimalNumberWithIndex:(NSUInteger)index{
    id value = [self hj_objectWithIndex:index];
    
    if ([value isKindOfClass:[NSDecimalNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber * number = (NSNumber*)value;
        return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    } else if ([value isKindOfClass:[NSString class]]) {
        NSString * str = (NSString*)value;
        return [str isEqualToString:@""] ? nil : [NSDecimalNumber decimalNumberWithString:str];
    }
    return nil;
}

- (NSArray*)hj_arrayWithIndex:(NSUInteger)index
{
    id value = [self hj_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]])
    {
        return value;
    }
    return nil;
}


- (NSDictionary*)hj_dictionaryWithIndex:(NSUInteger)index
{
    id value = [self hj_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]])
    {
        return value;
    }
    return nil;
}

- (NSInteger)hj_integerWithIndex:(NSUInteger)index
{
    id value = [self hj_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value integerValue];
    }
    return 0;
}
- (NSUInteger)hj_unsignedIntegerWithIndex:(NSUInteger)index
{
    id value = [self hj_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value unsignedIntegerValue];
    }
    return 0;
}
- (BOOL)hj_boolWithIndex:(NSUInteger)index
{
    id value = [self hj_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value boolValue];
    }
    return NO;
}
- (int16_t)hj_int16WithIndex:(NSUInteger)index
{
    id value = [self hj_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (int32_t)hj_int32WithIndex:(NSUInteger)index
{
    id value = [self hj_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (int64_t)hj_int64WithIndex:(NSUInteger)index
{
    id value = [self hj_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value longLongValue];
    }
    return 0;
}

- (char)hj_charWithIndex:(NSUInteger)index{
    
    id value = [self hj_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value charValue];
    }
    return 0;
}

- (short)hj_shortWithIndex:(NSUInteger)index
{
    id value = [self hj_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (float)hj_floatWithIndex:(NSUInteger)index
{
    id value = [self hj_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value floatValue];
    }
    return 0;
}
- (double)hj_doubleWithIndex:(NSUInteger)index
{
    id value = [self hj_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value doubleValue];
    }
    return 0;
}

- (NSDate *)hj_dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = dateFormat;
    id value = [self hj_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    
    if ([value isKindOfClass:[NSString class]] && ![value isEqualToString:@""] && !dateFormat) {
        return [formater dateFromString:value];
    }
    return nil;
}

//CG
- (CGFloat)hj_CGFloatWithIndex:(NSUInteger)index
{
    id value = [self hj_objectWithIndex:index];
    
    CGFloat f = [value doubleValue];
    
    return f;
}

- (CGPoint)hj_pointWithIndex:(NSUInteger)index
{
    id value = [self hj_objectWithIndex:index];
    
    CGPoint point = CGPointFromString(value);
    
    return point;
}
- (CGSize)hj_sizeWithIndex:(NSUInteger)index
{
    id value = [self hj_objectWithIndex:index];
    
    CGSize size = CGSizeFromString(value);
    
    return size;
}
- (CGRect)hj_rectWithIndex:(NSUInteger)index
{
    id value = [self hj_objectWithIndex:index];
    
    CGRect rect = CGRectFromString(value);
    
    return rect;
}
@end


#pragma --mark NSMutableArray setter
@implementation NSMutableArray (HJSafe)

-(void)hj_addObj:(id)i{
    if (i!=nil) {
        [self addObject:i];
    }
}
-(void)hj_addString:(NSString*)i
{
    if (i!=nil) {
        [self addObject:i];
    }
}
-(void)hj_addBool:(BOOL)i
{
    [self addObject:@(i)];
}
-(void)hj_addInt:(int)i
{
    [self addObject:@(i)];
}
-(void)hj_addInteger:(NSInteger)i
{
    [self addObject:@(i)];
}
-(void)hj_addUnsignedInteger:(NSUInteger)i
{
    [self addObject:@(i)];
}
-(void)hj_addCGFloat:(CGFloat)f
{
    [self addObject:@(f)];
}
-(void)hj_addChar:(char)c
{
    [self addObject:@(c)];
}
-(void)hj_addFloat:(float)i
{
    [self addObject:@(i)];
}
-(void)hj_addPoint:(CGPoint)o
{
    [self addObject:NSStringFromCGPoint(o)];
}
-(void)hj_addSize:(CGSize)o
{
    [self addObject:NSStringFromCGSize(o)];
}
-(void)hj_addRect:(CGRect)o
{
    [self addObject:NSStringFromCGRect(o)];
}
@end

