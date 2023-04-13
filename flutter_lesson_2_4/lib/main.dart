import 'package:flutter/material.dart';

void main() {
  // runApp(const MyApp());
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
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.orange,
              boxShadow: [BoxShadow(color: Colors.black, blurRadius: 30)]),
          child: Icon(Icons.abc),
        )),
      ),
    );
  }
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
            width: 50,
            height: 50,
            // padding: EdgeInsets.all(10),
            // padding: EdgeInsets.only(top: 20, left: 20, bottom: 10, right: 30),
            // margin: EdgeInsets.all(10),
            // margin: EdgeInsets.only(top: 100),
            // 圆角
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.green,
                // 阴影
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 30,
                  )
                ]),
            child: Icon(Icons.account_balance),
          ),
        ),
      ),
    );
  }
}
