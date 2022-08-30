> ### 本节课⽬标
> - 掌弹Appbar组件（导航栏）


```
AppBar({
     Key key,
     this.leading,//导航条左侧需要展示的Widget
     this.automaticallyImplyLeading = true,
     this.title,//导航条的标题
     this.actions,//导航条右侧要展示的一组widgets
     this.flexibleSpace,
     this.bottom,导航条底部需要展示的widget
     this.elevation,
     this.shape,//导航条样式
     this.backgroundColor,//导航条背景色
     this.brightness,//设置导航条上面的状态栏的dark、light状态
     this.iconTheme,//导航条上的图标主题
     this.actionsIconTheme,//导航条上右侧widgets主题
     this.textTheme,//导航条上文字主题
     this.primary = true,//为false的时候会影响leading，actions、titile组
    件，导致向上偏移
     this.centerTitle,//导航条表示是否居中展示
     this.titleSpacing = NavigationToolbar.kMiddleSpacing,
     this.toolbarOpacity = 1.0,
     this.bottomOpacity = 1.0,
 })
```

 
- 参数详解：

⼀般我们都是指定==title== 来指定导航栏的标题，除此之外可以⾃定义⼀些导航栏按钮等操作

==centerTitle==属性能够指定所有的标题都会居中，默认情况下，⽂字标题 title 属性在 ios 上是居中的，⽽在 android 上不是居中的，靠近左边

==leading==能够指定左侧的图标按钮，在某些⾸⻚或者 tab 情况下，因此不需要返
回，可能唤起⼀个==Drawer==，⼀般会在导航左侧加⼀个图标，点击唤起==drawer==

==actions==⽤来在导航左侧添加⼀系列的按钮或者⽂字==actions==接收⼀个
==List<Widget>== 数据，理论上什么类型的==Widget== 都可以塞进去

==evaluation==是导航栏底部的阴影，在==material  design==中，是建议留着的，如果指定 0 就可以不显示阴影。

==backgroundColor==⽤来指定背景⾊，可以直接传颜⾊值

==iconTheme==和==actionIconTheme==都可以指定 themedata 不需要单个 icon 去指定颜⾊等

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
```

![appbar](https://note.youdao.com/yws/public/resource/e6feb7a954bc258fb4f32bd7d8b479d2/3B619A27639F4B3587EC39BE1583C180?ynotemdtimestamp=1661847315623)
