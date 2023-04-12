import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyAppV4(),
    // home: MyAppV3(),
    // home: MyAppV2(),
  ));
}

class MyAppV4 extends StatelessWidget {
  const MyAppV4({Key? key}) : super(key: key);

  // 继承自父类
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
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
    );
  }
}

class MyAppV3 extends StatelessWidget {
  const MyAppV3({Key? key}) : super(key: key);

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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

class MyAppV2 extends StatelessWidget {
  const MyAppV2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  width: 100,
                  color: Colors.blue,
                )),
            Expanded(
                flex: 1,
                child: Container(
                  width: 100,
                  color: Colors.red,
                )),
            Expanded(
                flex: 1,
                child: Container(
                  width: 100,
                  color: Colors.pink,
                ))
          ],
        ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // 继承自父类
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
