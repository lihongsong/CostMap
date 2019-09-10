#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CostMapControl : NSObject
+(UIView*)yka_createSceneWithFrame:(CGRect)frame;
+(UILabel*)yka_createLabelWithFrame:(CGRect)frame Font:(UIFont *)font Text:(NSString*)text;
+(UIButton*)yka_createButtonWithFrame:(CGRect)frame target:(id)target SEL:(SEL)method title:(NSString*)title;
+(UIImageView*)yka_createImageSceneFrame:(CGRect)frame imageName:(NSString*)imageName;
+(UITextField*)yka_createTextFieldFrame:(CGRect)frame
                                   Font:(UIFont *)font
                              textColor:(UIColor*)color
                          leftImageName:(NSString*)leftImageName
                         rightImageName:(NSString*)rightImageName
                            bgImageName:(NSString*)bgImageName
                            placeHolder:(NSString*)placeHolder
                        sucureTextEntry:(BOOL)isOpen;
+(UITextView*)yka_createTextSceneFrame:(CGRect)frame Font:(UIFont *)font textColor:(UIColor*)color Text:(NSString*)text;
@end
