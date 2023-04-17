import 'dart:convert';
import 'dart:js';

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

  Widget _loadData(BuildContext context) {
    return FutureBuilder(
        //异步加载本地json文件
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
}
