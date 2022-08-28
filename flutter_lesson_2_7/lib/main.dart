import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _viewBody(),
    );
  }

  Widget _viewBody() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // IconButton控件
        IconButton(
          onPressed: () => {print('点击了IconButton')},
          icon: Icon(Icons.home),
        ),

        // MaterialButton控件
        MaterialButton(
          onPressed: () {
            print('点击了materialButton');
          },
          color: Colors.blue,
          child: Text(
            '按钮',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),

        // InkWell
        InkWell(
          onTap: () {
            print('点击确定');
          },
          onDoubleTap: () {
            print('双击');
          },
          onLongPress: () {
            print('长按');
          },
          child: Container(
            alignment: Alignment.center,
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '确定',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),

        // gestureDetector监听控件的点击事件和拖移事件
        GestureDetector(
          onPanUpdate: (details) {
            print(details.globalPosition);
          },
          child: Container(
            margin: EdgeInsets.only(top: 10),
            width: 300,
            height: 300,
            color: Colors.blue,
          ),
        ),
      ]),
    );
  }
}
