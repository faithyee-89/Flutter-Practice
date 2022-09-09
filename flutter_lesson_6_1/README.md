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
