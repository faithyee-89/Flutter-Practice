> ### 本节课⽬标
> - ##### 掌握FLutter中路由导航
> - ##### 掌握FLutter中路由传值

- #### 静态路由(即命名路由)
静态路由在通过Navigator跳转之前，需要在MaterialApp组件内显式声明路由的名
称，⽽⼀旦声明，路由的跳转⽅式就固定了。通过在MaterialApp内的routes属性进
⾏显式声明路由的定义。


```
class MyApp extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
         return MaterialApp(
         initialRoute: "/", // 默认加载的界面，这里为RootPage
             routes: { // 显式声明路由
                 // "/":(context) => RootPage(),
                 "/A":(context) => Apage(),
                 "/B":(context) => Bpage(),
                 "/C":(context) => Cpage(),
             },
         home: RootPage(),
         );
     }
}
```

注意：如果指定了home属性，routes表则不能再包含此属性。如上代码中【home:RootPage()】 和 【"/":(context) => RootPage()】两则不能同时存在。静态路由跳转：



```
Navigator.of(context).pushNamed("/A");
```

- #### 动态路由

动态路由⽆需在MaterialApp内的routes中注册即可直接使⽤：RootPage —>
Apage


```
Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => Apage(),
));
```

动态路由中，需要传⼊⼀个Route,这⾥使⽤的是MaterialPageRoute，它可以使⽤和平台⻛格⼀致的路由切换动画,在iOS上左右滑动切换，Android上会上下滑动切换。也可以使⽤CupertinoPageRoute实现全平台的左右滑动切换。

- #### 路由传值

常⻅的路由传值分为两个⽅⾯：

1. 向下级路由传值

静态路由向下级路由传值：


```
Navigator.of(context).pushNamed("/A",arguments:{"argms":"这是传入A的参数"});
```

动态路由向下级路由传值：


```
Navigator.of(context).push(MaterialPageRoute(
 builder: (context) => APage("这是传入的参数"),
));
```

2. 返回上级路由时传值


```
Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => APage(),
)).then((value){ // 获取pop的传值
    print(value);
});
或
String value = await Navigator.of(context).pushNamed('/xxx');
```

- #### 完整代码及UI示例


```
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/page1': (context) {
        return Page1();
      },
      '/page3': (context) => Page3()
    },
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            onPressed: (() {
              // 静态路由跳转方式
              Navigator.of(context).pushNamed('/page1', arguments: '我是主页面的值')
              .then((value) => print(value));//接受从子页面返回的值（静态动态路由都可以用这种方式）
            }),
            color: Colors.blue,
            child: Text('跳到页面1'),
          ),
          MaterialButton(
            onPressed: (() {
              // 动态路由跳转方式
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => Page2(
                        page2String: '我是主页面的值2',
                      ))));
            }),
            color: Colors.blue,
            child: Text('跳到页面2'),
          )
        ],
      )),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 获取从homePage跳转带过来的参数
        title: Text(ModalRoute.of(context)!.settings.arguments.toString()),
      ),
      body: Center(
        child: MaterialButton(
          color: Colors.blue,
          child: Text('返回上级页面'),
          onPressed: (() {
            Navigator.pop(context,'我是page1的字符串');
          }),
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  Page2({Key? key, required this.page2String}) : super(key: key);
  String page2String;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 获取从homePage跳转带过来的参数
        title: Text(page2String),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

```

![GIF 2022-8-29 16-27-18](https://note.youdao.com/yws/public/resource/bce61e82712703f23b978cd77e9d8de6/2C3DCF2E6DE74EECB4B30F8EFE6F6F69?ynotemdtimestamp=1661761737634)