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
