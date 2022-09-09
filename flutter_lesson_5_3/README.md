> ### 本节课⽬标
> - 实现微信朋友圈ui布局

#### 代码片段


1. 读取本地数据

- 关键代码


```
  /// 读取本地数据
  /// 该方法为异步方法
  Future<String> loadAsset() async {
    return await rootBundle
        .loadString('lib/wechat_asset/Data.json');
  }
```


```
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
```

2. 实现头部HeaderView和appbar

- 关键代码

头部HeaderView：


```
import 'package:flutter/material.dart';

class HeaderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 40,
            child: Image.asset(
              'lib/wechat_asset/banner.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
              right: 15,
              bottom: 20,
              child: Container(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                      'lib/wechat_asset/logo.jpg'),
                ),
              )),
          Positioned(
            right: 100,
            bottom: 50,
            child: Text(
              'sunnytu',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black, offset: Offset(1, 1))]),
            ),
          ),
        ],
      ),
    );
  }
}

```

3. 声明滚动监听和appbar透明度参数


```
/// 滑动控制器
final ScrollController _scrollController = ScrollController();

/// appbarde透明度
double _opacity = 0;
```

4. 在initState中添加滚动事件监听


```
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
```

5. 朋友圈⻚⾯build⽅法：


```
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
```


7. 声明⾃定义item 并且在FriendPage中定义⼀个返回


```
  ///  自定义用户item
  Widget _listItem(Data data) {
    return FriendListItem(data: data);
  }
```

8. ⾃定义列表item


```
import 'package:flutter/material.dart';
import 'package:flutter_lesson_5_3/user_model.dart';

class FriendListItem extends StatefulWidget {
  FriendListItem({Key? key, required this.data}) : super(key: key);
  Data data;
  @override
  State<FriendListItem> createState() => _FriendListItemState();
}

class _FriendListItemState extends State<FriendListItem> {
  /// 点赞数量
  int _starCount = 0;

  /// 评论的数量
  int _talkCount = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _itemLeftView(),
            itemRightView(),
          ],
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 70),
              child: Text(
                widget.data.time!,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
            _menuView(),
          ],
        ),
        Visibility(
            visible: _starCount == 0 ? false : true,
            child: Container(
              constraints: const BoxConstraints(
                minWidth: double.infinity,
              ),
              margin: const EdgeInsets.fromLTRB(70, 0, 15, 0),
              padding: const EdgeInsets.all(0),
              color: Colors.grey.shade300,
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 5,
                runSpacing: 5,
                children: List.generate(
                  _starCount,
                  (index) => SizedBox(
                    width: 80,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.favorite_border,
                          color: Colors.blueGrey,
                          size: 13,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '用户1',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueGrey,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
        Visibility(
            visible: _talkCount == 0 ? false : true,
            child: Container(
              constraints: const BoxConstraints(
                minWidth: double.infinity,
              ),
              margin: const EdgeInsets.fromLTRB(70, 0, 15, 0),
              padding: const EdgeInsets.all(0),
              color: Colors.grey.shade300,
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 5,
                runSpacing: 5,
                children: List.generate(
                  _talkCount,
                  (index) => SizedBox(
                    width: 80,
                    child: Row(
                      children: const [
                        Text(
                          '用户1: ',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueGrey,
                          ),
                        ),
                        Text(
                          '666',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueGrey,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ))
      ],
    );
  }

  /// 菜单点击事件
  void _onMenuTap() {
    _menuIsOpen = !_menuIsOpen;
    setState(() {});
  }

  /// 菜单
  bool _menuIsOpen = false;
  Widget _menuView() {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black87,
            ),
            width: _menuIsOpen == false ? 0 : 120,
            height: 30,
            child: OverflowBox(
                maxWidth: 120,
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                          InkWell(
                            onTap: () {
                              _starCount++;
                              _onMenuTap();
                            },
                            child: const Text(
                              '赞',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.sms,
                            color: Colors.white,
                          ),
                          InkWell(
                            onTap: () {
                              _talkCount++;
                              _onMenuTap();
                            },
                            child: const Text(
                              '评论',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              _onMenuTap();
            },
            child: Image.asset(
              'lib/wechat_asset/' + 'button.png',
              width: 22,
              height: 18,
            ),
          )
        ],
      ),
    ));
  }

  Widget _itemLeftView() {
    return Container(
      width: 40,
      height: 40,
      margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset('lib/wechat_asset/' + widget.data.head!),
      ),
    );
  }

  Widget itemRightView() {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 70, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.data.name!,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.data.desc!,
            style: const TextStyle(fontSize: 15),
          ),
          // 照片view
          _picView(),
        ],
      ),
    ));
  }

  /// 照片布局

  Widget _picView() {
    List<String> userPic = widget.data.pics!;
    if (userPic.length == 1) {
      return Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 50, 10),
        child: Image.asset('lib/wechat_asset/' + userPic.first),
      );
    } else if (userPic.length == 4 || userPic.length == 2) {
      return Wrap(
        spacing: 5,
        runSpacing: 5,
        alignment: WrapAlignment.start,
        children: userPic
            .map((e) => Image.asset(
                  'lib/wechat_asset/' + e,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ))
            .toList(),
      );
    } else if (userPic.length == 3 || userPic.length > 4) {
      return Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 50, 10),
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          alignment: WrapAlignment.start,
          children: userPic
              .map((e) => Image.asset(
                    'lib/wechat_asset/' + e,
                    width: 70,
                    height: 70,
                  ))
              .toList(),
        ),
      );
    }
    return Container();
  }
}

```

#### UI示例

![GIF 2022-9-9 15-34-45](https://note.youdao.com/yws/public/resource/917595ac09d44d7154db84b499fa57d6/DED25945CC8D4E329188C7DC7FF82817?ynotemdtimestamp=1662721190338)