import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        Positioned(
            top: 200,
            left: 100,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            )),
        Positioned(
            top: 250,
            left: 150,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.blue,
            )),
        Positioned(
            top: 300,
            left: 200,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.green,
            )),
      ]),
    );
  }
}
