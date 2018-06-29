# HJCategories

## 项目简介

对于项目中一些工具类的整理去重抽取，方便代码开发。

## 接入方式：

```ruby
    source 'git@172.16.0.245:Finance_SDK/iOS_Loan_Spec.git'

    pod 'HJCategories', '~> 1.0.1'

    or

    pod 'HJCategories', :subspecs => ['UIKit', 'Foundation', 'CoreFundation']
```


## 分类介绍：
#### Foundation:
> * NSDate
>>  [NSDate+HJNormalExtension](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSDate/NSDate+HJNormalExtension.h):NSDate一些简单的拆解处理

> * NSData 
>>  [NSData+HJBase64](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSData/NSData+HJBase64.h): Base64相关处理
>>  
>>  [NSData+HJDeviceToken](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSData/NSData+HJDeviceToken.h): 将DeviceToken的data转化为String
>>  
>>  [NSData+HJEncrypt](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSData/NSData+HJEncrypt.h): 简单的加密(AES/DES/3DES)
>>  
>>  [NSData+HJLoad](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSData/NSData+HJLoad.h): 从bundle加载data
>>  
>>  [NSData+HJSave](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSData/NSData+HJSave.h): 保存到沙盒
>>  
>>  [NSData+HJZlib](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSData/NSData+HJZlib.h): 压缩解压处理

> * NSString 
>>  [NSString+HJContains](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSString/NSString+HJContains.h): 检测是否包含某字符串、空格、中文
>>  
>>  [NSString+HJLoad](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSString/NSString+HJLoad.h): 从bundle读取文件
>>  
>>  [NSString+HJMatcher](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSString/NSString+HJMatcher.h): 正则匹配相关
>>  
>>  [NSString+HJNormalRegex](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSString/NSString+HJNormalRegex.h): 一些常规的正则匹配
>>  
>>  [NSString+HJSize](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSString/NSString+HJSize.h): 文本大小计算
>>
>>  [NSString+HJSpecialRegex](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSString/NSString+HJSpecialRegex.h): 对于一些特殊的正则匹配
>>  
>>  [NSString+HJTranslate](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSString/NSString+HJTranslate.h): 富文本转换、根据规则插入字符串、替换字符串
>>  
>>  [NSString+HJTrims](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSString/NSString+HJTrims.h): 清除JS脚本、空格、换行、html标签
>>  
>>  [NSString+HJUrl](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSString/NSString+HJUrl.h): 贷款王&即刻借相关url处理
>>  
>>  [NSString+HJURLEncode](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSString/NSString+HJURLEncode.h): 对字符串进行urlEncode、UrlDecode、url参数转字典

> * NSArray 
>>  [NSArray+HJLoad](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSArray/NSArray+HJLoad.h): 从bundle加载Array
>>  
>>  [NSArray+HJSafe](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSArray/NSArray+HJSafe.h): 安全操作数组

> * NSTimer 
>>  [NSTimer+HJBlock](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSTimer/NSTimer+HJBlock.h): 使用block初始化定时器

> * NSNumber 
>>  [NSNumber+HJRound](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSNumber/NSNumber+HJRound.h): 四舍五入、取整

> * NSObject 
>>  [NSObject+HJReflection](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSObject/NSObject+HJReflection.h): 类的反射
>>  
>>  [NSObject+HJRuntime](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSObject/NSObject+HJRuntime.h): 类的runtime操作(方法替换、添加、删除)

> * NSDictionary 
>>  [NSDictionary+HJJSON](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSDictionary/NSDictionary+HJJSON.h): 字典转json
>>  
>>  [NSDictionary+HJLoad](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSDictionary/NSDictionary+HJLoad.h): 从bundle加载字典
>>  
>>  [NSDictionary+HJSafe](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSDictionary/NSDictionary+HJSafe.h): 安全操作字典
>>  
>>  [NSDictionary+HJUrl](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSDictionary/NSDictionary+HJUrl.h): 字典转url参数

> * NSFileManager 
>>  [NSFileManager+HJPaths](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSFileManager/NSFileManager+HJPaths.h): 获取沙盒内文件夹路径，防止文件拷贝

> * NSUserDefaults 
>> [NSUserDefaults+HJSafe](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/Foundation/NSUserDefaults/NSUserDefaults+HJSafe.h): 安全操作UserDefaults

#### UIKit:
> * UIView 
>>  [UIView+HJCustomBorder](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIView/UIView+HJCustomBorder.h): 添加边框(可选上下左右)
>>  
>>  [UIView+HJDraggable](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIView/UIView+HJDraggable.h): 添加拖动功能
>>  
>>  [UIView+HJFind](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIView/UIView+HJFind.h): 寻找子视图、当前控制器、第一响应者
>>  
>>  [UIView+HJFrame](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIView/UIView+HJFrame.h): 视图frame的一些操作
>>  
>>  [UIView+HJNormalBorder](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIView/UIView+HJNormalBorder.h): 设置系统边框，可以通过xib&sb操作
>>  
>>  [UIView+HJScreenshot](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIView/UIView+HJScreenshot.h): 截图
>>  
>>  [UIView+HJVisuals](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIView/UIView+HJVisuals.h): 简单的转场动画、移动动画封装

> * UIImage 
>>  [UIImage+HJAlpha](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIImage/UIImage+HJAlpha.h): alpha通道相关处理
>>  
>>  [UIImage+HJColor](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIImage/UIImage+HJColor.h): 图片生成颜色、灰度图、取色
>>  
>>  [UIImage+HJCompress](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIImage/UIImage+HJCompress.h): 图片压缩处理
>>  
>>  [UIImage+HJFXImage](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIImage/UIImage+HJFXImage.h): 裁剪、缩放、mask
>>  
>>  [UIImage+HJGIF](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIImage/UIImage+HJGIF.h): 加载gif
>>  
>>  [UIImage+HJMerge](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIImage/UIImage+HJMerge.h): 图片合成
>>  
>>  [UIImage+HJOrientation](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIImage/UIImage+HJOrientation.h): 修正图片方向
>>  
>>  [UIImage+HJRemoteSize](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIImage/UIImage+HJRemoteSize.h): 获取远程图片的大小
>>  
>>  [UIImage+HJSave](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIImage/UIImage+HJSave.h): 图片保存到沙盒

> * UIColor 
>>  [UIColor+HJGradient](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIColor/UIColor+HJGradient.h): 生成渐变色
>>  
>>  [UIColor+HJHex](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIColor/UIColor+HJHex.h): 十六进制颜色转换
>>  
>>  [UIColor+HJRandom](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIColor/UIColor+HJRandom.h): 随机颜色

> * UIDevice 
>>  [UIDevice+HJHardware](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIDevice/UIDevice+HJHardware.h): 设备信息
>>  
>>  [UIDevice+HJInfo](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIDevice/UIDevice+HJInfo.h): 软件信息、IDFA、UID

> * UIButton 
>>  [UIButton+HJBadge](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIButton/UIButton+HJBadge.h): 添加消息小红点
>>  
>>  [UIButton+HJCountDown](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIButton/UIButton+HJCountDown.h): 按钮添加读秒效果
>>  
>>  [UIButton+HJTouch](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIButton/UIButton+HJTouch.h): 防止多次点击
>>  
>>  [UIButton+HJVisuals](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIButton/UIButton+HJVisuals.h): 通过颜色设置背景图片

> * UIScreen 
>>  [UIScreen+HJFrame](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIScreen/UIScreen+HJFrame.h): frame操作

> * UITextView 
>>  [UITextView+HJInputLimit](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UITextView/UITextView+HJInputLimit.h): 最大的长度限制
>>  
>>  [UITextView+HJPlaceHolder](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UITextView/UITextView+HJPlaceHolder.h): UITextView 添加 placeHolder

> * UITextField 
>>  [UITextField+HJInputLimit](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UITextField/UITextField+HJInputLimit.h): 最大的长度限制,插入空格样式

> * UIImageView 
>>  [UIImageView+HJLetters](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIImageView/UIImageView+HJLetters.h): 通过文字生成图片并且赋值

> * UIResponder 
>> [UIResponder+HJChain](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIResponder/UIResponder+HJChain.h): 通过字符串的形式打印响应者链

> * UIBezierPath
>>  [UIBezierPath+HJSvgString](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIBezierPath/UIBezierPath+HJSvgString.h): UIBezierPath转成SVG 

> * UIApplication 
>>  [UIApplication+HJOpenUrl](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIApplication/UIApplication+HJOpenUrl.h): 封装openUrl适配ios2以上

> * UITableViewCell 
>>  [UITableViewCell+HJLoad](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UITableViewCell/UITableViewCell+HJLoad.h): 简单的NIB加载

> * UIBarButtonItem 
>>  [UIBarButtonItem+HJBadge](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UIBarButtonItem/UIBarButtonItem+HJBadge.h): 添加小红点

> * UINavigationItem 
>>  [UINavigationItem+HJMargin](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UINavigationItem/UINavigationItem+HJMargin.h): 边距设置

> * UINavigationController 
>>  [UINavigationController+HJSafeTransition](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UINavigationController/UINavigationController+HJSafeTransition.h): 控制器安全跳转 
>>
>>  [UINavigationController+HJStackManager](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/UIKit/UINavigationController/UINavigationController+HJStackManager.h): 控制器数组操作

#### CoreFoundation:
> * CAShapeLayer 
>>
>>  [CAShapeLayer+HJUIBezierPath](http://172.16.0.245:2345/Finance_SDK/iOS_HJCategories/blob/master/HJCategories/Classes/CoreFoundation/CAShapeLayer/CAShapeLayer+HJUIBezierPath.h): 通过UIBezierPath生成shapeLayer

# 版本迭代历史：
### V1.0.1
添加图片压缩分类

</br>
</br>
</br>
</br>

### 修改代码:
#### 如果在使用过程中，发现了<span style="color:red">bug</span> ，欢迎修复<span style="color:red">bug</span>提交 `merge request` 或者直接与技术保障组联系。

提交Merge Request步骤

* 1、与技术保障组联系，沟通bug的原因与解决方案

* 2、由技术保障组根据需要创建开发分支 `develop_*`

* 3、在 `develop_*` 分支修复相关<span style="color:red">bug</span>

* 4、提交MR，`assign to` 技术保障组

* 5、技术保障组 `review` 代码后，合并代码

* 6、根据项目进展和bug的紧急程度发布pod

* 7、修复完结