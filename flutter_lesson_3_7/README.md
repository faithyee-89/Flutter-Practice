> ### 本节课⽬标
> - 掌弹ListView组件(列表)

- ListView builder

可以⾮常⽅便的构建我们⾃⼰定义的child布局，所以在Flutter中⾮常的常⽤


```
//设置滑动方向 Axis.horizontal 水平 默认 Axis.vertical 垂直
 scrollDirection: Axis.vertical,
 //内间距
 padding: EdgeInsets.all(10.0),
 //是否倒序显示 默认正序 false 倒序true
 reverse: false,
 //false，如果内容不足，则用户无法滚动 而如果[primary]为true，它们总
是可以尝试滚动。
 primary: true,
 //确定每一个item的高度 会让item加载更加高效
 itemExtent: 50.0,
 //内容适配
 shrinkWrap: true,
 //item 数量
 itemCount: list.length,
 //滑动类型设置
 physics: new ClampingScrollPhysics(),
 //cacheExtent 设置预加载的区域
 cacheExtent: 30.0,
 //滑动监听
// controller ,
```


分析⼏个⽐较难理解的属性

分析⼏个⽐较难理解的属性 shrinkWrap特别推荐 child
⾼度会适配 item填充的内容的⾼度,我们⾮常的不希望child的⾼度固定，因为这样的
话，如果⾥⾯的内容超出就会造成布局的溢出。

shrinkWrap多⽤于嵌套listView中
内容⼤⼩不确定 ⽐如 垂直布局中 先后放⼊⽂字 listView （需要Expend包裹否则⽆
法显示⽆穷⼤⾼度 但是需要确定listview⾼度 shrinkWrap使⽤内容适配不会有这样
的影响） primary If the [primary] argument is true, the [controller] must be null.
在构造中默认是false 它的意思就是为主的意思，primary为true时，我们的
controller 滑动监听就不能使⽤了 physics 这个属性⼏个滑动的选择
AlwaysScrollableScrollPhysics() 总是可以滑动.

NeverScrollableScrollPhysics禁⽌
滚动 BouncingScrollPhysics 内容超过⼀屏 上拉有回弹效果 ClampingScrollPhysics
包裹内容 不会有回弹 cacheExtent 这个属性的意思就是预加载的区域 设置预加载的
区域 cacheExtent 强制设置为了 0.0，从⽽关闭了“预加载” controller 滑动监听，我们多⽤于上拉加载更多，通过监听滑动的距离来执⾏操作.

- #### 代码及UI示例


```
import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: NewsPage(),
  ));
}

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // lesson 1
      // body: Column(
      //   children: [
      //     ListView(
      //       shrinkWrap: true,
      //       scrollDirection: Axis.vertical,
      //       padding: EdgeInsets.all(30),
      //   children: [
      //     Icon(Icons.home),
      //     Icon(Icons.search),
      //   ],
      // ),
      //   ],
      // ),

      // lesson 2
      // body: _listView(),

      // lesson 3
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
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemCount: list.length,
        itemBuilder: ((context, index) {
          return ListTile(
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
          return _listView(_newsDataList);
        });
  }
}

```

![listview](https://note.youdao.com/yws/public/resource/0d7c5edffffeb996dc33fa80938fa9ad/09BF234EA6894E1289E2128CB6B51AC4?ynotemdtimestamp=1661861593547)

- 数据源data.json部分截图

![data](https://note.youdao.com/yws/public/resource/0d7c5edffffeb996dc33fa80938fa9ad/85728D5E98824EE39FE64013600ADCE2?ynotemdtimestamp=1661861593547)




