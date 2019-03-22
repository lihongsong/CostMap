#ifndef YosGlobalMacro_h
#define YosGlobalMacro_h
#define YosObject(objectName) [[objectName alloc]init]
#define YosPropStatementAndFuncStatement(propertyModifier,className, propertyPointerType, propertyName)                  \
@property(nonatomic,propertyModifier)propertyPointerType  propertyName;                                                 \
- (className * (^) (propertyPointerType propertyName)) propertyName##Set;
#define YosPropSetFuncImplementation(className, propertyPointerType, propertyName)                                       \
- (className * (^) (propertyPointerType propertyName))propertyName##Set{                                                \
return [^(propertyPointerType propertyName) {                                                                            \
_##propertyName = propertyName;                                                                                         \
return self;                                                                                                            \
} copy];                                                                                                                     \
}
#endif 
