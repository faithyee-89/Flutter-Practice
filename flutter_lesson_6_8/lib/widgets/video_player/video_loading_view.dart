import 'package:cainiaowo/widgets/video_player/style/video_loading_style.dart';
import 'package:flutter/material.dart';

class VideoLoadingView extends StatelessWidget {
  VideoLoadingView({required this.style});

  final VideoLoadingStyle style;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            style.customLoadingIcon,
            style.customLoadingText ??
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      style.loadingText,
                      style: TextStyle(
                        color: style.loadingTextFontColor,
                        fontSize: style.loadingTextFontSize,
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}
