> ### 本节课⽬标
> - 掌弹Padding组件

- Padding Padding⽤来为⼦元素添加填充，也就是指定⼦元素与容器边界的距离，作⽤基本上与Android中ViewGroup的padding属性相同。


```
const Padding({
     Key key,
     @required this.padding,
     Widget child,
})
```


我们⼀般使⽤EdgeInsets类，它是EdgeInsetsGeometry的⼀个⼦类，定义了⼀些设置填充的便捷⽅法。

- EdgeInsets 我们看看EdgeInsets提供的便捷⽅法：

1. fromLTRB(double left, double top, double right, double bottom)：分别指定四个⽅向的填充。

2. all(double value) : 所有⽅向均使⽤相同数值的填充。

3. only({left, top, right ,bottom })：可以设置具体某个⽅向的填充(可以同时指定
多个⽅向)。

4. symmetric({ vertical, horizontal })：⽤于设置对称⽅向的填充，vertical指top
和bottom，horizontal指left和right。

接下来逐个演示这四个⽅法的⽤法：

- EdgeInsets.all


```
body: Padding(
     padding: EdgeInsets.all(16),
     child: Container(
     color: Colors.blue,
     )),
```

![EdgeInsets1](https://note.youdao.com/yws/public/resource/2ed0c80826ee08ea644226a033974b94/FD2880401E2247C39A497D4DF670C731?ynotemdtimestamp=1661846303557)
     
- EdgeInsets.symmetric


```
body: Padding(
     padding: EdgeInsets.symmetric(vertical: 48),
     child: Container(
     color: Colors.blue,
 )),
```

![EdgeInsets2](https://note.youdao.com/yws/public/resource/2ed0c80826ee08ea644226a033974b94/47B0390F3FF54C838E1C71DB64173404?ynotemdtimestamp=1661846303557)

- EdgeInsets.fromLTRB


```
body: Padding(
     padding: EdgeInsets.fromLTRB(16, 32, 48, 64),
     child: Container(
     color: Colors.blue,
     )),
```

![EdgeInsets3](https://note.youdao.com/yws/public/resource/2ed0c80826ee08ea644226a033974b94/47AA2C4DBBF249ACA7262C80D43FA2FA?ynotemdtimestamp=1661846303557)
     
- EdgeInsets.only


```
body: Padding(
     padding: EdgeInsets.only(left: 16, bottom: 32),
     child: Container(
     color: Colors.blue,
     )),
```

![EdgeInsets4](https://note.youdao.com/yws/public/resource/2ed0c80826ee08ea644226a033974b94/E43BAE8FCB684AF9B1E98469F86758A5?ynotemdtimestamp=1661846303557)

- #### 代码及UI示例


```
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

```

![navigation](https://note.youdao.com/yws/public/resource/2ed0c80826ee08ea644226a033974b94/BE4C8E04D5E6464EAECF3ACD20B854D3?ynotemdtimestamp=1661846303557)

