import 'package:flutter/material.dart';

class VideoLoadingStyle {
  VideoLoadingStyle({
    this.customLoadingIcon = const CircularProgressIndicator(strokeWidth: 2.0),
    this.customLoadingText,
    this.loadingText = "",
    this.loadingTextFontColor = Colors.white,
    this.loadingTextFontSize = 20,
  });

  final Widget customLoadingIcon;
  final Widget? customLoadingText;
  final String loadingText;
  final Color loadingTextFontColor;
  final double loadingTextFontSize;
}
