import 'package:flutter/material.dart';
import './video_progress_style.dart';

const double iconSize = 18;

/// 底部控制拦样式
class VideoControlBarStyle {
  VideoControlBarStyle({
    this.height = 50,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
    this.progressStyle = const VideoProgressStyle(), //进度条样式
    this.playedColor = const Color.fromRGBO(255, 0, 0, 0.7), //几个版本后移除
    this.bufferedColor = const Color.fromRGBO(50, 50, 200, 0.2), //几个版本后移除
    this.backgroundColor = const Color.fromRGBO(200, 200, 200, 0.5), //几个版本后移除
    this.barBackgroundColor = const Color.fromRGBO(0, 0, 0, 0.5),
    this.timePadding = const EdgeInsets.symmetric(horizontal: 4),
    this.timeFontSize = 11,
    this.timeFontColor = const Color.fromRGBO(255, 255, 255, 1),
    this.playIcon = const Icon(
      Icons.play_circle_outline,
      size: iconSize,
      color: Color(0xFFFFFFFF),
      semanticLabel: "播放",
    ),
    this.pauseIcon = const Icon(
      Icons.pause_circle_outline,
      size: iconSize,
      color: Color(0xFFFFFFFF),
      semanticLabel: "暂停",
    ),
    this.rewindIcon = const Icon(
      Icons.fast_rewind,
      size: iconSize,
      color: Color(0xFFFFFFFF),
      semanticLabel: "快退",
    ),
    this.forwardIcon = const Icon(
      Icons.fast_forward,
      size: iconSize,
      color: Color(0xFFFFFFFF),
      semanticLabel: "快进",
    ),
    this.fullscreenIcon = const Icon(
      Icons.fullscreen,
      size: iconSize,
      color: Color(0xFFFFFFFF),
      semanticLabel: "全屏",
    ),
    this.fullscreenExitIcon = const Icon(
      Icons.fullscreen_exit,
      size: iconSize,
      color: Color(0xFFFFFFFF),
      semanticLabel: "退出全屏",
    ),
    this.itemList = const [
      "rewind",
      "play",
      "forward",
      "progress",
      "time",
      "fullscreen"
    ],
  });

  final double height;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final VideoProgressStyle progressStyle;
  final Color playedColor;
  final Color bufferedColor;
  final Color backgroundColor;
  final Color barBackgroundColor;
  final EdgeInsets timePadding;
  final double timeFontSize;
  // final double iconSize;
  final Color timeFontColor;
  final Widget playIcon;
  final Widget pauseIcon;
  final Widget rewindIcon;
  final Widget forwardIcon;
  final Widget fullscreenIcon;
  final Widget fullscreenExitIcon;
  final List<String> itemList;

  VideoControlBarStyle copyWith({
    double? height,
    EdgeInsets? padding,
    EdgeInsets? margin,
    VideoProgressStyle? progressStyle,
    Color? playedColor,
    Color? bufferedColor,
    Color? backgroundColor,
    Color? barBackgroundColor,
    EdgeInsets? timePadding,
    double? timeFontSize,
    Color? timeFontColor,
    Widget? playIcon,
    Widget? pauseIcon,
    Widget? rewindIcon,
    Widget? forwardIcon,
    Widget? fullscreenIcon,
    Widget? fullscreenExitIcon,
    List<String>? itemList,
  }) {
    return VideoControlBarStyle(
      height: height ?? this.height,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      progressStyle: progressStyle ?? this.progressStyle,
      playedColor: playedColor ?? this.playedColor,
      bufferedColor: bufferedColor ?? this.bufferedColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      barBackgroundColor: barBackgroundColor ?? this.barBackgroundColor,
    );
  }
}
