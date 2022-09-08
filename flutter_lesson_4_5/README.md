> ### 本节课⽬标
> 
> - 绘制微信通讯录⻚⾯
> - 模拟接⼝地址：https://getman.cn/mock/users

![网络请求2](https://note.youdao.com/yws/public/resource/53fc68c0d47cc9c99eb7e3450f9ffc6b/BD95BD668D8644B68330DA8D94F5BD01?ynotemdtimestamp=1662128526664)

#### 临时接口配置

登录接口模拟网页：[https://getman.cn/mock/](https://getman.cn/mock/)，在默认的url后填写接口后缀名为users，body内容如下：


```
[
 {

  "name":"张三",
  "imageUrl":"http://thirdwx.qlogo.cn/mmopen/zvr5lK0hdBictkib9JYJpVYswGlqwjuedWI7RGneAcBHibpxdX813A0Lf7YJQbRhlA3arlfVNM80OKZ5iaZDdTRCjIAibryU9DEYz/132",
  "indexLetter":"Z",
  "imageAssets":""
 },

 {

  "name":"李四",
  "imageUrl":"http://thirdwx.qlogo.cn/mmopen/zvr5lK0hdBictkib9JYJpVYswGlqwjuedWI7RGneAcBHibpxdX813A0Lf7YJQbRhlA3arlfVNM80OKZ5iaZDdTRCjIAibryU9DEYz/132",
  "indexLetter":"L",
  "imageAssets":""
 }
]
```


#### 代码及UI示例

![微信截图_20220902221741](https://note.youdao.com/yws/public/resource/53fc68c0d47cc9c99eb7e3450f9ffc6b/119AE5610864468A9657B5D09BF1A634?ynotemdtimestamp=1662128526664)

- friends_index_bar.dart


```
import 'package:flutter/material.dart';
import 'package:flutter_lesson_4_5/index.dart';

class IndexBar extends StatefulWidget {
  IndexBar({Key? key, this.indexBarCallBack}) : super(key: key);
  // 回调方法
  final void Function(String str)? indexBarCallBack;
  @override
  State<IndexBar> createState() => _IndexBarState();
}

class _IndexBarState extends State<IndexBar> {
  Color _backColor = const Color.fromRGBO(1, 1, 1, 0);
  Color _textColor = Colors.black;
  double _indcitorY = 0.0;
  bool _indcitorHidden = true;
  String _indcitorText = 'A';
  @override
  Widget build(BuildContext context) {
    final List<Widget> words = [];
    for (int i = 0; i < INDEX_WORDS.length; i++) {
      words.add(
        Expanded(
          child: Text(
            INDEX_WORDS[i],
            style: TextStyle(
              fontSize: 10,
              color: _textColor,
            ),
          ),
        ),
      );
    }
    return Positioned(
      right: 0,
      top: MediaQuery.of(context).size.height / 8,
      height: MediaQuery.of(context).size.height / 2,
      width: 120,
      child: Row(
        children: [
          // 指示器
          Container(
            alignment: Alignment(0, _indcitorY),
            width: 100,
            child: _indcitorHidden
                ? null
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      Image(
                        image: AssetImage("image/wechat_images/气泡.png"),
                        width: 60,
                      ),
                      Text(
                        _indcitorText,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
          ),
          GestureDetector(
            onVerticalDragDown: (DragDownDetails details) {
              // 获取当前的位置
              int index = getIndexItem(context, details.globalPosition);
              widget.indexBarCallBack!(INDEX_WORDS[index]);
              setState(() {
                _backColor = Color.fromRGBO(1, 1, 1, 0.5);
                _textColor = Colors.white;
                _indcitorY = 2.28 / INDEX_WORDS.length * index - 1.14;
              });
            },
            onVerticalDragEnd: (DragEndDetails details) {
              setState(() {
                _backColor = Color.fromRGBO(1, 1, 1, 0.0);
                _textColor = Colors.black;
                _indcitorHidden = true;
              });
            },
            onVerticalDragUpdate: (DragUpdateDetails details) {
              int index = getIndexItem(context, details.globalPosition);
              widget.indexBarCallBack!(INDEX_WORDS[index]);
              setState(() {
                _indcitorY = 2.28 / INDEX_WORDS.length * index - 1.14;
                _indcitorText = INDEX_WORDS[index];
                _indcitorHidden = false;
              });
            },
            child: Container(
              width: 20,
              color: _backColor,
              child: Column(
                children: words,
              ),
            ),
          )
        ],
      ),
    );
  }

  int getIndexItem(BuildContext context, Offset offset) {
    // 拿到当前的盒子
    RenderBox box = context.findRenderObject() as RenderBox;
    // 拿到y值 当前位置到部件原点的距离
    var y = box.globalToLocal(offset).dy;
    // 算出字符的高度
    var itemHeight =
        MediaQuery.of(context).size.height / 2 / INDEX_WORDS.length;
    int index = y ~/ itemHeight.clamp(0, INDEX_WORDS.length - 1);
    return index;
  }
}

```


- friends_page.dart


```
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

```

![网络请求2](https://note.youdao.com/yws/public/resource/53fc68c0d47cc9c99eb7e3450f9ffc6b/BD95BD668D8644B68330DA8D94F5BD01?ynotemdtimestamp=1662128526664)

