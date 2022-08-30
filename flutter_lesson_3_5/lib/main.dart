import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: LearnPaddingPage(),
  ));
}

class LearnPaddingPage extends StatelessWidget {
  const LearnPaddingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar() as PreferredSizeWidget,
      body: Column(
        children: [
          Expanded(child: _viewBody()),
          _bottomBar(),
        ],
      ),
    );
  }

  // appbar
  Widget _appBar() {
    return AppBar();
  }

  // content
  Widget _viewBody() {
    return Center(
      child: Text('布局内容'),
    );
  }

  // navigator
  Widget _bottomBar() {
    return Container(
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [_bottomBarIte(iconData: Icons.home, title: '主页'),
        _bottomBarIte(iconData: Icons.new_releases, title: '新闻'),
        _bottomBarIte(iconData: Icons.person, title: '我的')],
      ),
    );
  }

  Widget _bottomBarIte({
    required IconData iconData,
    required String title,
  }) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(iconData),
          ),
          Text(title),
        ],
      ),
    );
  }
}
