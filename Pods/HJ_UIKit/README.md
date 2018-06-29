# 互金UI通用组件

### 一、接入流程说明
1、UI通用组件包含多个可在多个项目中共用的视图及相关管理类，目前提供HJAlertVIew（弹窗）、HJCityPicker（城市选择器）
2、不同的组件可独立引入（在步骤二“接入项目”中会有介绍）

### 二、接入项目

## 1、 UI各通用组件支持pod独立安装

```
source 'git@172.16.0.245:Finance_SDK/iOS_Loan_Spec.git'

pod 'HJ_UIKit/HJAlertView'
pod 'HJ_UIKit/HJCityPickerManager'
```

## 2、功能集成

详细使用说明见HJ_UIKit／Classes目录下各组件中的README.md文件

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