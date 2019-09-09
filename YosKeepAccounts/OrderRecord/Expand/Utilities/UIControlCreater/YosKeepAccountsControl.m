#import "YosKeepAccountsControl.h"
#import "UIColor+YKAAddColor.h"
@implementation YosKeepAccountsControl
+(UIView*)yka_createSceneWithFrame:(CGRect)frame
{
    UIView*view=[[UIView alloc]initWithFrame:frame];
    return view;
}
+(UILabel*)yka_createLabelWithFrame:(CGRect)frame Font:(UIFont *)font Text:(NSString*)text
{
    UILabel*label=[[UILabel alloc]initWithFrame:frame];
    label.font=font;
    label.lineBreakMode=NSLineBreakByWordWrapping;
    label.numberOfLines=0;
    label.textAlignment=NSTextAlignmentLeft;
    label.backgroundColor=[UIColor clearColor];
    label.text=text;
    label.textColor = [UIColor stateLittleGrayColor];
    return label;
}
+(UIButton*)yka_createButtonWithFrame:(CGRect)frame target:(id)target SEL:(SEL)method title:(NSString*)title
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame=frame;
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button addTarget:target action:method forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+(UIImageView*)yka_createImageSceneFrame:(CGRect)frame imageName:(NSString*)imageName{
    UIImageView*imageScene=[[UIImageView alloc]initWithFrame:frame];
    imageScene.image=[UIImage imageNamed:imageName];
    imageScene.userInteractionEnabled=YES;
    return imageScene;
}
+(UITextField*)yka_createTextFieldFrame:(CGRect)frame Font:(UIFont *)font textColor:(UIColor*)color leftImageName:(NSString*)leftImageName rightImageName:(NSString*)rightImageName bgImageName:(NSString*)bgImageName
{
    UITextField*textField=[[UITextField alloc]initWithFrame:frame];
    textField.font = font;
    textField.textColor=color;
    if (leftImageName.length > 0) {
        UIImage*image=[UIImage imageNamed:leftImageName];
        UIImageView*letfImageScene=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        textField.leftView=letfImageScene;
        textField.leftViewMode=UITextFieldViewModeAlways;
    }
    if (rightImageName.length > 0) {
        UIImage*rightImage=[UIImage imageNamed:rightImageName];
        UIImageView*rightImageScene=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, rightImage.size.width, rightImage.size.height)];
        textField.rightView=rightImageScene;
        textField.rightViewMode=UITextFieldViewModeAlways;
    }
    textField.clearButtonMode = UITextFieldViewModeAlways;
    return textField;
}
+(UITextField*)yka_createTextFieldFrame:(CGRect)frame Font:(UIFont *)font textColor:(UIColor*)color leftImageName:(NSString*)leftImageName rightImageName:(NSString*)rightImageName bgImageName:(NSString*)bgImageName placeHolder:(NSString*)placeHolder sucureTextEntry:(BOOL)isOpen
{
    UITextField*textField= [YosKeepAccountsControl yka_createTextFieldFrame:frame Font:font textColor:color leftImageName:leftImageName rightImageName:rightImageName bgImageName:bgImageName];
    textField.placeholder=placeHolder;
    textField.secureTextEntry=isOpen;
    return textField;
}
+(UITextView*)yka_createTextSceneFrame:(CGRect)frame Font:(UIFont *)font textColor:(UIColor*)color Text:(NSString*)text{
    UITextView *statementTV = [[UITextView alloc]initWithFrame:frame];
    statementTV.text = text;
    statementTV.font = font;
     statementTV.textColor = color;
    statementTV.userInteractionEnabled = true;
    statementTV.textAlignment = NSTextAlignmentLeft;
    return statementTV;
}
@end
