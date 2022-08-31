import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lesson_3_9/wechat_message_page/wechat_list_item.dart';
import 'package:flutter_lesson_3_9/wechat_message_page/wechat_user_model.dart';

class WechatMessagePage extends StatefulWidget {
  const WechatMessagePage({Key? key}) : super(key: key);

  @override
  State<WechatMessagePage> createState() => _WechatMessagePageState();
}

class _WechatMessagePageState extends State<WechatMessagePage> {
  WeChatUserModel? _weChatUserModel;

  Future _loadData() async {
    // await标签代表耗时操作
    await Future.delayed(Duration(seconds: 1));

    // 注意加载文件需要去pubspec.yaml配置里设置asset目录
    String jsonData = await rootBundle
        .loadString('lib/wechat_message_page/we_chat_data.json');

    final jsonResult = json.decode(jsonData);
    /**
     * StatefulWidget的特性
     */
    setState(() {
      _weChatUserModel = WeChatUserModel.fromJson(jsonResult);
      print(_weChatUserModel!.data![0].text!);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _viewBody(),
    );
  }

  Widget _viewBody() {
    return _weChatUserModel == null
        ? Center(
            child: Text('加载中'),
          )
        : ListView(
            children: [
              _searchBar(),
              _listView(),
            ],
          );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0, //去除appbar悬浮效果
      backgroundColor: Color.fromRGBO(229, 229, 229, 1),
      centerTitle: true,
      title: Text(
        '微信',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            print('添加好友按钮被点击');
          },
          icon: const Icon(Icons.add_circle_outline),
          color: Colors.black,
        ),
      ],
    );
  }

  Widget _searchBar() {
    return InkWell(
      onTap: () {
        print('搜索框被点击了');
      },
      child: Container(
        color: Color.fromRGBO(229, 229, 229, 1),
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: 60,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search),
              Text(
                '搜索',
                style: TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // 嵌套listview注意要禁用掉子listview的滚动事件
  Widget _listView() {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(), //禁用滑动事件
        shrinkWrap: true,
        itemBuilder: (BuildContext, int index) {
          return UserListItem( userData: _weChatUserModel!.data![index]);
        },
        separatorBuilder: (BuildContext, int) {
          return Divider();
        },
        itemCount: _weChatUserModel!.data!.length);
  }
}
