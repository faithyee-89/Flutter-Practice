# 课程目标

- Flutter混合中的单引擎多引擎
- 市面上常用混合中的单引擎多引擎
- FlutterBoost3.0介绍
- FlutterBoost3.0接入
- Flutter接入FlutterBoost3.0
- Android接入FlutterBoost3.0

# 代码

# 正文

## 一、Flutter混合中的单引擎多引擎

### 1. 引擎的概念

![flutter架构图](https://note.youdao.com/yws/public/resource/949317c738180a93e489d436d0d1f091/CDCBCA3AECBE438CAC3FEF7440184E83?ynotemdtimestamp=1663763920955)

![flutter架构解说](https://note.youdao.com/yws/public/resource/949317c738180a93e489d436d0d1f091/62AB030C334E4D2C8EE3684E586686B0?ynotemdtimestamp=1663763920955)

### 2. 单引擎与多引擎对比

1. 多引擎的优势

    每一个新启用的Flutter页面实例互相独立，各自维护路由栈、UI和应用状态。但消耗太大，组件之间的通信麻烦。
    
    ![多引擎](https://note.youdao.com/yws/public/resource/949317c738180a93e489d436d0d1f091/CE5936D09B514B9F8AAE95B6BF2EF967?ynotemdtimestamp=1663763920955)
    
    

    
2. FlutterEngineGroup官方介绍（优化多引擎的缺点）

    业务场景处理

    ![engineGroup](https://note.youdao.com/yws/public/resource/949317c738180a93e489d436d0d1f091/3EC9C84B94DA4BE3AEE808D3CB80152A?ynotemdtimestamp=1663763920955)

3. FlutterEngineGroup的使用（多引擎推荐使用这个框架）

![engineGroup的使用](https://note.youdao.com/yws/public/resource/949317c738180a93e489d436d0d1f091/944DB4507E294A71897D3B6DB54DC747?ynotemdtimestamp=1663763920955)

1. FlutterEngineGroup的不足
    FlutterEngineGroup最大问题是多Engine之间不是isolate层面的内存共享。
    
    但是，单引擎的复用，可以解决isolate层面的内存共享。


2. FlutterEngineGroup与单引擎复用的对比

    FlutterEngineGroup：
    
        1. 不同Flutter实例，保存独立业务状态
        2. 不同实例可以并行渲染
        3. 不同实例内部各自维护导航堆栈
        
    单引擎的复用：
    
        1. 可以解决isolate层面的内存共享
        2. 路由堆栈相对简单
        3. 内存消耗相对低

## 二、市面上常用混合中的单引擎多引擎(咱们最终用FlutterBoost)

### 1. 了解常用技术选型

Mutiple_Flutters.pdf io大会上下载的混合开发的技术选型方案

[1. 《即将开源|让Flutter真正支持View级别的混合开发》](https://blog.csdn.net/ByteDanceTech/article/details/103316457)

[2. 微店的Flutter混合栈管理技术实践](https://juejin.cn/post/6844903763627474957)

[3. Flutter 实现原理及在马蜂窝的跨平台开发实践](https://juejin.cn/post/6844903895760633864)

[4. Flutter 混合栈复用原理](https://blog.csdn.net/qihoo_tech/article/details/102617605)

### 2. 混合开发中的核心-路由管理

![混合开发的路由管理](https://note.youdao.com/yws/public/resource/949317c738180a93e489d436d0d1f091/8544B41F96FC4DAF930E683C1FADB559?ynotemdtimestamp=1663763920955)

### 3. 核心问题思考（FlutterBoost都解决了以下问题-_-||）

1. 保证Flutter页面与Native页面之间的跳转从用户体验上没有任何差异
2. 保证生命周期完整性，处理相关打点事件上报
3. 资源性能问题

## 三、FlutterBoost3.0介绍

单引擎复用开发上，基本都使用FlutterBoost引擎进行开发

### 1. 课程目标

1. 了解FlutterBoost3.0的作用
2. 了解FlutterBoost3.0的架构思想

#### 1. 了解FlutterBoost3.0的作用

[Flutter Boost3.0初探](https://zhuanlan.zhihu.com/p/362662962)

[使用文档](https://github.com/alibaba/flutter_boost/blob/master/README_CN.md)

1.1 FlutterBoost3.0做了什么

![flutterBoost做了什么](https://note.youdao.com/yws/public/resource/949317c738180a93e489d436d0d1f091/F03E72EFC4874A5EBD80F9B684335950?ynotemdtimestamp=1663763920955)



#### 2. 了解FlutterBoost3.0的架构思想

2.1 FlutterBoost架构图

![flutterBoost架构图](https://note.youdao.com/yws/public/resource/949317c738180a93e489d436d0d1f091/9152B9005FF74466ACECC103051818A4?ynotemdtimestamp=1663763920955)

2.2 FlutterBoost版本

![flutterBoost版本](https://note.youdao.com/yws/public/resource/949317c738180a93e489d436d0d1f091/607183BDC828469B8D95EC3EA1E15CE9?ynotemdtimestamp=1663763920955)

## 四、FlutterBoost3.0接入

> ### 课程目标
> 
> - flutterBoost的接入流程

### 1. Flutter工程接入FlutterBoost3.0

![flutter接入boost1](https://note.youdao.com/yws/public/resource/949317c738180a93e489d436d0d1f091/4FB2201FA2D54240AB9E67BE312F521E?ynotemdtimestamp=1663763920955)

具体参考github上的说明文档：[使用文档](https://github.com/alibaba/flutter_boost/blob/master/README_CN.md)

### 2. Android工程中接入FlutterBoost3.0

![android工程r接入boost1](https://note.youdao.com/yws/public/resource/949317c738180a93e489d436d0d1f091/89C7B2E5A3AE46179211E821FAD80491?ynotemdtimestamp=1663763920955)

### 3. iOS工程中接入FlutterBoost3.0

![iOS工程r接入boost2](https://note.youdao.com/yws/public/resource/949317c738180a93e489d436d0d1f091/B5CD3E7ACADB404FB9BBE042B7BB7D5C?ynotemdtimestamp=1663763920955)



## 五、Flutter接入FlutterBoost3.0（实战）

项目文件名：flutterproject

1. yaml文件引入flutterBoost


```yaml
flutter_boost:
    git:
        url: 'https://github.com/alibaba/flutter_boost.git'
        ref: '4.0.4'
```


2. 命令行输入：flutter get packages
3. 走四步开启flutterboost的页面（具体看示例代码）：main.dart
    1. 注册路由表
    2. 创建路由工厂
    3. 通过FlutterBoostApp启动Flutter
    4. 调用自定义的方法CustomFlutterBinding()


```dart
//@dart=2.8
// import 'package:cainiaowo_business_module/main.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutterproject/app_life_cycle_observer.dart';

void main() {
  ///4.这里的CustomFlutterBinding调用务必不可缺少，用于控制Boost状态的resume和pause
  // CustomFlutterBinding();

  runApp(MyApp());
}

///创建一个自定义的Binding，继承和with的关系如下，里面什么都不用写
// class CustomFlutterBinding extends WidgetsFlutterBinding
//     with BoostFlutterBinding {}

class MyApp extends StatelessWidget {
  ///1.路由表
  static Map<String, FlutterBoostRouteFactory> routerMap = {
    'homePage': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (_, __, ___) {
            return MyHomePage(title: 'MyHomePage',);
          });
    },
    'firstPage': (settings, uniqueId) {
      String name ='';
      if(settings.arguments!=null){
        name = ( settings.arguments as Map)['key'];
      }
      return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (_, __, ___) => MyHomePage(
            title: name,
          ));
    },
  };
  ///2.创建路由工厂
  Route<dynamic> routeFactory(RouteSettings settings, String uniqueId) {
    FlutterBoostRouteFactory func = routerMap[settings.name];
    if (func == null) {
      return null;
    }
    return func(settings, uniqueId);
  }
  /3.通过FlutterBoostApp启动Flutter
  @override
  Widget build(BuildContext context) {
    return FlutterBoostApp(routeFactory);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 定义APP启动时第一个显示的页面
      initialRoute: '/',
      routes: {
        //当navigating到‘/’ route时，构建FirstScreen widget
        '/': (context) => MyHomePage(),
        //当navigating 到"/second" route, 构建SecondScreen widget.
        '/second': (context) => MyHomePage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("widget.title"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "name",
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: _getNativeName,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

```


4. 以上四步，就完成了FlutterBoost在Flutter中的接入

## 六、Android接入FlutterBoost3.0（实战）

项目文件名：AndroidNativeProject

1. settings.gradle配置及build.gradle配置
2. 在Application类里面初始化FlutterBoost
3. 在Activity中使用FlutterBoost进行页面跳转
4. 跳转之前检查manifest有没有接入Flutter的Activity

## 七、iOS接入FlutterBoost3.0（实战）

