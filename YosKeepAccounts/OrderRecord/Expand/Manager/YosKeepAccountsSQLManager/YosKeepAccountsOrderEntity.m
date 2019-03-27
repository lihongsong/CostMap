#import "YosKeepAccountsOrderEntity.h"
#import <YYModel/YYModel.h>
@implementation YosKeepAccountsOrderEntity
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
- (NSString *)description { return [self yy_modelDescription]; }
#pragma mark 生成typeid用于sTypeID
- (NSString *)getTypeID:(NSString*)type {
    if ([type isEqualToString:@"餐饮"]) {
        return @"00000001";
    } else if ([type isEqualToString:@"购物"]) {
        return @"00000010";
    } else if ([type isEqualToString:@"社交"]) {
        return @"00000100";
    } else if ([type isEqualToString:@"游玩"]) {
        return @"00001000";
    } else if ([type isEqualToString:@"居家"]) {
        return @"00010000";
    } else if ([type isEqualToString:@"教育"]) {
        return @"00100000";
    } else if ([type isEqualToString:@"医疗"]) {
        return @"01000000";
    } else {
        return @"10000000";
    };
}
@end
