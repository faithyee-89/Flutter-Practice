> ### 本节课⽬标
> 1. 掌握Container组件绘制圆⻆的实现
> 2. 掌握Container组件阴影的实现
> 3. 掌握Container内边距、外边距的使⽤⽅法
> 4. 掌握Container作为⽗组件配合其他布局组件使⽤

- #### Container组件

⼀个便利的控件，结合了常⻅的绘画，定位和⼤⼩调整。

Container的参数：


```
Container({
     Key key,
     this.alignment, // 对齐方式
     this.padding, // Widget边框和内容区之间距离
     Color color, // 背景颜色
     Decoration decoration, // 绘制信息
     this.foregroundDecoration,
     double width, // 宽度
     double height, // 高度
     BoxConstraints constraints,
     this.margin, // Widget与父边框的距离
     this.transform, // 让 Container 容易进行一些旋转之类的
     this.child, // 子控件
 })
```

- #### Container圆角


```
Container(
     decoration: new BoxDecoration(
     color: Colors.white,
     borderRadius: new BorderRadius.circular((20.0.wDp)),
 ),
```


- #### Container阴影


```
Container(
     decoration: new BoxDecoration(
     boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 20.0.wDp)],
     color: Colors.white,
     borderRadius: new BorderRadius.circular((20.0.wDp)),
 ),
```

- #### 代码及UI示例


```
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
          width: 100,
          height: 100,
          // padding: EdgeInsets.all(10),
          // padding: EdgeInsets.only(top: 20, left: 20, bottom: 10, right: 30),
          // margin: EdgeInsets.all(10),
          // margin: EdgeInsets.only(top: 100),
          // 圆角
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.orange,
            // 阴影
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 20,
              )
            ]
          ),
          child: Icon(Icons.home),
        ),
      ),
        ),
    );
  }
}



```

![icon](https://note.youdao.com/yws/public/resource/6a03ae16526f0d75671a440da40c4f51/E129B37D8DC64AFABF8D57602ABEEB31?ynotemdtimestamp=1661655115262)











