> ### 课程目标
> - 制作微信首页

![微信](https://note.youdao.com/yws/public/resource/c3f6b029bab133b2328539c42d024767/FEBC2F88F8F3449EB1663B56F657DD84?ynotemdtimestamp=1661952456335)

- #### json转dart实体类

进行网络开发会涉及到接收后端传来的json格式文件，那flutter应用需要使用dart实体类模型来进行接收，以下推荐一个转换的网站

[https://javiercbk.github.io/json_to_dart/](https://javiercbk.github.io/json_to_dart/)

- #### 代码及UI示例

- main.dart

app的入口，加载页面WechatMessagePage


```
import 'package:flutter/material.dart';
import 'package:flutter_lesson_3_9/wechat_message_page/wechat_message_page.dart';

void main() {
  runApp(MaterialApp(
    home: WechatMessagePage(),
  ));
}


```

- WechatMessagePage.dart

微信首页：包含了appbar，ListView和加载json的逻辑


```
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

```

- WeChatUserModel.dart 

后端数据模型，根据json进行构造。


```
///https://javiercbk.github.io/json_to_dart/

class WeChatUserModel {
  List<Data>? data;

  WeChatUserModel({this.data});

  WeChatUserModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? idstr;
  List<Users>? users;
  String? screenName;
  String? createdAt;
  String? text;
  Badge? badge;
  bool? messageFree;

  Data(
      {this.idstr,
      this.users,
      this.screenName,
      this.createdAt,
      this.text,
      this.badge,
      this.messageFree});

  Data.fromJson(Map<String, dynamic> json) {
    idstr = json['idstr'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    screenName = json['screen_name'];
    createdAt = json['created_at'];
    text = json['text'];
    badge = json['badge'] != null ? new Badge.fromJson(json['badge']) : null;
    messageFree = json['messageFree'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idstr'] = this.idstr;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    data['screen_name'] = this.screenName;
    data['created_at'] = this.createdAt;
    data['text'] = this.text;
    if (this.badge != null) {
      data['badge'] = this.badge!.toJson();
    }
    data['messageFree'] = this.messageFree;
    return data;
  }
}

class Users {
  String? profileImageUrl;

  Users({this.profileImageUrl});

  Users.fromJson(Map<String, dynamic> json) {
    profileImageUrl = json['profile_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_image_url'] = this.profileImageUrl;
    return data;
  }
}

class Badge {
  String? type;
  int? value;
  String? text;
  bool? show;
  bool? dot;

  Badge({this.type, this.value, this.text, this.show, this.dot});

  Badge.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
    text = json['text'];
    show = json['show'];
    dot = json['dot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['value'] = this.value;
    data['text'] = this.text;
    data['show'] = this.show;
    data['dot'] = this.dot;
    return data;
  }
}

```

- wechat_list_item.dart

微信页面中listview的item设置类


```
import 'package:flutter/material.dart';
import 'package:flutter_lesson_3_9/wechat_message_page/wechat_user_model.dart';

class UserListItem extends StatelessWidget {
  UserListItem({
    Key? key,
    required this.userData,
  }) : super(key: key);

  Data userData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          _userPicView(),
          SizedBox(width: 5,),
          _itemContent(),
        ],
      ),
    );
  }

  Widget _userPicView() {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: userData.users!.first.profileImageUrl!.contains('http')
                ? Image.network(
                    userData.users!.first.profileImageUrl!,
                    width: 50,
                    height: 50,
                  )
                : Image.asset(
                    userData.users!.first.profileImageUrl!,
                    width: 50,
                    height: 50,
                  ),
          ),
        ),
        userData.badge == null ? Container() : _badge(),
      ],
    );
  }

  Widget _badge() {
    return Positioned(
        right: 0,
        top: 0,
        child: Container(
          alignment: Alignment.center,
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            color: Colors.red,
          ),
          child: Text(
            userData.badge!.text!,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ));
  }

  Widget _itemContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              userData.screenName!,
              style: TextStyle(fontSize : 16),
            ),
            Text(
              userData.createdAt!,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
        Text(
          userData.text!,
          maxLines: 1,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ]),
    );
  }
}

```

![微信截图_20220831212612](https://note.youdao.com/yws/public/resource/c3f6b029bab133b2328539c42d024767/CADDD7F8381A4AF4A59360536B866BDA?ynotemdtimestamp=1661952456335)