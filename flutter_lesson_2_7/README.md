> ### 本节课⽬标
> - 掌握FLutter中⼿势的获取
> - 绘制⾃定义按钮
> - 获取按钮的⼿势事件


Material组件库中提供了button组件： MaterialButton、conButton、FloatingActionButton

- #### IconButton
IconButton 顾名思义就是 Icon + Button 的复合体，当某个 Icon 需要点击事件时，
使⽤ IconButton 最好不过。



```
new IconButton(
     icon: new Icon(Icons.volume_up),
     onPressed: () {
        // ...
     },
)
```

- #### MaterialButton

MaterialButton 是⼀个 Materia ⻛格的按钮


```
new MaterialButton(
     color: Colors.blue,
     textColor: Colors.white,
     child: new Text('点我'),
     onPressed: () {
        // ...
     },
)
```

- #### InkWell

可以⽤InkWell包裹⼦组件来监听⼿势


```
InkWell(
     child: new Text("Click me!"),
     onTap: () {
        // 单击
     },
     onDoubleTap: () {
        // 双击
     },
     onLongPress: () {
        // 长按
     }
 );
```

- #### GestureDetector

⼿势探测器


```
onTap: () // 单击
onDoubleTap: () // 双击
onLongPress: () // ⻓按
onTapCancel:() //取消
onTapUp:(e) //松开
onTapDown:(e) //按下
```

拖动⼿势主要由



```
onPanDown //⼿指按下
onPanUpdate //⼿指滑动
onPanEnd //滑动结束
onScaleUpdate:(ScaleUpdateDetails e) //缩放
GestureDetector(
 child: Text("点击"),
 onTap: () {}
}
```

- #### 代码及UI示例


```
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _viewBody(),
    );
  }

  Widget _viewBody() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // IconButton控件
        IconButton(
          onPressed: () => {print('点击了IconButton')},
          icon: Icon(Icons.home),
        ),

        // MaterialButton控件
        MaterialButton(
          onPressed: () {
            print('点击了materialButton');
          },
          color: Colors.blue,
          child: Text(
            '按钮',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),

        // InkWell
        InkWell(
          onTap: () {
            print('点击确定');
          },
          onDoubleTap: () {
            print('双击');
          },
          onLongPress: () {
            print('长按');
          },
          child: Container(
            alignment: Alignment.center,
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '确定',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),

        // gestureDetector监听控件的点击事件和拖移事件
        GestureDetector(
          onPanUpdate: (details) {
            print(details.globalPosition);
          },
          child: Container(
            margin: EdgeInsets.only(top: 10),
            width: 300,
            height: 300,
            color: Colors.blue,
          ),
        ),
      ]),
    );
  }
}

```

![inkwell](https://note.youdao.com/yws/public/resource/5d6c655379197c76acdc495cfa74cbcc/25A4748DF00F4823BECBF41C64259B6C?ynotemdtimestamp=1661700314661)


