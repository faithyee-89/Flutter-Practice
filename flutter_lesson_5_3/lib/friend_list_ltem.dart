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
