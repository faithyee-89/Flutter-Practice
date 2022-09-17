import 'package:flutter/material.dart';

void main() {
  print("a");
  String? aaa;
  int? bbb;
  double ccc;
  Map<dynamic, dynamic> mmmm;
  bool? bol;

  String? _testFun(String? aaa) {
    return aaa;
  }

  runApp(MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: Column(children: [
          Text(
            "data ${bol! == true ? "true" : "false!"}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
            ),
          ), 
          Text(
            "data ${aaa}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
            ),
          )
        ]),
      ),
    ),
  ));
}
