#import "HomeDataEntity.h"
@implementation HomeDataEntity
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
             @"communicationActive": [CommunicationActiveEntity class],
             @"credictCheckRecond": [CredictCheckRecondEntity class],
             @"credictLendRecord": [CredictLendRecord class],
             @"credictUseRate": [NSString class],
             @"credictApplyRecode": [NSString class],
             @"communicationDistribution": [NSString class],
             };
}
@end
@implementation CommunicationActiveEntity
@end
@implementation CredictCheckRecondEntity
@end
@implementation CredictLendRecord
@end
