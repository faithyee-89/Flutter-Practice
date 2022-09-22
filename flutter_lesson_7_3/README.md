> # 课程目标
> - Flutter端架构之分层设计
> - Flutter端架构之分层架构实现
> - Native 端的架构设计
> - Native 端架构实现
> - Native与Flutter交互的总结（页面，方法)


# 代码

# 正文

## 一、Flutter端架构之分层设计

### 本节课的目标

Flutter侧的架构设计思想

### 1. Flutter分层设计

![image](https://note.youdao.com/yws/public/resource/d96a22a853aa9a3a0ccd8a0ec0991c8a/090388740E6A44DEB8F7FA04A495A983?ynotemdtimestamp=1663843195612)

1. 第一层：自上往下，分为三层，最上是app层，相当于项目的入口，项目所有的配置，这个层不涉及任何业务代码

2. 第二层：业务层
3. 第三层：依赖层，存放各种基础库

## 二、Flutter端架构之分层架构实现

示例项目：

- flutterproject : module组件，app层
- business_module : 业务工程
- base_module ：依赖层，存放各种基础库

flutterproject工程的yaml配置

```yaml
dependencies:
  flutter:
    sdk: flutter
  #  xml: ^3.6.1 # upload.dart上传aar
  xml: ^5.1.2
  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
#  business_module:
   path: ../business_module
```

business_module工程的yaml配置

```yaml
environment:
  sdk: ">=2.12.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter
  base_module:
    path: ../base_module

```





## 三、Native 端的架构设计

### 本节课的目标

了解Native侧的架构设计思想

### 1. Native架构设计

参照闲鱼app的架构

![image](https://note.youdao.com/yws/public/resource/d96a22a853aa9a3a0ccd8a0ec0991c8a/CB7BAA2C5EFA413286B01079115FC858?ynotemdtimestamp=1663843195612)

## 四、Native 端架构实现


示例项目：

- AndroidNativeProject

## 五、Native与Flutter交互的总结（页面，方法)

### 本节课的目标

1. 了解Native与Flutter交互的两个途径

#### 1. Native与Flutter交互（页面）

![image](https://note.youdao.com/yws/public/resource/d96a22a853aa9a3a0ccd8a0ec0991c8a/189ABC2D32DE4BE887DB8F0E669621CD?ynotemdtimestamp=1663843195612)

![image](https://note.youdao.com/yws/public/resource/d96a22a853aa9a3a0ccd8a0ec0991c8a/23E2A81031E9434DB6F72C320A50BB99?ynotemdtimestamp=1663843195612)

![image](https://note.youdao.com/yws/public/resource/d96a22a853aa9a3a0ccd8a0ec0991c8a/06A7216871AF418DB965FEBD36066449?ynotemdtimestamp=1663843195612)

#### 2. 通过Pigeon库定义方法级交互

![image](https://note.youdao.com/yws/public/resource/d96a22a853aa9a3a0ccd8a0ec0991c8a/18A4F74A78C44EF9997EF965F172F5C7?ynotemdtimestamp=1663843195612)

#### 3. 通过FlutterBoost定义方法级交互

![image](https://note.youdao.com/yws/public/resource/d96a22a853aa9a3a0ccd8a0ec0991c8a/07F6E83B105644B689B1C970AD962849?ynotemdtimestamp=1663843195612)

![image](https://note.youdao.com/yws/public/resource/d96a22a853aa9a3a0ccd8a0ec0991c8a/02FCFD6D69C64D4DAC4B017B2A90D000?ynotemdtimestamp=1663843195612)