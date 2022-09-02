> ### 本节课⽬标
> 
> - 掌握Stateful（有状态） 和 stateless（⽆状态）区别
> - 掌握state的概念
> - 掌握刷新⻚⾯状态的时机



StatelessWidget和StatefulWidget是flutter的基础组件，⽇常开发中⾃定义Widget都是选择继承这两者之⼀。

两者的区别在于状态的改变，StatelessWidget⾯向那些始终不变的UI控件，⽐如标题栏中的标题；⽽StatefulWidget则是⾯向可能会改变UI状态的控件，⽐如有点击反馈的按钮。

- 有状态：交互或者数据改变导致Widget改变，例如改变⽂案
- ⽆状态：不会被改变的Widget，例如纯展示⻚⾯，数据也不会改变


#### StatelessWidget

StatelessWidget是⼀个没有状态的widget——没有要管理的内部状态。它通过构建⼀系列其他⼩部件来更加具体地描述⽤户界⾯，从⽽描述⽤户界⾯的⼀部分。当我们的⻚⾯不依赖Widget对象本身中的配置信息以及BuildContext时，就可以⽤到⽆状态组件。例如当我们只需要显示⼀段⽂字时。实际上Icon、Divider、Dialog、Text等都是StatelessWidget的⼦类。 StatelessWidget的基本使⽤如下：



```
class Less extends StatelessWidget {
  final String text;
  const Less({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Text(text);
  }
}
```


`Less` 包含了⼀个从外部接受⼀个不可变的数据源text并将它显示。 ⽆状态的组件的声明周期只有⼀个： `build` ，它只会在三种情况下被调⽤:
将 `widget` 插⼊树中的时候，也就是第⼀次构建 当 `widget` 的⽗级更改了其配置时，例如， `Less` 的⽗类改变了 `text` 的值 当它依赖的 `InheritedWidget` 发⽣变化时

#### StatefulWidget

StatefulWidget是可变状态的widget。使⽤setState⽅法管理StatefulWidget的状态的改变。调⽤setState通知Flutter框架某个状态发⽣了变化，Flutter会重新运⾏build⽅法，应⽤程序变可以显示最新的状态。 状态是在构建widget的时候，widget可以同步读取的信息，⽽这些状态会发⽣变化。要确保在状态改变的时候即使通知widget进⾏动态更改，就需要⽤到StatefulWidget。例如⼀个计数器，我们点击按钮就要让数字加⼀。在Flutter中，Checkbox、FadeImage等都是有状态组件。

StatefulWidget的基本使⽤如下：


```
class Full extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Full();
  }
}

class _Full extends State<Full> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
      onTap: onClick,
      child: new Text("$count"),
    );
  }

  void onClick() {
    setState(() {
      count += 1;
    });
  }
}

```


`Full` 包含了⼀个内部持有的 `int` 状态，每次点击⾃增⼀，平使⽤ `setState` 刷新⻚⾯显示最新的值。

#### StatefulWidget和StatelessWidget的实⽤场景

在涉及到 `Widget` 的⼯作时，遇到的头等⼤事就是确定 `widget` 应该使⽤
`StatefulWidget`还是`StatelessWidget ？` 简单的说，如果不需要⾃⼰维持状态就使⽤ `StatelessWidget` ，否则使⽤ `StatefulWidget` 。 进⼀步分析，根据上⽂的介绍，我们不难发现：

- 如果⽤户交互或数据改变导致widget改变，那么它就是有状态的。
- 如果⼀个widget是最终的或不可变的，那么它就是⽆状态

#### 代码及UI示例

main.dart

```
import 'package:flutter/material.dart';
import 'package:flutter_lesson_4_1/counter_page.dart';

void main() {
  runApp(const MaterialApp(home: CounterPage()));
}

```

counter_page.dart


```
import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _number = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('计数器'),
      ),
      body: _viewBody(),
    );
  }

  Widget _viewBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: () {
                print(_number);
                setState(() {
                  _number--;
                });
              },
              child: Text('计数器-1'),
              color: Colors.blue,
            ),
            Text(_number.toString()),
            MaterialButton(
              onPressed: () {
                setState(() {
                  _number++;
                });
                print(_number);
              },
              child: Text('计数器+1'),
              color: Colors.blue,
            ),
          ],
        )
      ],
    );
  }
}

```

![Screenshot_1662119724](https://note.youdao.com/yws/public/resource/fb03b92ee6943b8c1984c9c0d87d8f79/94A30EA3475B4D6F873A3BE78785422E?ynotemdtimestamp=1662121135087)