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
        return @"1234";
    } else if ([type isEqualToString:@"购物"]) {
        return @"1235";
    } else if ([type isEqualToString:@"交友"]) {
        return @"1236";
    } else if ([type isEqualToString:@"游玩"]) {
        return @"1237";
    } else if ([type isEqualToString:@"居家"]) {
        return @"1238";
    } else if ([type isEqualToString:@"教育"]) {
        return @"1239";
    } else if ([type isEqualToString:@"医疗"]) {
        return @"1240";
    } else {
        return @"1241";
    };
}
@end
