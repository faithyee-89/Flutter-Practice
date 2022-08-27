## Flutter线性布局
> ### 本节课⽬标
> 1. ⼊⼝函数
> 2. 掌握Row⽔平布局组件
> 3. 掌握Column垂直布局组件



- ### runApp

runAppFlutter框架的根函数，接受⼀个Widget作为根

- ### MaterialApp

MaterialApp 封装了应⽤程序实现 Material Design 所需要的⼀些 Widget。⼀般作为根 widget 使⽤

- ### Scaffold

Scaffold 是 Material Design 布局结构的基本实现。我们可以理解为是⼀个⻚⾯的脚⼿架。

- ### Flutter Row 水平布局组件


```
Row({
     Key key, // key
     MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    // 子控件放置方式
     MainAxisSize mainAxisSize = MainAxisSize.max, // 子控件应该如何沿着主轴放置
     CrossAxisAlignment crossAxisAlignment =
     CrossAxisAlignment.center, // 子控件对齐方式
     TextDirection textDirection, // 从左到右，还是从右到左排序
     VerticalDirection verticalDirection = VerticalDirection.down,
    // 垂直排序
     TextBaseline textBaseline, // 对齐文本的水平线
     List<Widget> children = const <Widget>[], // 子控件
 })
```

MainAxisAlignment子组件沿着 Main 轴（在 Row 中是横轴）如何摆放，其实就是子组
件排列方式
参数：

```

```js
enum MainAxisAlignment {
     start, //将子控件放在主轴的开始位置
    
     end,//将子控件放在主轴的结束位置
     center, //将子控件放在主轴的中间位置
    
     spaceBetween,//将主轴空白位置进行均分，排列子元素，手尾没有空隙
    
     spaceAround,//将主轴空白区域均分，使中间各个子控件间距相等，首尾子控件间距为
    中间子控件间距的一半
     spaceEvenly, //将主轴空白区域均分，使各个子控件间距相等
}
```

#### 1. MainAxisAlignment案例：代码及UI示例


```
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // 继承自父类
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        /**
         * center表示将子控件放在主轴的中间位置
         * end表示将子控件放在主轴的末端位置
         * spaceAround表示将子控件水平均等距离放在主轴上
         * spaceBetween表示首个元素放置于起点，末尾元素放置于终点，其余控件均等放在主轴上
         * spaceEvenly表示将子控件水平均等距离放在主轴上，间隔距离相等
         * 
         * 
         */
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            color: Colors.blue,
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.red,
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.pink,
          )

        ]),
    );
  }
}

```

##### 1.1 属性MainAxisAlignment.center示例

```
mainAxisAlignment: MainAxisAlignment.center,
```


![center](https://note.youdao.com/yws/public/resource/4f710f10111909ea20a3c01f44d3d88b/FF893B6E5C6F41699F4278E0FCDE6655?ynotemdtimestamp=1661618640987)

##### 1.2 属性MainAxisAlignment.end示例

```
mainAxisAlignment: MainAxisAlignment.end,
```

![end](FF893B6E5C6F41699F4278E0FCDE6655)

##### 1.3 属性MainAxisAlignment.spaceAround示例

```
mainAxisAlignment: MainAxisAlignment.spaceAround,
```

![spaceAround](23F30249BC194A1A8AB73C114103736E)

##### 1.4 属性MainAxisAlignment.spaceBetween示例

```
mainAxisAlignment: MainAxisAlignment.spaceBetween,
```

![spaceBetween](0C55696AF1754B4294C4B51290F12172)

##### 1.5 属性MainAxisAlignment.spaceEvenly示例

```
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
```

![spaceEvenly](639A112DA935483189DD8A8FBA4F9FD0)










#### 2. crossAxisAlignment案例：代码及UI示例


```
/**
 * crossAxisAlignment: CrossAxisAlignment.xxx,
 * start:子组件在row中顶部对齐
 * end:子组件在row中底部对齐
 * center:
 * stretch:子组件在row中拉升填充
 * 
 */
crossAxisAlignment: CrossAxisAlignment.start,
children: [
  Container(
    height: 100,
    width: 100,
    color: Colors.blue,
  ),
  Container(
    height: 200,
    width: 100,
    color: Colors.red,
  ),
  Container(
    height: 300,
    width: 100,
    color: Colors.pink,
  )

]),
```
##### 2.1 属性CrossAxisAlignment.start示例

```
crossAxisAlignment: CrossAxisAlignment.start,
```

![start](20EE7DB81E5440B7A582AF0AADFB12EB)

##### 2.2 属性CrossAxisAlignment.end示例

```
crossAxisAlignment: CrossAxisAlignment.end,
```

![end](B096D69B51CF4DB798DC6D94B6652E97)

##### 2.3 属性CrossAxisAlignment.center示例

```
crossAxisAlignment: CrossAxisAlignment.center,
```

![center](140F864DF70740D58BBBF55FF2C23FE8)

##### 2.4 属性CrossAxisAlignment.stretch示例

```
crossAxisAlignment: CrossAxisAlignment.stretch,
```

![stretch](C67AF730A009431F95C7BB36118C53AA)

- ### Flutter Expanded 平均分布控件

#### 1. Expanded代码及UI示例

```
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // 继承自父类
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
            height: 100,
            color: Colors.blue,
          )),
          Expanded(
            flex: 2,
            child: Container(
            height: 100,
            color: Colors.red,
          )),
          Expanded(
            flex: 3,
            child: Container(
            height: 100,
            color: Colors.pink,
          ))

        ]),
    );
  }
}

```

![expanded](E5E471FB074C4BA1928266819A1E1738)

- ### Flutter Column 垂直布局组件


```
Column({
     Key key,
     MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
     MainAxisSize mainAxisSize = MainAxisSize.max,
     CrossAxisAlignment crossAxisAlignment =
     CrossAxisAlignment.center,
     TextDirection textDirection,
     VerticalDirection verticalDirection = VerticalDirection.down,
     TextBaseline textBaseline,
     List<Widget> children = const <Widget>[],
 })
```

#### 1. Column代码及UI示例


```
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // 继承自父类
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
            width: 100,
            color: Colors.blue,
          )),
          Expanded(
            flex: 2,
            child: Container(
            width: 100,
            color: Colors.red,
          )),
          Expanded(
            flex: 3,
            child: Container(
            width: 100,
            color: Colors.pink,
          ))

        ]),
    );
  }
}

```
![column](B4537759D75A40ECB081877FFAB17498)




- ### 总结

    - MaterialApp⼊⼝组件
    - Scaffold 脚⼿架组件
    - Paddiing组件
    - Row⽔平布局组件
    - Column垂直布局组件