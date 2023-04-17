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

  Widget _listView(List list) {
    return ListView.separated(
        // .. 级联操作符
        controller: scrollController
          ..addListener(() {
            print(scrollController.offset);
            // 滑到最底部时代码操作回到listview头部
            if (scrollController.offset > 153) {
              scrollController.animateTo(0,
                  duration: Duration(seconds: 2), curve: Curves.ease);
            }
          }),
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemCount: list.length,
        itemBuilder: ((context, index) {
          return ListTile(
            onTap: () {
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
}
