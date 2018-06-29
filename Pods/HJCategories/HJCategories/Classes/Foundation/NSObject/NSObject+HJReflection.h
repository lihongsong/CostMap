//
//  NSObject+HJReflection.h
//  HJCategories
//
//  Created by yoser on 2017/12/19.
//

#import <Foundation/Foundation.h>

@interface NSObject (HJReflection)

//类名
- (NSString *)hj_className;
+ (NSString *)hj_className;
//父类名称
- (NSString *)hj_superClassName;
+ (NSString *)hj_superClassName;

//实例属性字典
-(NSDictionary *)hj_propertyDictionary;

//属性名称列表
- (NSArray *)hj_propertyKeys;
+ (NSArray *)hj_propertyKeys;

//属性详细信息列表
- (NSArray *)hj_propertiesInfo;
+ (NSArray *)hj_propertiesInfo;

//格式化后的属性列表
+ (NSArray *)hj_propertiesWithCodeFormat;

//方法列表
-(NSArray *)hj_methodList;
+(NSArray *)hj_methodList;

-(NSArray *)hj_methodListInfo;

//创建并返回一个指向所有已注册类的指针列表
+ (NSArray *)hj_registedClassList;
//实例变量
+ (NSArray *)hj_instanceVariable;

//协议列表
-(NSDictionary *)hj_protocolList;
+ (NSDictionary *)hj_protocolList;


- (BOOL)hj_hasPropertyForKey:(NSString*)key;
- (BOOL)hj_hasIvarForKey:(NSString*)key;

@end
