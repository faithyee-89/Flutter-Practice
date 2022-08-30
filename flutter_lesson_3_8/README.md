> ### 本节课⽬标
> - 掌弹Listview添加点击事件的⽅法
> - 监听Listview的滚动
> - 点击列表跳转详情⻚⾯⽤webview展示
> - 第三方库资源获取方法

- #### 滚动事件监听

Flutter内建了Notification机制，Widget可以通过Notification将⼀个事件冒泡到
Widget Tree的上层节点。⽤NotificationListener包裹需要监听事件的⼦视图，即可
监听Notification事件。


```
class NotificationListener<T extends Notification> extends
StatelessWidget {
     /// Creates a widget that listens for notifications.
     const NotificationListener({
     Key key,
     @required this.child,
     this.onNotification,
     }) : super(key: key);
     ……
}
```

1. NotificationListener继承⾃StatelessWidget，所以可以作为视图来使⽤。
2. NotificationListener的child属性是我们将要监听的滚动组件，例如⼀个
ListView。
3. onNotification函数负责滚动事件的回调处理，我们的事件处理逻辑在这⾥执⾏。


- #### ListView的滚动监听


```
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new NotificationListener(
        onNotification: (ScrollNotification note) {
          print(note.metrics.pixels.toInt()); // 滚动位置
        },
        child: ListView.builder(
            itemCount: 500,
            itemBuilder: (context, index) {
              return new Card(
                  child: new ListTile(
                leading: new Icon(Icons.phone),
                title: new Text("$index"),
                subtitle: new Text("123123123"),
                trailing: new Icon(Icons.arrow_forward_ios),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                enabled: true,
                onTap: () => print("$index被点击了"),
                onLongPress: () => print("$index被长按了"),
              ));
            }),
      ),
    );
  }
}

```


- ScrollController


```
_controller.addListener(() {
     print(_controller.offset); //打印滚动位置
     if (_controller.offset < 1000 && showToTopBtn) {
         setState(() {
             showToTopBtn = false;
             });
     } else if (_controller.offset >= 1000 && showToTopBtn == false) {
        setState(() {
             showToTopBtn = true;
         });
     }
 });
```


```
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Page(),
  ));
}

class Page extends StatelessWidget {
  Page({Key? key}) : super(key: key);
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _viewBody(),
    );
  }

  Widget _viewBody() {
    // 下拉刷新控件
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(const Duration(milliseconds: 1000));
      },
      // 带分割线的Listview构造方法
      child: ListView.separated(
          // 添加滑动控制器
          controller: scrollController
            // 添加滑动监听
            ..addListener(() {
              if (scrollController.offset >= 490) {
                // 使用滑动控制器滑动到指定位置
                scrollController.animateTo(
                  0,
                  duration: const Duration(seconds: 1),
                  curve: Curves.ease,
                );
              }
            }),
          itemCount: 15,
          // 分割线
          separatorBuilder: (context, index) {
            // flutter 自带的分割线控件
            return Divider();
          },
          // 列表子控件
          itemBuilder: (context, index) {
            // flutter自带的列表子控件
            return ListTile(
              onTap: () {
                print('123');
              },
              // 左图标控件
              leading: const Icon(Icons.phone),
              // 标题控件
              title: Text("卜大爷 $index"),
              subtitle: const Text("010-12345678"),
              // 右侧图标控件
              trailing: const Icon(Icons.arrow_forward_ios),
            );
          }),
    );
  }
}

```


- #### webview
1. 在项⽬的pubspec.yaml⽂件中引⼊webview_flutter

```
dependencies:
 flutter:
 sdk: flutter
 webview_flutter: ^3.0.1
```

2.引⼊头⽂件

```
import 'package:webview_flutter/webview_flutter.dart';
```

3.如果是ios模拟器要添加权限 在ios/Runner/Info.plist中添加

```
<key>io.flutter.embedded_views_preview</key>
<string>YES</string>
```

4.打开⽹⻚js执⾏

```
javascriptMode: JavascriptMode.unrestricted,
```

- #### 第三方库资源获取方法

1. 推荐一个pub.dev的flutter库网站
[https://pub.dev/](https://pub.dev/)
2. 搜索想要的库，例如搜索：webview

![pub库搜索](https://note.youdao.com/yws/public/resource/0013fe9ca1e3c109615f194b1dc87153/CF65D88395D245C2971DE95E6B9C22AC?ynotemdtimestamp=1661883222883)
1. 按需要选择搜索的结果

![pub库搜索1](https://note.youdao.com/yws/public/resource/0013fe9ca1e3c109615f194b1dc87153/E5B9A4F9B2554EF9909B65BD74A856ED?ynotemdtimestamp=1661883222883)

1. 按网页的提示和库版本号，在项目的pubspes.yaml文件进行关联导入

![pub库搜索2](https://note.youdao.com/yws/public/resource/0013fe9ca1e3c109615f194b1dc87153/60AB377157CA410DAE96AF143DE598CE?ynotemdtimestamp=1661883222883)

1. 终端运行flutter pub get命令进行第三方库导入

- #### 代码及UI示例

- main.dart


```
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_lesson_3_8/news_details_page.dart';

void main() {
  runApp(MaterialApp(
    home: NewsPage(),
  ));
}

class NewsPage extends StatelessWidget {
  NewsPage({Key? key}) : super(key: key);

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('今日新闻'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: _loadData(context),
    );
  }

  Widget _listView(List list) {
    return ListView.separated(
        // .. 联结操作符
        controller: scrollController..addListener(() {
          print(scrollController.offset);
          // 滑到最底部时代码操作回到listview头部
          if (scrollController.offset > 264) {
            scrollController.animateTo(0, duration: Duration(seconds: 2), curve: Curves.ease);
          }
        }),
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemCount: list.length,
        itemBuilder: ((context, index) {
          return ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return NewsDetailPage(url: list[index]['url']); 
              }));
            },
            leading: SizedBox(
              width: 80,
              child: Image.network(
                list[index]['pic'],
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              list[index]['title'],
              maxLines: 2,
            ),
            subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(list[index]['src']),
                  Text(list[index]['time']),
                ]),
          );
        }));
  }

  Widget _loadData(BuildContext context) {
    return FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('lib/data.json'),
        builder:
            (BuildContext buildContext, AsyncSnapshot<String> asyncSnapshot) {
          // asyncSnapshot是异步获取到json文件的内容变量
          if (asyncSnapshot.connectionState.name != 'done') {
            return Center(
              child: Text('加载中'),
            );
          }

          Map data = json.decode(asyncSnapshot.data.toString());
          // 获取的方式取决于json里的内容
          List _newsDataList = data['result']['result']['list'];
          return _refreshView(_newsDataList);
        });
  }

  Widget _refreshView(List dataList) {
    return RefreshIndicator(
        child: _listView(dataList),
        onRefresh: () {
          return Future.delayed(Duration(seconds: 2));
        });
  }
}

```

- news_details_page.dart


```
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailPage extends StatelessWidget {
  NewsDetailPage({Key? key, required this.url}) : super(key: key);
  String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: url,
        // 要打开js加载api
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}

```

![新闻](https://note.youdao.com/yws/public/resource/0013fe9ca1e3c109615f194b1dc87153/AE4C454BCE1B445B9ADD62FE4FC087DC?ynotemdtimestamp=1661883222883)


