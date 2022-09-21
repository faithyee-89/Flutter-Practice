> # 课程目标
> 
> - 课程亮点及目标
> - Flutter混合工程介绍
> - Android混入Flutter的环境要求
> - Android混入两种模式
> - iOS混入的环境要求
> - iOS混入两种模式介绍
> - 怎么样的原生项目中接入Flutter


# 正文

## 一、课程亮点及目标

1. 课程亮点
    1. 技术新颖，使用flutter boost 3.0
    2. flutter版本较新，使用2.5版本
    3. 掌握混合开发的框架（标准化的层次结构）
    4. 动态编译技术
2. 课程目标
    1. 掌握混合开发的架构思想

## 二、Flutter混合工程介绍


1. 环节展示

    注意flutter要新，因为课程比较新，用的都是新版flutter版本

2. 混合工程研发结构
    
    核心逻辑是如何在最小改动已有ios/android工程的前提下运行flutter。我们可以将flutter部分理解成为一个单独的模块。通过pod库（ios），aar库（android）的方式，由cocoaPods和gradle引入到主工程中

3. 参考资料
    1. 《Flutter技术解析与实战》
    2. Flutter混合工程改造实践: [https://mp.weixin.qq.com/s/Q1z6Mal2pZbequxk5I5UYA](https://mp.weixin.qq.com/s/Q1z6Mal2pZbequxk5I5UYA)
    3. Flutter新锐专家之路：工程研发体系篇 [https://zhuanlan.zhihu.com/p/41376773](https://zhuanlan.zhihu.com/p/41376773)
    
![淘宝团队定制的混合工程研发体系](https://note.youdao.com/yws/public/resource/119118092b90d08cfa3f6d7973619c7a/09538EA57F494A639D63735A94FF7CB8?ynotemdtimestamp=1663745107891)

优点：解耦，最小的影响native的内容

1. 步骤：

    1. 官方flutter仓库下载定制engine
    2. 打造属于自己的flutter体系
    3. 打包（不同平台的引用包）
    4. pub库（公司自己的仓库私服）
    5. flutter用来写业务，framework的部分不用去动
    6. 区分团队开发模式- Navate团队开发、Flutter团队开发、混合调试/热重载

## 三、Android混入Flutter的环境要求

### 3.1 Flutter支持的CPU架构

![flutter支持的cpu架构](https://note.youdao.com/yws/public/resource/119118092b90d08cfa3f6d7973619c7a/F6FFE81556634FD8B5DBD30C6BACEAD2?ynotemdtimestamp=1663745107891)

使用android studio去看apk下的lib文件夹，看里面有什么文件夹，就代表对应支持什么cpu架构运行环境

![apk下的so文件](https://note.youdao.com/yws/public/resource/119118092b90d08cfa3f6d7973619c7a/3C9E2B363885412F85ED8648A8B9620A?ynotemdtimestamp=1663745107891)

图中可以看出libapp.so、libflutter.so文件是flutter开发的产物。



### 3.2 使用Java8作为环境要求

![java8环境](https://note.youdao.com/yws/public/resource/119118092b90d08cfa3f6d7973619c7a/FAAB0A220633481CB3C2EA4D7E784BF4?ynotemdtimestamp=1663745107891)

### 3.3 避免flutter工程中Android的包名与Native工程一致

![包名1](https://note.youdao.com/yws/public/resource/119118092b90d08cfa3f6d7973619c7a/436114EE542E48C1ABB99233517DE2C5?ynotemdtimestamp=1663745107891)

![包名2](https://note.youdao.com/yws/public/resource/119118092b90d08cfa3f6d7973619c7a/20A0E00900664796BF1B2AA76EAD6211?ynotemdtimestamp=1663745107891)

---

## 四、Android混入Flutter的两种模式


### 4.1 开发模式

截图来至与flutter官网

![开发模式内容](https://note.youdao.com/yws/public/resource/119118092b90d08cfa3f6d7973619c7a/AB95ADF6892E4445AB2A5D0E234E0527?ynotemdtimestamp=1663745107891)

![源码模式](https://note.youdao.com/yws/public/resource/119118092b90d08cfa3f6d7973619c7a/7A354B495D9C4EA38AEFFB20EB1EAFA0?ynotemdtimestamp=1663745107891)

### 4.2 发布模式

![发布模式内容](https://note.youdao.com/yws/public/resource/119118092b90d08cfa3f6d7973619c7a/4E242EE326AD43298D27AE54836E42AC?ynotemdtimestamp=1663745107891)

简而言之，需要把flutter的项目打成aar的包，然后存储到maven私服上，给native项目引用


### 4.3 总结

1. 开发过程使用源码依赖模式，方便调试
2. 开发完成交付时使用aar依赖模式，其他人员无需配置Flutter环境。


## 五、iOS混入的环境要求


1. Flutter支持IOS 8.0及以上
2. 1.10或以上版本的CocoaPods


### 环境

Flutter中文网有教程



## 六、iOS混入的两种模式概述

### 1. 开发模式（源码依赖）

![开发模式内容2](https://note.youdao.com/yws/public/resource/119118092b90d08cfa3f6d7973619c7a/0790B3B1EFCF4606839F1AD80B790D3C?ynotemdtimestamp=1663745107891)

### 2. 发布模式（frameWork依赖）

![发布模式内容3](https://note.youdao.com/yws/public/resource/119118092b90d08cfa3f6d7973619c7a/8B3C6DD164ED4853839262F33C8D107D?ynotemdtimestamp=1663745107891)



## 七、已有App开始混入Flutter

## 课程目标
- 1. 在已有Native工程中混入Flutter
- 2. Native跳转默认Flutter入口（非路由）
- 3. Native跳转指定Flutter入口（路由）
- 4. Native通过引擎缓存跳转Flutter

###  1. 在已有Native工程中混入Flutter

项目名：AndroidNativeProject、flutterproject

ide：android studio

![Native到Flutter](https://note.youdao.com/yws/public/resource/119118092b90d08cfa3f6d7973619c7a/388A2D5E69144DE6B0126AFFD69AAE2C?ynotemdtimestamp=1663745107891)

#### 1. 引用步骤

1. setting.gradle 引用
2. native工程的build.gradle引用flutter工程
3. menifest里声明flutter的activity
4. 完成以上步骤，就可以从原生跳转到flutter的activity了

####  2. Native跳转默认Flutter入口（非路由）


```
startFlutterByDefault();
```


####  3. Native跳转指定Flutter入口（路由）

![Native跳转到flutter（路由）](https://note.youdao.com/yws/public/resource/119118092b90d08cfa3f6d7973619c7a/47B7C88C2AD2490986B52A100445FB74?ynotemdtimestamp=1663745107891)

####  4. Native通过引擎缓存跳转Flutter

![Native通过引擎的方法跳转](https://note.youdao.com/yws/public/resource/119118092b90d08cfa3f6d7973619c7a/DE20CDFFD75B4338902B83A23E891DF1?ynotemdtimestamp=1663745107891)

```
startFlutterByCachedEngine();
```
