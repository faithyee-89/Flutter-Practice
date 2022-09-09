import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lesson_5_3/user_model.dart';

import 'friend_list_ltem.dart';
import 'header_view.dart';

class WechatFriendCirclePage extends StatefulWidget {
  const WechatFriendCirclePage({Key? key}) : super(key: key);

  @override
  State<WechatFriendCirclePage> createState() => _WechatFriendcirclePageState();
}

class _WechatFriendcirclePageState extends State<WechatFriendCirclePage> {
  /// 滑动控制器
  final ScrollController _scrollController = ScrollController();

  /// appbarde透明度
  double _opacity = 0;

  /// 数据源
  UserModel? _userModel;

  /// 读取本地数据
  /// 该方法为异步方法
  Future<String> loadAsset() async {
    return await rootBundle
        .loadString('lib/wechat_asset/Data.json');
  }

  @override
  void initState() {
    super.initState();
    /// 调用读取本地json数据方法
    /// 异步方法可以用.then获取方法执行完的返回结果
    loadAsset().then((value) {
      setState(() {
        _userModel = UserModel.fromJson(jsonDecode(value));
      });
    });

    _scrollController.addListener(() {
      double alpha = _scrollController.offset / 200;
      if (alpha < 0) {
        alpha = 0;
      } else if (alpha > 1) {
        alpha = 1;
      }
      setState(() {
        _opacity = alpha;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _userModel == null
          ? Container()
          : Stack(
              children: [
                /// 朋友圈列表
                ListView(
                  padding: const EdgeInsets.only(top: 0),

                  /// 添加控制器
                  controller: _scrollController,
                  children: [
                    /// 第一个子控件 头部背景view
                    HeaderView(),
                    ListView.builder(

                        /// listview高度取最小值 防止在垂直布局中高度冲突
                        shrinkWrap: true,

                        /// 禁用滚动事件 防止滑动事件冲突
                        physics: const NeverScrollableScrollPhysics(),

                        /// 用数据源的数据个数
                        itemCount: _userModel!.data!.length,

                        /// 自定义item
                        itemBuilder: (c, i) {
                          return _listItem(_userModel!.data![i]);
                        }),
                  ],
                ),

                /// appbar
                Opacity(
                  /// 动态的透明度
                  opacity: _opacity,

                  /// ios风格的appbar
                  child: const CupertinoNavigationBar(
                    middle: Text('朋友圈'),
                  ),
                )
              ],
            ),
    );
  }

  ///  自定义用户item
  Widget _listItem(Data data) {
    return FriendListItem(data: data);
  }
}
