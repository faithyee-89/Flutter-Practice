import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // 继承自父类
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
            width: 100,
            color: Colors.blue,
          )),
          Expanded(
            flex: 2,
            child: Container(
            width: 100,
            color: Colors.red,
          )),
          Expanded(
            flex: 3,
            child: Container(
            width: 100,
            color: Colors.pink,
          ))

        ]),
    );
  }
}
