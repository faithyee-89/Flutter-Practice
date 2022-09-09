> ### 课程介绍
> - 项目介绍
> - 技术栈

#### 项目介绍

![GIF 2022-9-9 19-30-07](https://note.youdao.com/yws/public/resource/2ea329b245e6b0bcf45dea3108ff09b0/5F1005D156D44E36888736F50D1B99CB?ynotemdtimestamp=1662725454174)

#### 技术栈

![微信截图_20220909200816](https://note.youdao.com/yws/public/resource/2ea329b245e6b0bcf45dea3108ff09b0/98AD0F6F7DB44F4E9153644DD8B00E51?ynotemdtimestamp=1662725454174)    


> ### 课程目标
> - 网络组件引用
> - 网络框架搭建

#### dio网络框架引用

pubspec.yaml


```
dependencies:
  flutter:
    sdk: flutter


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.2
  dio: ^3.0.10
```


#### 网络框架搭建

net_config.dart


```
import 'package:dio/dio.dart';

const String baseUrl = "https://course.api.cniao5.com";
const int connectTimeout = 5000;
const int receiveTimeout = 3000;

final Map<String, dynamic> headers = <String, dynamic>{'platform': 'yapi'};

final BaseOptions options = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: connectTimeout,
    receiveTimeout: receiveTimeout,
    headers: headers);

```

net_manager.dart


```
import 'package:dio/dio.dart';
import 'package:flutter_lesson_6_1/network/common/net_config.dart' as NetConfig;

final Dio dio = Dio(NetConfig.options);

class CNWNetManager {
  static Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return dio.get(path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
  }

  static Future<Response<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return dio.post(path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }
}

```

> ### 课程目标
> - 路由组件引用
> - 路由框架封装

#### 路由组件引用


```
dependencies:
  flutter:
    sdk: flutter


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.2
  dio: ^3.0.10
  # 路由组件
  fluro: ^1.7.8
```


#### 路由框架封装

router_handlers.dart


```
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

Handler emptyHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return Container();
});
```

routes.dart


```

import 'package:flutter_lesson_6_1/router/route_handlers.dart';
import 'package:fluro/fluro.dart';

class Routes {
  static String home = "/";
  static String login = "/login";

  static void configRoutes(FluroRouter router) {
    router.notFoundHandler = emptyHandler;
  }
}
```



#### 路由框架使用

application.dart


```
import 'package:fluro/fluro.dart';

class Application {
  // 全局路由
  static final FluroRouter router = FluroRouter();
}
```

main.dart


```
import 'package:flutter/material.dart';
import 'package:flutter_lesson_6_1/router/routes.dart';

import 'common/application.dart';

void main() {

  // 初始化
  initialize();

  runApp(const MaterialApp(
    home: Scaffold(
      
    ),
  ));
}

/// 初始化
void initialize() {
  // 初始化 路由
  Routes.configRoutes(Application.router);
}
```

> ### 课程目标
> - 设计模式的选择

#### 为什么需要设计模式

项目初期

![为什么需要设计模式](https://note.youdao.com/yws/public/resource/ba41d106aee84f0626d0874f7d04ca0a/7973ABFB69174D74892F7F572A9D2CEE?ynotemdtimestamp=1662741817152)

项目后期

![为什么需要设计模式2](https://note.youdao.com/yws/public/resource/ba41d106aee84f0626d0874f7d04ca0a/86F5A44312FE47268748BED9F78A774C?ynotemdtimestamp=1662741817152)

#### flutter中常见的设计模式

- MVX
    - MVC
    - MVP
    - MVVM
    - etc.
- Redux
    - flutter_redux
    - 来源于前端的Redux框架

![flutter设计模式3](https://note.youdao.com/yws/public/resource/ba41d106aee84f0626d0874f7d04ca0a/C1E496B1CA3445C489C16F5434ED86B1?ynotemdtimestamp=1662741817152)

- BloC
    - Google官方推荐
    - 能局部 能全局

![flutter设计模式4](https://note.youdao.com/yws/public/resource/ba41d106aee84f0626d0874f7d04ca0a/D43CE4826E4145BD89934B530B0D0584?ynotemdtimestamp=1662741817152)

- etc.



#### 如何选择

- flutter的设计模式为了解决状态的管理
- MVX最终采用的都是Flutter自带的setState方式
- BloC & Redux 都是拥有一套自己的状态管理方式
- BloC 局部的状态管理，当然全局的能看做是局部
