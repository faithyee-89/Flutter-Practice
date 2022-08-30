> ### 本节课⽬标
> - 深⼊了解Flutter对⻬⽅式和相对定位
> - 掌弹Align组件

Flutter为我们提供了⼀种相对布局的组件：Align，Align组件允许我们通过修改它的属性来调整⼦组件的位置，并且可以根据⼦组件的宽⾼来确定Align⾃身的的宽⾼。

Align⽤来确定⼦控件在⽗布局中的位置，定义如下


```
const Align({
     Key key,
     this.alignment = Alignment.center,
     this.widthFactor,
     this.heightFactor,
     Widget child,
})
```


- alignment ⾸先我们来看⼀下Align组件的alignment属性，我们可以通过它修改⼦组件的相对位置。废话不多说，上代码：


```
Container(
     width: 300,
     height: 300,
     color: Colors.blue,
     child: const Align(
     alignment: Alignment(1.0, 1.0),
     child: Text('菜鸟窝'),
     ),
 )
```

 
 ![叠层布局1](https://note.youdao.com/yws/public/resource/91fba71f4e4b403311a6cb9b17f9c704/DA69F97C1D2A4A3FAF1C977192F19A0C?ynotemdtimestamp=1661844716287)
 
 我们看到：通过设置Align的alignment属性值为Alignment.bottomRight。则Align的child内容会显示在其⽗Widget的右下⻆。

Align同Stack⼀样，都有⼀个alignment属性，且它的值都是⼀个Alignment实例，Alignment除了可以设置相对位置外，还提供了两个属性x、y，表示在⽔平和垂直⽅
向的偏移。

在Align中⼦Widget会以⽗Widget的中⼼点为坐标原点（x、y值都为0），在⽔平⽅向上⽗Widget的最左侧边为x = -1，最右侧边为x = 1，在垂直⽅向上，最上⾯⼀条边的值为y = -1，最底部的边值为y = 1。


因此⼀个矩形Widget四个顶点的座标分别为：

左上顶点：Alignment(-1.0, -1.0)

右上顶点：Alignment(-1.0, 1.0)

左下顶点：Alignment(1.0, -1.0)

右下顶点：Alignment(1.0, 1.0)

⽽上⾯代码的Alignment.bottomRight的值便是Alignment(1.0, -1.0)

由此我们再来看⼀段代码：


```
Container(
     width: 300,
     height: 300,
     color: Colors.blue,
     child: const Align(
     alignment: Alignment(0, -1.0),
     child: Text('菜鸟窝'),
     ),
 )
```

 
运⾏结果：

![叠层布局2](https://note.youdao.com/yws/public/resource/91fba71f4e4b403311a6cb9b17f9c704/49ECC55236464CD68FA3BFA5C9DB6866?ynotemdtimestamp=1661844716287)

解释：设置x=0，则⼦widget相对于⽗widget⽔平⽅向上居中。设置y = -1，则⼦widget于垂直⽅向上顶部对⻬。

如果⼦x、y值⼤于1或⼩于-1，则会超出⽗widget的范围。

如果我们设置alignment: Alignment(1.5, -1)，则显示效果如下：

- FractionalOffset alignment属性不仅可以设置Alignment对象，也可以设置FractionalOffset，FractionalOffset是继承⾃Alignment的。FractionalOffset与
Alignment不同的是，它的坐标原点在矩形Widget的左上顶点，在⽔平⽅向上⽗Widget的最左侧边为x = 0，最右侧边为x = 1，在垂直⽅向上，最上⾯⼀条边的值为y = 0，最底部的边值为y = 1。由此我们可以得知，矩形Widget的四个顶
点坐标为：

左上顶点：FractionalOffset(0, 0)

右上顶点：FractionalOffset(0, 1)

左下顶点：FractionalOffset(1, 0)

右下顶点：FractionalOffset(1, 1)

照例，我们来看⼀段代码：


```
Container(
     width: 300,
     height: 300,
     color: Colors.blue,
     child: const Align(
     alignment: FractionalOffset(1, 1),
     child: Text('菜鸟窝'),
     ),
 )
```

 
运⾏效果：

![叠层布局3](https://note.youdao.com/yws/public/resource/91fba71f4e4b403311a6cb9b17f9c704/D34EE6E8F4764D5BB0D00D10CB9EECA5?ynotemdtimestamp=1661844716287)

- Align的⼤⼩Align给我们提供了另外两个属性widthFactor、heightFactor供我们来根据⼦Wdiget的⼤⼩修改Align的⼤⼩。如下代码：


```
Align(
     widthFactor: 5,
     heightFactor: 5,
     alignment: Alignment.bottomRight,
     child: Container(
     width: 50,
     height: 50,
     color: Colors.black,
     )
);
```


其Align的宽度⼤⼩widthFactor * Container的width。⾼度⼤⼩为heightFactor *
Container的height。因此此段代码的Align宽⾼均为5 * 50。

运⾏效果如下，红⾊⽅框便是Align的⼤⼩：

如果不设置widthFactor、heightFactor的值，则Align的宽⾼将会占⽤尽可能多的空间

如下代码：


```
Align(
     alignment: Alignment.bottomRight,
     child: Container(
     width: 50,
     height: 50,
     color: Colors.black,
     )
);
```


运⾏效果为⿊⾊区域在整个屏幕区域的右下⻆，说明Align的宽⾼为整个屏幕的宽⾼。

Align与Stack的区别 Align和Stack的相同点：

可以设置⼦Widget相对于⽗Widget的位置信息 都可以设置alignment属性来确定⼦Widget的坐标原点及位置信息。（Stack仅对未设置Positioned对⻬⽅式的Widget起作⽤） Align和Stack的不同点：

Stack的定位是通过Positioned来设置相对四个边的距离。Align则通过alignment对象来确定座标原点，根据坐标原点来确定⼦Widget的具体位置。 Stack中有Children属性，可以设置多个⼦Widget。Align中为Child属性，只能设置⼀个⼦
Widget。


- #### 代码及UI示例


```
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

```

![stack2](https://note.youdao.com/yws/public/resource/91fba71f4e4b403311a6cb9b17f9c704/7875F1D5B2E84405B85F5BB2D2EF33C5?ynotemdtimestamp=1661844716287)