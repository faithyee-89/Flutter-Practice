import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        color: Colors.blue,
        child: Align(
          widthFactor: 5,
          heightFactor: 5,
          // alignment: Alignment.bottomCenter,
          // alignment: Alignment(0,0),
          alignment: FractionalOffset(1, 1),
          child: Container(
            width: 50,
            height: 50,
            color: Colors.red,
          ),
        ),
      )),
    );
  }
}
