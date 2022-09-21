import 'package:flutter/material.dart';

import 'style/video_control_bar_style.dart';

class VideoBottomBarContainer extends AnimatedWidget {
  VideoBottomBarContainer(
      {Key? key,
      required Animation<double> animation,
      required this.child,
      VideoControlBarStyle? videoControlBarStyle})
      : videoControlBarStyle = videoControlBarStyle ?? VideoControlBarStyle(),
        super(key: key, listenable: animation);

  final VideoControlBarStyle videoControlBarStyle;
  final Widget child;

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;

    return Positioned(
      bottom: animation.value,
      left: 0,
      right: 0,
      child: Container(
        margin: videoControlBarStyle.margin,
        padding: videoControlBarStyle.padding,
        height: videoControlBarStyle.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.transparent, videoControlBarStyle.barBackgroundColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: child,
      ),
    );
  }
}
