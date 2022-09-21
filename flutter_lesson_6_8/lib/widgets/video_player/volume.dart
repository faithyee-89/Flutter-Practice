import 'dart:async';

import 'package:cainiaowo/common/values/index.dart';
import 'package:cainiaowo/widgets/video_player/common.dart';
import 'package:flutter/material.dart';

class VolumeBar extends StatefulWidget {
  // final Stream<double> emitter;

  /// 值,0-100区间
  final double initial;

  // type 0 volume
  // type 1 screen brightness
  final int type;

  VolumeBar(
    this.initial,
    this.type,
  );

  /// 屏幕亮度
  VolumeBar.screenBrightness(this.initial) : type = 1;

  /// 声音
  VolumeBar.volume(this.initial) : type = 0;

  @override
  _VolumeBarState createState() => _VolumeBarState();
}

class _VolumeBarState extends State<VolumeBar> {
  double value = 0;
  // StreamSubscription? subs;

  @override
  void initState() {
    super.initState();
    value = widget.initial;
    // subs = widget.emitter.listen((v) {
    //   setState(() {
    //     value = v;
    //   });
    // });
  }

  @override
  void dispose() {
    super.dispose();
    // subs?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    final type = widget.type;
    if (value <= 0) {
      iconData = type == 0 ? Icons.volume_mute : Icons.brightness_low;
    } else if (value < 50) {
      iconData = type == 0 ? Icons.volume_down : Icons.brightness_medium;
    } else {
      iconData = type == 0 ? Icons.volume_up : Icons.brightness_high;
    }

    final primaryColor =
        AppColors.primaryColor; // Theme.of(context).primaryColor;
    return Align(
      alignment: Alignment(0, -0.4),
      child: Card(
        color: Common.colorOverlayBackground,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                iconData,
                color: Colors.white,
              ),
              Container(
                width: 100,
                height: 5,
                margin: EdgeInsets.only(left: 8),
                child: LinearProgressIndicator(
                  value: value / 100,
                  backgroundColor: Colors.black12,
                  valueColor: AlwaysStoppedAnimation(primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
