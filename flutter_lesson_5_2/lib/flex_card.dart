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
