import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lesson_4_5/friends_item.dart';
import 'package:flutter_lesson_4_5/friends_model.dart';

import 'friends_index_bar.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  // 头部数据数组
  List<FriendsModel> _headerData = [
    FriendsModel(imageAssets: 'image/wechat_images/新的朋友.png', name: '新的朋友'),
    FriendsModel(imageAssets: 'image/wechat_images/群聊.png', name: '群聊'),
    FriendsModel(imageAssets: 'image/wechat_images/标签.png', name: '标签'),
    FriendsModel(imageAssets: 'image/wechat_images/公众号.png', name: '公众号'),
  ];

  // 滚动控制器
  late ScrollController _scrollController;
  // item的高度
  final double _itemHeight = 54.0;
  // 分组栏的高度
  final double _groupHeight = 30.0;

  final Map _groupOffsetMap = {
    INDEX_WORDS[0]: 0.0,
  };

  List<FriendsModel> _friendsModelList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
    _scrollController = ScrollController();
  }

  Future _loadData() async {
    String url = 'https://getman.cn/mock/users';
    HttpClient httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var json = await response.transform(utf8.decoder).join();
    var jsonData = jsonDecode(json);
    for (var item in jsonData) {
      _friendsModelList.add(FriendsModel.fromJson(item));
    }

    ///  数组排序
    _friendsModelList.sort((FriendsModel a, FriendsModel b) {
      return a.indexLetter!.compareTo(b.indexLetter!);
    });
    // 记录当前分组栏的偏移量
    var _groupOffset = _itemHeight * _headerData.length;
    // 把所有数据遍历 计算所有组头的位置
    for (int i = 0; i < _friendsModelList.length; i++) {
      if (i < 1) {
        // 第一个组头是肯定存在的
        // 第一个组头的位置就是头部的高度
        _groupOffsetMap
            .addAll({_friendsModelList[i].indexLetter: _groupOffset});
        // 记录一下当前的位置 方便计算下一个组头的位置
        _groupOffset += _itemHeight + _groupHeight;
      } else if (_friendsModelList[i].indexLetter ==
          _friendsModelList[i - 1].indexLetter) {
        // 如果前一个组头和后一个组头一样的 值计算偏移量
        _groupOffset += _itemHeight;
      } else {
        // 如果当前的组头字母和上一个不一样 那么要记录组头的位置和字母
        _groupOffsetMap
            .addAll({_friendsModelList[i].indexLetter: _groupOffset});
        _groupOffset += _itemHeight + _groupHeight;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(220, 220, 220, 1),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Image.asset(
              'image/wechat_images/icon_friends_add.png',
              width: 25,
            ),
          )
        ],
        title: Text(
          '通讯录',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: _headerData.length + _friendsModelList.length,
            controller: _scrollController,
            itemBuilder: _ListItem,
          ),
          IndexBar(
            indexBarCallBack: (String str) {
              if (_groupOffsetMap[str] != null) {
                _scrollController.animateTo(_groupOffsetMap[str],
                    duration: Duration(microseconds: 100),
                    curve: Curves.easeIn);
              }
            },
          )
        ],
      ),
    );
  }

  Widget _ListItem(BuildContext context, int index) {
    if (index < _headerData.length) {
      return FriendsItem(
        imageAssets: _headerData[index].imageAssets,
        name: _headerData[index].name,
      );
    } else {
      bool noShowGroup = index > _headerData.length &&
          _friendsModelList[index - _headerData.length].indexLetter ==
              _friendsModelList[index - _headerData.length - 1].indexLetter;

      return FriendsItem(
        imageUrl: _friendsModelList[index - _headerData.length].imageUrl,
        name: _friendsModelList[index - _headerData.length].name,
        groupTitle: noShowGroup
            ? null
            : _friendsModelList[index - _headerData.length].indexLetter,
      );
    }
  }
}
