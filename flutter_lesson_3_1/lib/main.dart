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
