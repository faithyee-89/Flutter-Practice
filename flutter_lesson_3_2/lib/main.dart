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
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _topRow(),
            _middleRow(),
            _bottomRow(),
          ],
        ),
      ),
    );
  }

  Widget _topRow() {
    return Row(
      children: [
        _item(
          flex: 1,
          color: Colors.green,
          iconData: Icons.search,
          title: '搜索'
        ),
        _item(
          flex: 1,
          color: Colors.blue,
          iconData: Icons.home,
          title: '主页'
        ),
        _item(
          flex: 1,
          color: Colors.orange,
          iconData: Icons.games,
          title: '游戏'
        ),
      ],
    );
  }

  Widget _middleRow() {
    return Row(
      children: [
        _item(
          flex: 1,
          color: Colors.blueAccent,
          iconData: Icons.image,
          title: '图片'
        ),
        _item(
          flex: 2,
          color: Colors.blueGrey,
          iconData: Icons.work,
          title: '工作'
        ),
      ],
    );
  }

  Widget _bottomRow() {
    return Row(
      children: [
        _item(
          flex: 2,
          color: Colors.pinkAccent,
          iconData: Icons.music_note,
          title: '音乐'
        ),
        _item(
          flex: 1,
          color: Colors.blue,
          iconData: Icons.message,
          title: '信息'
        ),
      ],
    );
  }

  // item
  Widget _item({
    required int flex,
    required Color color,
    required IconData iconData,
    required String title,
  }) {
    return Expanded(
      flex: flex,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(iconData),
          Text(title),
        ]),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
      ), 
    
    );
  }
}