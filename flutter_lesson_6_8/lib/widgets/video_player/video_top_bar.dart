import 'package:flutter/material.dart';
import 'style/video_control_bar_style.dart';
import 'style/video_top_bar_style.dart';

class VideoTopBar extends AnimatedWidget {
  VideoTopBar(
      {Key? key,
      this.title,
      required Animation<double> animation,
      VideoControlBarStyle? videoControlBarStyle,
      VideoTopBarStyle? videoTopBarStyle,
      this.onTap})
      : style = videoTopBarStyle ?? VideoTopBarStyle(),
        videoControlBarStyle = videoControlBarStyle ?? VideoControlBarStyle(),
        super(key: key, listenable: animation);

  final String? title;
  final VideoTopBarStyle style;
  final VideoControlBarStyle videoControlBarStyle;
  final Function? onTap;

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;

    return style.customBar ??
        Positioned(
          top: animation.value,
          left: 0,
          right: 0,
          child: Container(
            margin: style.margin,
            padding: style.padding,
            height: style.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                videoControlBarStyle.barBackgroundColor,
                Colors.transparent
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                /// 返回按钮
                GestureDetector(
                  onTap: () {
                    if (onTap != null) {
                      onTap!();
                      return;
                    }
                  },
                  child: style.backIcon,
                ),

                /// 中部控制栏
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      title ?? "",
                      style: style.titleStyle,
                    ),
                  ),
                ),

                /// 右侧部控制栏
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: style.actions,
                )
              ],
            ),
          ),
        );
  }
}
