import 'package:flutter/material.dart';

/// 进度条样式
class VideoTopBarStyle {
  VideoTopBarStyle({
    this.height = 36,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
    this.barBackgroundColor = const Color.fromRGBO(0, 0, 0, 0.5),
    this.backIcon = const Icon(
      Icons.arrow_back,
      size: 18,
      color: Colors.white,
    ),
    this.titleStyle = const TextStyle(color: Colors.white, fontSize: 16),
    this.actions = const [],
    this.customBar,
  });

  final double height;
  EdgeInsets margin;
  final EdgeInsets padding;
  final Color barBackgroundColor;
  //返回按钮
  final Widget backIcon;

  final TextStyle titleStyle;

  final List<Widget> actions;
  final Widget? customBar;
}
