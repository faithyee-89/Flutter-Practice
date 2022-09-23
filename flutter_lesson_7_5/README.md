> # 课程目标
> - 预加载Flutter引擎和页面
> - 优化Flutter初始化速度

# 代码

# 正文

## 一、预加载Flutter引擎和页面

### 1. 课程目标

1. 了解为什么要预加载引擎
2. 了解如何预加载引擎

#### 1. 加载引擎的耗时的原因

![image](https://note.youdao.com/yws/public/resource/a13fe723a4c7316116e1d0f5a3c271f0/AABA842750ED4E7FB812068A87BD09B6?ynotemdtimestamp=1663931161844)

[https://flutter.cn/docs/development/add-to-app/performance](https://flutter.cn/docs/development/add-to-app/performance)

#### 2.  预加载引擎（优化方案）

![image](https://note.youdao.com/yws/public/resource/a13fe723a4c7316116e1d0f5a3c271f0/A6609106202D493D864D30AB7AA310F0?ynotemdtimestamp=1663931161844)

#### 3. 预加载页面（优化方案）

![image](https://note.youdao.com/yws/public/resource/a13fe723a4c7316116e1d0f5a3c271f0/C88AA67C87BC442889AF21E0F601E087?ynotemdtimestamp=1663931161844)

![image](https://note.youdao.com/yws/public/resource/a13fe723a4c7316116e1d0f5a3c271f0/F39496382C594BE598DFB4BC59A0F2A0?ynotemdtimestamp=1663931161844)

#### 4. 设置一个闪屏页面（优化方案）

![image](https://note.youdao.com/yws/public/resource/a13fe723a4c7316116e1d0f5a3c271f0/FECA13DAD98D4260A05AB7901A87D588?ynotemdtimestamp=1663931161844)

## 2. 优化Flutter初始化速度（实战）

可以参考官方文档： https://flutter.cn/docs/development/ui/advanced/splash-screen

项目：AndroidNativeProject

Application中初始化FlutterBoost引擎，需要在主线程中耗时100~200ms

### 方案1. 预加载引擎

一般使用Application去初始化的时候就已经做好了

### 方案2. 预加载页面

![image](https://note.youdao.com/yws/public/resource/a13fe723a4c7316116e1d0f5a3c271f0/78EC5F8E4D8A4B9FAD3453684AAC1114?ynotemdtimestamp=1663931161844)

### 方案3. 设置一个闪屏页面

![image](https://note.youdao.com/yws/public/resource/a13fe723a4c7316116e1d0f5a3c271f0/802015DAE6444814972F4CDF875E587C?ynotemdtimestamp=1663931161844)