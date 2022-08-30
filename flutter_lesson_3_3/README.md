> ### 本节课⽬标
> - 掌握层叠布局概念
> - 掌弹Stack组件
> - 掌握Position组件

层叠布局允许⼦组件按照代码中声明的顺序堆叠起来。Flutter中使⽤Stack和
Positioned这两个组件来配合实现绝对定位。Stack允许⼦组件堆叠，⽽Positioned
⽤于根据Stack的四个⻆来确定⼦组件的位置。

- #### Stack


```
Stack({
     this.alignment = AlignmentDirectional.topStart, // 子 Widget 对齐方式
     this.textDirection,// 文字方向 有些语言是从右到左
     this.fit = StackFit.loose,//如何去适应Stack的大小，是宽松，还是强制充满Stack
     this.overflow: Overflow.visible,// 决定如何显示超出 Stack 显示空间的
    子 widget
     List<Widget> children = const <Widget>[],
})
```


- #### Positioned


```
const Positioned({
     Key? key,
     this.left,
     this.top,
     this.right,
     this.bottom,
     this.width,
     this.height,
     required Widget child,
})
```


left、top 、right、bottom分别代表离Stack左、上、右、底四边的距离。width和height⽤于指定需要定位元素的宽度和⾼度。注意，Positioned的width、height 和其它地⽅的意义稍微有点区别，此处⽤于配合left、top 、right、 bottom来定位组件，举个例⼦，在⽔平⽅向时，你只能指定left、right、width三个属性中的两个，如指定left和width后，right会⾃动算出(left+width)，如果同时指定三个属性则会报
错，垂直⽅向同理。

- #### 代码及UI示例


```
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

```
![stack](https://note.youdao.com/yws/public/resource/75dba61baa320fca4b4a07092383f3ad/347D6F416F66474CBFE9F5853C1BF38D?ynotemdtimestamp=1661842185051)

