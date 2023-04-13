import 'package:flutter/material.dart';

void main() {
  runApp(const MyAppV2());
}

class MyAppV2 extends StatelessWidget {
  const MyAppV2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            alignment: Alignment.center,
            width: 552,
            height: 85,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFABBDD5)),
            child: Text(
              "登录",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 32),
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // 文本控件演示代码
          Container(
            margin: EdgeInsets.only(top: 100),
            height: 200,
            width: 200,
            color: Colors.blue,
            // 文本控件
            child: Text(
              '文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本',
              /**
             * 文本对齐方式
             * TextAlign.end
             */
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              maxLines: 3,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                letterSpacing: 5,
                height: 2,
                decoration: TextDecoration.overline,
              ),
            ),
          ),
          // Image控件演示代码
          Container(
            width: 300,
            height: 300,
            color: Colors.orange,
            // 网络图片地址：https://doc.flutterchina.club/images/flutter-mark-square-100.png
            // child: Image.asset(
            //   'image/flutter_icon.jpg',
            //   // 填充方式
            //   fit: BoxFit.fill,
            // ),

            child: Image.network(
              'https://doc.flutterchina.club/images/flutter-mark-square-100.png',
              fit: BoxFit.fill,
            ),

            // child: Icon(
            //   Icons.stars,
            // ),
          ),
        ]),
      ),
    );
  }
}
