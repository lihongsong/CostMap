#import "NSString+cityInfos.h"
@implementation NSString (cityInfos)
+ (NSString *)getDistrictNoFromCity:(NSString *)cityName {
    NSBundle *mainbundle = [NSBundle mainBundle];
    NSString *filePath = [mainbundle pathForResource:@"cityInfo" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    NSDictionary *cityInfoDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return cityInfoDic[cityName];
}
@end
