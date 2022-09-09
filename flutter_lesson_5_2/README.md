> ### 本节课目标
> - 掌握Flutter基础动画


#### 动画原理
在⼀段时间内快速的多次改变UI外观，由于⼈眼会产⽣视觉暂留所以最终看到的就是⼀个连续的动画。UI的⼀次改变称为⼀个动画帧，对应⼀次屏幕刷新。 FPS：帧率，每秒的动画帧数。

#### 动画的类型

在Flutter中动画分为两类：基于tween或基于物理的。

1. 补间(Tween)动画：在补间动画中，定义了开始点和结束点、时间线以及定义转换时间和速度的曲线。然后由框架计算如何从开始点过渡到结束点；
2. 基于物理的动画：在基于物理的动画中，运动被模拟为与真实世界的⾏为相似。

#### 动画的使用
- Animation：是Flutter动画库中的⼀个核⼼类，它⽣成指导动画的值；
- AnimationController：Animation的⼀个⼦类，⽤来管理Animation；
- Tween：在正在执⾏动画的对象所使⽤的数据范围之间⽣成值。例如，Tween可⽣成从红到蓝之间的⾊值，或者从0到255；
- AnimatedBuilder：是拆分动画的⼀个⼯具类，借助它我们可以将动画和widget进⾏分离，⽽AnimatedWidget理解为Animation的助⼿，使⽤它可以简化我们对动画的使用；
- Curve：Flutter中可以通过Curve（曲线）来描述动画过程；
- Ticker：的作⽤是添加屏幕刷新回调，每次屏幕刷新都会调⽤TickerCallback；

#### Animation

在Flutter中，Animation对象本身和UI渲染没有任何关系。Animation是⼀个抽象类，它拥有其当前值和状态（完成或停⽌）。其中⼀个⽐较常⽤的Animation类是Animation<double>。

Flutter中的Animation对象是⼀个在⼀段时间内依次⽣成⼀个区间之间值的类。

Animation对象的输出可以是线性的、曲线的、⼀个步进函数或者任何其他可以设计的映射。 根据Animation对象的控制⽅式，动画可以反向运⾏，甚⾄可以在中间切换⽅向。
1. Animation还可以⽣成除double之外的其他类型值，如：Animation<Color>或Animation<Size>；
2. Animation对象有状态。可以通过访问其value属性获取动画的当前值；
3. Animation对象本身和UI渲染没有任何关系；

#### AnimationController
AnimationController是⼀个特殊的Animation对象，在屏幕刷新的每⼀帧，就会⽣成⼀个新的值。默认情况下，AnimationController在给定的时间段内会线性的⽣成从0.0到1.0的数字。例如，下⾯代码创建⼀个Animation对象：


```
final AnimationController controller = new AnimationController(
 duration: const Duration(milliseconds: 2000), vsync: this);
```

AnimationController控制动画的⽅法：
1. forward()：启动动画；
2. reverse({double from})：倒放动画；
3. reset()：重置动画，将其设置到动画的开始位置；
4. stop({ bool canceled = true})：停⽌动画；

当创建⼀个AnimationController时，需要传递⼀个vsync参数，存在vsync时会防⽌屏幕外动画消耗不必要的资源，可以将stateful对象作为vsync的值。

#### Tween

默认情况下，AnimationController对象值为:double类型，范围是0.0到1.0。如果我们需要不同的范围或不同的数据类型，则可以使⽤Tween来配置动画以⽣成不同的范围或数据类型的值。例如，以下示例，Tween⽣成从-200.0到0.0的值：


```
final Tween doubleTween = new Tween<double>(begin: -200.0, end:
0.0);
```

#### Tween.animate
要使⽤Tween对象，可调⽤它的animate()⽅法，传⼊⼀个控制器对象。例如，以下代码在500毫秒内⽣成从0到255的整数值。


```
final AnimationController controller = new AnimationController(
 duration: const Duration(milliseconds: 500), vsync: this);
Animation<int> alpha = new IntTween(begin: 0, end:
255).animate(controller);
```

#### Curve
动画过程默认是线性的(匀速)，如果需要⾮线形的，⽐如：加速的或者先加速后减速等。Flutter中可以通过Curve（曲线）来描述动画过程。以下示例构建了⼀个控制器、⼀条曲线和⼀个Tween：


```
final AnimationController controller = new AnimationController(
 duration: const Duration(milliseconds: 500), vsync: this);
final Animation curve =
 new CurvedAnimation(parent: controller, curve: Curves.easeOut);
Animation<int> alpha = new IntTween(begin: 0, end:
255).animate(curve);
```

Curves | 动画过程
--- | ---
linear| 匀速的
decelerate |匀减速
ease| 开始加速，后⾯减速
easeIn| 开始慢，后⾯快
easeOut |开始快，后⾯慢
easeInOut| 开始慢，然后加速，最后再减速

#### Ticker

Ticker的作用是添加屏幕刷新回调，每次屏幕刷新都会调用TickerCallback。使用Ticker来驱动动画会防止屏幕外动画（动画的UI不在当前屏幕时，如锁屏时）消耗不必要的资源。因为Flutter中屏幕刷新时会通知Ticker，锁屏后屏幕会停止刷新，所以Ticker就不会再触发。一般情况下都是将SingleTickerProviderStateMixin添加到State的类定义中。

#### 代码及UI示例

![GIF 2022-9-9 14-46-58](https://note.youdao.com/yws/public/resource/86f34597060e3a733a7f48629a429f0a/CB2DD70B412C48DCB246CE4E5EADBCD3?ynotemdtimestamp=1662707274602)

- home_page.dart


```
import 'package:flutter/material.dart';
import 'package:flutter_lesson_5_2/flex_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlexCarPage(
            backView: Card(
              color: Colors.white,
              elevation: 2,
              child: Container(
                alignment: Alignment.center,
                height: 70,
                width: 250,
                child: Text(
                  '猫咪：要需要出去玩！！！',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            frontView: SizedBox(
              height: 180,
              width: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                    'http://pic1.win4000.com/wallpaper/2018-12-07/5c0a0d5496d70.jpg'),
              ),
            )),
      ),
    );
  }
}

```

- flex_card.dart


```
import 'package:flutter/material.dart';

class FlexCarPage extends StatefulWidget {
  FlexCarPage({
    Key? key,
    required this.backView,
    required this.frontView,
  }) : super(key: key);

  Widget frontView;
  Widget backView;
  @override
  State<FlexCarPage> createState() => _FlexCarPageState();
}

class _FlexCarPageState extends State<FlexCarPage>
    with TickerProviderStateMixin {
  /// 动画控制器
  late AnimationController animationController;

  Tween<double> separatedValue = Tween(begin: 0.0, end: 80.0);

  late Animation animationValue = separatedValue.animate(animationController);

  Curve animationCurve = Curves.easeIn;

  /// 当前是否展开
  bool isSeparated = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animationController.addListener(() {
      setState(() {});
    });
  }

  /// 关闭或者打开卡片
  void openOrColseCard() {
    isSeparated == false
        ? animationController.forward() // 动画执行
        : animationController.reverse(); // 动画反向执行

    isSeparated = !isSeparated;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: animationCurve,
      child: Stack(
        children: [
          Transform.translate(
            offset: Offset(0.0, animationValue.value),
            child: widget.backView,
          ),
          InkWell(
            onTap: openOrColseCard,
            child: Transform.translate(
              offset: Offset(0.0, -animationValue.value),
              child: widget.frontView,
            ),
          ),
        ],
      ),
    );
  }
}

```


