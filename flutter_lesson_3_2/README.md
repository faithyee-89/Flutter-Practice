> ### 本节课⽬标
> - 掌握Expanded组件
> - 掌弹性布局(Flex)


- #### 弹性布局

弹性布局允许⼦widget按照⼀定⽐例来分配⽗容器空间，弹性布局的概念在其UI系统中也都存在，如H5中的弹性盒⼦布局，Android中的FlexboxLayout。Flutter中的弹性布局主要通过Flex和Expanded来配合实现。


```
Flex({
 ...
 @required this.direction, //弹性布局的方向, Row默认为水平方向，Column默
认为垂直方向
 List<Widget> children = const <Widget>[],
})
```


- #### Expanded

可以按⽐例“扩伸”Row、Column和Flex⼦widget所占⽤的空间。


```
const Expanded({
 int flex = 1,
 @required Widget child,
})
```


flex为弹性系数，如果为0或null，则child是没有弹性的，即不会被扩伸占⽤的空间。如果⼤于0，所有的Expanded按照其flex的⽐例来分割主轴的全部空闲空间

- #### 代码及UI示例


```
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
```

![flex布局](https://note.youdao.com/yws/public/resource/54d72e1cc6bb5e89f79f7bcc5fd4ccc7/706F4C4219F04D63B4F2309BCCA1ED7A?ynotemdtimestamp=1661774161014)