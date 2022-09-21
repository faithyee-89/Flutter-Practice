import 'package:auto_orientation/auto_orientation.dart';
import 'package:cainiaowo/widgets/video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tx_super_player/cniao5_super_player.dart';

class PlayerUtil {
  static void toggleFullScreen(
      BuildContext context, VideoPlayerController controller) {
    if (controller.value.isFullScreen) {
      exitFullScreen(context, controller);
    } else {
      enterFullScreen(context, controller);
    }
  }

  static void exitFullScreen(
      BuildContext context, VideoPlayerController controller) {
    /// 如果是全屏就切换竖屏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    AutoOrientation.portraitUpMode();
    controller.setFullScreen(false);
    Navigator.pop(context);
  }

  static void enterFullScreen(
      BuildContext context, VideoPlayerController controller) {
    controller.setFullScreen(true);
    AutoOrientation.landscapeAutoMode();
    // ///关闭状态栏，与底部虚拟操作按钮
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return VideoFullScreenPage(controller);
    }));
  }

  /// 格式化播放器上的时间
  static String formatDuration(Duration duration) {
    if (duration.inMilliseconds < 0) {
      return "00:00";
    }
    String twoDigits(int n) {
      if (n >= 10) {
        return "$n";
      } else {
        return "0$n";
      }
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    int inHours = duration.inHours;
    if (inHours > 0) {
      return "$inHours:$twoDigitMinutes:$twoDigitSeconds";
    } else {
      return "$twoDigitMinutes:$twoDigitSeconds";
    }
  }

  /// 播放器进度滑动结束后计算具体的播放位置
  static Duration computeSeekRelativePosition(
      BuildContext context, Duration duration, Offset globalPosition) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset tapPos = box.globalToLocal(globalPosition);
    final double relative = tapPos.dx / box.size.width;
    final Duration position = duration * relative;

    return position;
  }
}
