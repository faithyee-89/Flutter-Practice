import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('标题'),
        leading: Icon(Icons.home),
        actions: [
          Icon(Icons.search),
          Icon(Icons.history),
        ],
        backgroundColor: Colors.orange,
        iconTheme: IconThemeData(
          color: Colors.black,
          opacity: 0.5,
          size: 21,
        ),
      ),
      body: Center(child: Text('文本内容')),
    );
  }
}