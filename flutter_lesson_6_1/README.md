> ### 《6.1 - 使用Flutter开发菜鸟窝App》 课程介绍
> - 项目介绍
> - 技术栈

#### 项目介绍

![GIF 2022-9-9 19-30-07](https://note.youdao.com/yws/public/resource/2ea329b245e6b0bcf45dea3108ff09b0/5F1005D156D44E36888736F50D1B99CB?ynotemdtimestamp=1662725454174)

#### 技术栈

![微信截图_20220909200816](https://note.youdao.com/yws/public/resource/2ea329b245e6b0bcf45dea3108ff09b0/98AD0F6F7DB44F4E9153644DD8B00E51?ynotemdtimestamp=1662725454174)    


> ### 《6.2 - 菜鸟窝App项目网络模块的简单封装》课程目标
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

> ### 《6.2 - 菜鸟窝App项目网络模块的简单封装》 课程目标
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

> ### 《6.4 - 菜鸟窝App项目架构模式（设计模式）》 课程目标
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

> ### 《6.5 菜鸟窝App项目登录模块开发》课程目标
> - 登录需求梳理
> - 登录页面布局及接口封装

## 代码：

[https://github.com/faithyee-89/Flutter-Practice/tree/main/flutter_lesson_6_1](https://github.com/faithyee-89/Flutter-Practice/tree/main/flutter_lesson_6_1)

## 正文：

#### 注册/登录需求

App-登录

![1](https://note.youdao.com/yws/public/resource/f0fe97e63f48611acafc876caa6df542/8CCABF598F244A0D840459DC4DA49F21?ynotemdtimestamp=1663087429075)

App-注册


![4](https://note.youdao.com/yws/public/resource/f0fe97e63f48611acafc876caa6df542/72C1EE9567F0429BAA502A6E4EA0FE09?ynotemdtimestamp=1663087429075)

#### api

[http://yapi.54yct.com/](http://yapi.54yct.com/)

#### 代码及UI示例

项目第三方库及配置：

![GIF 2022-9-14 0-08-45](https://note.youdao.com/yws/public/resource/f0fe97e63f48611acafc876caa6df542/90A9C96F60C34E3284E711BB59172695?ynotemdtimestamp=1663087429075)

```yaml
dependencies:
  flutter:
    sdk: flutter


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.2
  dio: ^3.0.10
  fluro: ^1.7.8
  flutter_bloc: ^6.1.0
  equatable: ^1.2.5
  formz: ^0.3.1
  uuid: ^2.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter
```

main.dart：项目入口，初始化路由


```dart
void main() {

  // 初始化
  initialize();

  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}

/// 初始化
void initialize() {
  // 初始化 路由
  Routes.configRoutes(Application.router);
}
```

app.dart：在main函数中初始化布局，使用Bloc设计模式封装，并使用AuthenticationBloc来管理用户的状态和校验类的状态，并且初始话校验和用户的数据模块，Provider里加载首页HomePage。


```dart
class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:HomePage(),
    );
  }
}
```

home_page.dart：该页面依然遵循Bloc设计模式，页面使用脚手架Scaffold里的bottomNavigationBar进行底部按钮及页面联动的管理。目前主要开发“我的”页面：profile_page.dart.


```dart
final List<BottomNavigationBarItem> bottomNavItems = [
  BottomNavigationBarItem(
    backgroundColor: Colors.white,
    icon: Image.asset(
      "assets/home/index.png",
      width: 27,
      height: 27,
    ),
    activeIcon: Image.asset(
      "assets/home/index_selected.png",
      width: 27,
      height: 27,
    ),
    label: "优惠",
  ),
  BottomNavigationBarItem(
    backgroundColor: Colors.white,
    icon: Image.asset(
      "assets/home/course.png",
      width: 27,
      height: 27,
    ),
    activeIcon: Image.asset(
      "assets/home/course_selected.png",
      width: 27,
      height: 27,
    ),
    label: "课程",
  ),
  BottomNavigationBarItem(
    backgroundColor: Colors.white,
    icon: Image.asset(
      "assets/home/college.png",
      width: 27,
      height: 27,
    ),
    activeIcon: Image.asset(
      "assets/home/college_selected.png",
      width: 27,
      height: 27,
    ),
    label: "学习中心",
  ),
  BottomNavigationBarItem(
    backgroundColor: Colors.white,
    icon: Image.asset(
      "assets/home/my.png",
      width: 27,
      height: 27,
    ),
    activeIcon: Image.asset(
      "assets/home/my_selected.png",
      width: 27,
      height: 27,
    ),
    label: "我的",
  ),
];

final pages = [
  Container(
      child: Center(
    child: const Text('index'),
  )),
  Container(
      child: Center(
    child: const Text('course'),
  )),
  Container(
      child: Center(
    child: const Text('college'),
  )),
  ProfilePage(),
];

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TabCubit(),
      child: Scaffold(
        // appBar: AppBar(title: const Text('Home')),
        bottomNavigationBar:
            BlocBuilder<TabCubit, int>(builder: (context, state) {
          return CupertinoTabBar(
            items: bottomNavItems,
            currentIndex: state,
            activeColor: Color(0xffFC9900),
            inactiveColor: Color(0xff606266),
            onTap: (index) => _onTabChanged(context, index),
          );
        }),
        body: BlocBuilder<TabCubit, int>(builder: (context, state) {
          return pages[state];
        }),
      ),
    );
  }

  void _onTabChanged(BuildContext context, int index) {
    context.read<TabCubit>().update(index);
  }
}
```

profile_page.dart：页面的逻辑基本与home_page.dart同里，但页面包含了点击的事件。代码如下：


```dart
 Widget _header() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return SliverToBoxAdapter(
            child: GestureDetector(
          onTap: state.status != AuthenticationStatus.authenticated
              ? () {
                  Navigator.of(context).push(LoginPage.route());
                }
              : null,
```


```
  Widget _logoutBtn(BuildContext context) {
    return SliverToBoxAdapter(child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return state.status != AuthenticationStatus.authenticated ? Container() : Padding(
          padding: const EdgeInsets.only(left: 13, top: 50, right: 13),
          child: FlatButton(
            onPressed: () {
              // 退出登陆
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested());
            },
            child: Text("退出登陆",
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xff303133),
                )),
            color: Color(0x33999999),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
        );
      },
    ));
  }
}
```

login_from.dart：最后是项目的重点页面“登录页”，页面包含bloc设计模式，网络请求的内容


```dart
onPressed: state.status.isValidated
    ? () {
        context.read<LoginBloc>().add(const LoginSubmitted());
      }
    : null,
```


```dart
  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginUsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    } else if (event is LoginLogout) {
      yield* _mapLoginLogoutToState(event, state);
    }
  }
```


```dart
  Stream<LoginState> _mapLoginSubmittedToState(
    LoginSubmitted event,
    LoginState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await _authenticationRepository.logIn(
          username: state.username.value,
          password: state.password.value,
        );
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
```


```dart
  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    assert(username != null);
    assert(password != null);

    Map res = await CNWLoginNetManager.login(username, password);
    _userData = res is Map ? res['data'] : {};

    _controller.add(AuthenticationStatus.authenticated);
    // await Future.delayed(
    //   const Duration(milliseconds: 300),
    //   () => _controller.add(AuthenticationStatus.authenticated),
    // );
  }
```










