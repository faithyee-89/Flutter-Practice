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
  // ///1.路由表
  // static Map<String, FlutterBoostRouteFactory> routerMap = {
  //   'homePage': (settings, uniqueId) {
  //     return PageRouteBuilder<dynamic>(
  //         settings: settings,
  //         pageBuilder: (_, __, ___) {
  //           return MyHomePage(title: 'MyHomePage',);
  //         });
  //   },
  //   'firstPage': (settings, uniqueId) {
  //     String name ='';
  //     if(settings.arguments!=null){
  //       name = ( settings.arguments as Map)['key'];
  //     }
  //     return PageRouteBuilder<dynamic>(
  //         settings: settings,
  //         pageBuilder: (_, __, ___) => MyHomePage(
  //           title: name,
  //         ));
  //   },
  // };
  // ///2.创建路由工厂
  // Route<dynamic> routeFactory(RouteSettings settings, String uniqueId) {
  //   FlutterBoostRouteFactory func = routerMap[settings.name];
  //   if (func == null) {
  //     return null;
  //   }
  //   return func(settings, uniqueId);
  // }
  ///3.通过FlutterBoostApp启动Flutter
//   @override
//   Widget build(BuildContext context) {
//     return FlutterBoostApp(routeFactory);
//   }

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
