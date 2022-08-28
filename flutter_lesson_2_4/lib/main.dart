import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
          width: 100,
          height: 100,
          // padding: EdgeInsets.all(10),
          // padding: EdgeInsets.only(top: 20, left: 20, bottom: 10, right: 30),
          // margin: EdgeInsets.all(10),
          // margin: EdgeInsets.only(top: 100),
          // 圆角
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.orange,
            // 阴影
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 20,
              )
            ]
          ),
          child: Icon(Icons.home),
        ),
      ),
        ),
    );
  }
}


