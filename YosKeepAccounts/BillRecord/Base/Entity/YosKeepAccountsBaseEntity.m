#import "YosKeepAccountsBaseEntity.h"
#import <objc/runtime.h>
@implementation YosKeepAccountsBaseEntity
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"");
}
- (NSDictionary *) descriptionMehtod:(id)obj{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    u_int count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    for (int i = 0; i<count; i++) {
        const char * propertyName = property_getName(properties[i]);
        id objValue;
        NSString * key = [NSString stringWithUTF8String:propertyName];
        objValue = [obj valueForKey:key];
        [dic setObject:objValue forKey:key];
    }
    NSDictionary * dictionary = [dic copy];
    return dictionary;
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"%@",[self descriptionMehtod:self]];
}
-(NSString *)debugDescription
{
    return [NSString stringWithFormat:@"<%@: %p,%@>",
            [self class],
            self,
            [self descriptionMehtod:self]];
}
@end
