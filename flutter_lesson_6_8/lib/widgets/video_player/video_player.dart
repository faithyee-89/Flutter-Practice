import 'dart:async';
import 'dart:ui';

import 'package:auto_orientation/auto_orientation.dart';
import 'package:cainiaowo/common/constant.dart';
import 'package:cainiaowo/common/values/index.dart';
import 'package:cainiaowo/widgets/video_player/common.dart';
import 'package:cainiaowo/widgets/video_player/player_util.dart';
import 'package:cainiaowo/widgets/video_player/style/video_loading_style.dart';
import 'package:cainiaowo/widgets/video_player/video_bottom_container.dart';
import 'package:cainiaowo/widgets/video_player/video_loading_view.dart';
import 'package:cainiaowo/widgets/video_player/video_play_options.dart';
import 'package:cainiaowo/widgets/video_player/video_progress_slider.dart';
import 'package:cainiaowo/widgets/video_player/video_top_bar.dart';
import 'package:cainiaowo/widgets/video_player/volume.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tx_super_player/cniao5_super_player.dart';
// import '../triangle_painter.dart';
import 'style/video_style.dart';
import 'video_progress_indicator.dart';

class VideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;
  final VideoPlayOptions options;
  final VideoStyle style;
  VideoPlayer(
      {Key? key,
      required this.controller,
      VideoPlayOptions? options,
      VideoStyle? style})
      : options = options ?? VideoPlayOptions(),
        style = style ?? VideoStyle(),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer>
    with SingleTickerProviderStateMixin {
  VideoPlayerController get _controller => widget.controller;
  VideoPlayOptions get _options => widget.options;

  ///播放器样式
  VideoStyle get _playerStyle => widget.style;

  // 倍数播放
  List<double> get rateList => _options.rates.reversed.toList();

  /// 获取屏幕大小
  Size get screenSize => MediaQuery.of(context).size;

  /// 是否显示小锁
  bool _visibleLock = false;
  bool _isLock = false; // 是否锁住
  bool _visibleStuff = false;

  /// 是否显示播放器上的控件，如果是锁住状态则不显示，非锁住状态 根据 _visibleStuff来显示
  bool get visibleWidget => _isLock ? false : _visibleStuff;

  /// 动画时间
  Duration get _animatedTime => Duration(milliseconds: 300);

  bool _isPlaying = false;
  double _currentPlaybackSpeed = 1.0;
  bool _visibleRateListPanel = false;

  /// 当前播放进度，通过监听播放器的进度来获取值
  Duration _currentPosition = Duration.zero;

  /// 播放速率
  List<VideoQuality>? _videoQualitys;
  VideoQuality? _currentVideoQuality;
  bool _visibleVideoQualityListPanel = false; // 是否显示选择清晰度的面板

  bool _isFullScreen = false;
  double _aspectRatio = 16.0 / 9.0;

  /// 是否正在缓冲
  bool _isBuffing = false;

  /// 视频是否已经初始化好了（是否是可以播放的状态）
  bool _videoInit = false;

  /// 进度滑动之和
  double durationMoveTotal = 0;
  bool _visibleDurationOverlay = false;
  Duration _durationSlide = Duration.zero;
  Duration _durationWhenStarSlide = Duration.zero;

  // /// 是否显示声音提示层
  // bool _visibleVolumeOverlay = false;
  // /// 是否显示屏幕亮度提示层
  // bool _visibleScreenBrightnessOverlay = false;
  // bool _visibleLoadingOverlay = false;

  // double? _volume;
  // double? _brightness;

  late VoidCallback _listener;

  /// 动画
  late AnimationController controlBarAnimationController;
  late Animation<double> topBarAnimation;
  late Animation<double> bottomBarAnimation;

  // 清晰度和倍数播放弹窗动画
  late Animation<double> pannelAnimation;

  Timer? autoHideControllerTime;

  _VideoPlayerState() {
    _listener = () {
      if (!mounted) {
        return;
      }

      VideoPlayerValue value = _controller.value;

      if (_videoInit != value.videoInitialized) {
        setState(() {
          _videoInit = value.videoInitialized;
        });
      }

      if (_isPlaying != value.isPlaying) {
        setState(() {
          _isPlaying = value.isPlaying;
        });
      }

      if (value.isFullScreen != _isFullScreen) {
        setState(() {
          _isFullScreen = value.isFullScreen;
        });
      }
      if (_aspectRatio != value.aspectRatio) {
        setState(() {
          _aspectRatio = value.aspectRatio;
        });
      }

      /// 在显示控件的情况下再更新某些数据
      if (_visibleStuff) {
        /// 更新播放倍数
        // if (value.playbackSpeed != _currentPlaybackSpeed) {
        //   setState(() {
        //     _currentPlaybackSpeed = value.playbackSpeed;
        //   });
        // }

        // /// 更新清晰度
        // if (value.currentVideoQuality != _currentVideoQuality) {
        //   setState(() {
        //     _currentVideoQuality = value.currentVideoQuality;
        //   });
        // }

        /// 更新清晰度列表
        if (value.videoQualitys != _videoQualitys) {
          setState(() {
            _videoQualitys = value.videoQualitys;
          });
        }

        if (value.position != this._currentPosition) {
          setState(() {
            this._currentPosition = value.position;
          });
        }
      }

      /// 在正在播放的情况下才更新某些数据
      if (value.isPlaying) {
        bool isBuffering = value.isBuffering;
        print("是否正在缓冲----- $isBuffering");
        if (_isBuffing != isBuffering) {
          setState(() {
            _isBuffing = isBuffering;
          });
        }

        // if ((_visibleStuff || _visibleLock) && !_waitVisibleStuffExecut) {
        //   _waitVisibleStuffExecut = true;

        //   Future.delayed(Duration(seconds: 3)).then((value) {
        //     _waitVisibleStuffExecut = false;

        //     setState(() {
        //       _visibleStuff = false;
        //       _visibleLock = false;
        //     });
        //   });
        // }
      }
    };
  }

  @override
  void initState() {
    print("生命周期：initState");
    super.initState();
    _controller.addListener(_listener);

    /// 控制拦动画
    controlBarAnimationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);

    topBarAnimation = Tween(
            begin: -(_playerStyle.videoTopBarStyle.height +
                _playerStyle.videoTopBarStyle.margin.vertical * 2),
            end: 0.0)
        .animate(controlBarAnimationController);

    bottomBarAnimation = Tween(
            begin:
                -(90 + _playerStyle.videoControlBarStyle.margin.vertical * 2),
            end: 0.0)
        .animate(controlBarAnimationController);

    pannelAnimation =
        Tween(begin: 0.0, end: 45.0).animate(controlBarAnimationController);
    // 保持常亮
    // Screen.keepOn(true);
  }

  @override
  void dispose() {
    print("生命周期：dispose");
    _controller.removeListener(_listener);
    // controller.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    print("生命周期：deactivate");
    _controller.removeListener(_listener);
  }

  @override
  void didUpdateWidget(VideoPlayer oldWidget) {
    print("生命周期：didUpdateWidget");
    super.didUpdateWidget(oldWidget);
    oldWidget.controller.removeListener(_listener);
    widget.controller.addListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    print("生命周期：build");
    List<Widget> widgets = [_videoPlayer()];

    widgets.add(Center(
      child: _durationOverlay(),
    ));

    // widgets.add(_widgetVisibleToggle(
    //     opacity: _visibleVolumeOverlay,
    //     child: Center(
    //       child: VolumeBar.volume(60),
    //     )));

    // widgets.add(_widgetVisibleToggle(
    //     opacity: _visibleScreenBrightnessOverlay,
    //     child: Center(
    //       child: VolumeBar.screenBrightness(20),
    //     )));

    // 头部标题
    if (_options.shoTopBar) {
      VideoTopBar topBar = VideoTopBar(
          title: _options.title ?? _controller.value.videoName,
          animation: topBarAnimation,
          videoTopBarStyle: _playerStyle.videoTopBarStyle,
          videoControlBarStyle: _playerStyle.videoControlBarStyle,
          onTap: () {
            bool isFull = _controller.value.isFullScreen;
            if (isFull) {
              // 退出全屏
              PlayerUtil.exitFullScreen(context, _controller);
            } else {
              Navigator.pop(context);
            }
          });
      widgets.add(topBar);
    }
    // 底部控制栏
    widgets.add(_buildVideoBottomBar());

    /// Loading
    if (!_videoInit) {
      widgets.add(VideoLoadingView(style: _playerStyle.videoLoadingStyle));
    }

    if (_isFullScreen) {
      widgets.add(_rateListPanel());
      widgets.add(_videoQualityListPanel());

      widgets.add(_lockIcon());
    }

    return Stack(fit: StackFit.expand, children: widgets);
  }

  Widget _videoPlayer() {
    return GestureDetector(
        //点击
        onTap: () {
          if (_isLock) {
            setState(() {
              _visibleLock = true;
            });
            return;
          }
          //显示或隐藏菜单栏和进度条
          _toggleControls();
        },
        //双击
        onDoubleTap: () {
          if (!_controller.value.videoInitialized || _isLock) return;
          _togglePlay();
        },

        /// 水平滑动 - 调节视频进度
        onHorizontalDragStart: (DragStartDetails details) {
          if (!_controller.value.videoInitialized || _isLock) return;
          if (_controller.value.isPlaying) {
            _controller.pause();
          }
          durationMoveTotal = 0;
          _durationWhenStarSlide = _controller.value.position;
          if (!_visibleStuff) {
            setState(() {
              _visibleStuff = true;
            });
          }
        },
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          if (!_videoInit || _isLock) return;
          durationMoveTotal += details.delta.dx;

          Duration duration = _computeHorizontalSlideDuration();

          setState(() {
            _durationSlide = duration;
            _visibleDurationOverlay = true;
          });
        },
        onHorizontalDragEnd: (DragEndDetails details) {
          Duration duration = _computeHorizontalSlideDuration();

          _controller.seek(duration.inSeconds);
          if (!_controller.value.isPlaying) {
            _controller.resume();
          }
          setState(() {
            _visibleDurationOverlay = false;
          });
        },

        /// 垂直滑动 - 调节亮度以及音量
        onVerticalDragStart: (DragStartDetails details) {
          if (!_controller.value.videoInitialized || _isLock) return;

          // 右侧垂直滑动 - 音量调节
          // if (details.globalPosition.dx >= (screenSize.width / 2)) {
          //   setState(() {
          //     _visibleVolumeOverlay = true;
          //   });
          // } else {
          //   setState(() {
          //     _visibleScreenBrightnessOverlay = true;
          //   });
          // }
        },
        onVerticalDragUpdate: (DragUpdateDetails details) async {
          if (!_controller.value.videoInitialized || _isLock) return;
          // 右侧垂直滑动 - 音量调节
          if (details.globalPosition.dx >= (screenSize.width / 2)) {
            // if (details.primaryDelta > 0) {
            //   //往下滑动
            //   if (controller.value.volume <= 0) return;
            //   var vol = controller.value.volume -
            //       widget.playOptions.volumeGestureUnit;
            //   if (widget.onvolume != null) {
            //     widget.onvolume(vol);
            //   }
            //   controller.setVolume(vol);
            // } else {
            //   //往上滑动
            //   if (controller.value.volume >= 1) return;
            //   var vol = controller.value.volume +
            //       widget.playOptions.volumeGestureUnit;
            //   if (widget.onvolume != null) {
            //     widget.onvolume(vol);
            //   }
            //   controller.setVolume(vol);
            // }
          }
          // 左侧垂直滑动 - 亮度调节
          else {
            // if (brightness == null) {
            //   brightness = await Screen.brightness;
            // }
            // if (details.primaryDelta > 0) {
            //   //往下滑动
            //   if (brightness <= 0) return;
            //   brightness -= widget.playOptions.brightnessGestureUnit;
            //   if (widget.onbrightness != null) {
            //     widget.onbrightness(brightness);
            //   }
            // } else {
            //   //往上滑动
            //   if (brightness >= 1) return;
            //   brightness += widget.playOptions.brightnessGestureUnit;
            //   if (widget.onbrightness != null) {
            //     widget.onbrightness(brightness);
            //   }
            // }
            // Screen.setBrightness(brightness);
          }
        },
        onVerticalDragEnd: (DragEndDetails details) {
          // setState(() {
          //   _visibleVolumeOverlay = false;
          //   _visibleScreenBrightnessOverlay = false;
          // });
        },

        ///视频播放器
        child: Hero(
          tag: "player",
          child: AspectRatio(
            aspectRatio: _aspectRatio,
            child: PlayerVideo(
              controller: _controller,
            ),
          ),
        ));
  }

  // 锁组件
  Widget _lockIcon() {
    return _widgetVisibleToggle(
        opacity: _visibleLock,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
            ),
            child: IconButton(
              iconSize: 30,
              onPressed: () {
                setState(() {
                  _isLock = !_isLock;
                  // 显示或者隐藏控件，需要一点点延时
                });
              },
              icon: _isLock ? Icon(Icons.lock) : Icon(Icons.lock_open),
              color: Colors.white,
            ),
          ),
        ));
  }

  Widget _buildVideoBottomBar() {
    late Widget widget;
    double height = _controller.value.isFullScreen ? 90 : 40;

    if (!_controller.value.isFullScreen) {
      widget = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _playButton(),
            Expanded(child: _videoProgressIndicator()),
            _fullScreenButton()
          ]);
    } else {
      List<Widget> rowChildren = [];
      rowChildren.add(_rateLabel());

      if (_videoQualitys != null) {
        rowChildren.add(_videoQualityLabel());
      }
      rowChildren.add(_fullScreenButton());

      widget = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _videoProgressIndicator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _playButton(),
              Row(
                children: rowChildren,
              )
            ],
          )
        ],
      );
    }

    return VideoBottomBarContainer(
      animation: bottomBarAnimation,
      videoControlBarStyle:
          _playerStyle.videoControlBarStyle.copyWith(height: height),
      child: widget,
    );
  }

  /// 视频时间进度条
  Widget _videoProgressIndicator() {
    final slider = VideoProgressIndicator(
      _controller,
      allowScrubbing: true,
      padding: EdgeInsets.symmetric(horizontal: 5),
      colors: VideoProgressColors(playedColor: AppColors.primaryColor),
    );

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _currentPositionTextWidget(),
          Expanded(child: slider),
          _videoDurationTextWidget()
        ]);
  }

  /// 用于显示滑动进度的提示
  Widget _durationOverlay() {
    return _widgetVisibleToggle(
      opacity: _visibleDurationOverlay,
      child: Container(
        height: 40,
        width: 100,
        padding: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Common.colorOverlayBackground,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Text(
          PlayerUtil.formatDuration(_durationSlide),
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  /// 播放/暂停切换按钮
  Widget _playButton() {
    return IconButton(
        onPressed: () {
          _togglePlay();
        },
        icon: Icon(
          _isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
          size: 30,
        ));
  }

  /// 全屏切换按钮
  Widget _fullScreenButton() {
    return IconButton(
        onPressed: () {
          PlayerUtil.toggleFullScreen(context, _controller);
        },
        icon: Icon(
          _controller.value.isFullScreen
              ? Icons.fullscreen_exit
              : Icons.fullscreen,
          color: Colors.white,
          size: 30,
        ));
  }

  /// 播放速率
  Widget _rateLabel() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _visibleRateListPanel = !_visibleRateListPanel;
        });
        controlBarAnimationController.forward();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: _textWidget(this._currentPlaybackSpeed == 1.0
            ? "正常"
            : this._currentPlaybackSpeed.toString() + "x"),
      ),
    );
  }

  /// 分辨率
  Widget _videoQualityLabel() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _visibleVideoQualityListPanel = !_visibleVideoQualityListPanel;
        });
        controlBarAnimationController.forward();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: _textWidget(this._currentVideoQuality?.title ?? "自动"),
      ),
    );
  }

  /// 倍数播放选择面板
  Widget _rateListPanel() {
    List<Widget> widgets = rateList.map((double rate) {
      return Container(
          height: 40,
          child: TextButton(
              child: Text(rate == 1.0 ? "正常" : rate.toString() + "x",
                  style: rate == _currentPlaybackSpeed
                      ? _playerStyle.labelStyleActive
                      : _playerStyle.labelStyle),
              onPressed: () {
                _changeRate(rate);
              }));
    }).toList();

    return _togglePanel(_visibleRateListPanel, widgets);
  }

  /// 清晰度选择面板
  Widget _videoQualityListPanel() {
    return _togglePanel(_visibleVideoQualityListPanel, _videoQualityItem());
  }

  /// 清晰度选择列表
  List<Widget> _videoQualityItem() {
    if (this._videoQualitys == null) return [];

    return this._videoQualitys!.map((VideoQuality quality) {
      return Container(
          height: 40,
          child: TextButton(
              child: Text(quality.title ?? "自动",
                  style: quality.index == (_currentVideoQuality?.index ?? 0)
                      ? _playerStyle.labelStyleActive
                      : _playerStyle.labelStyle),
              onPressed: () {
                _changeVideoQuality(quality);
              }));
    }).toList();
  }

  /// 当前播放进度时间
  Widget _currentPositionTextWidget() {
    /// 当前时长
    return _textWidget(PlayerUtil.formatDuration(_currentPosition));
  }

  /// 视频总时长
  Widget _videoDurationTextWidget() {
    /// 总时长
    return _textWidget(PlayerUtil.formatDuration(_controller.value.duration));
  }

  /// text控件
  Widget _textWidget(String value) {
    return Text(
      value,
      style: _playerStyle.labelStyle,
    );
  }

  Widget _togglePanel(bool visible, List<Widget> widgets) {
    return Positioned(
      right: pannelAnimation.value,
      bottom: 95,
      child: Offstage(
        offstage: !visible,
        child: Column(
          children: <Widget>[
            Container(
              width: 100,
              padding: EdgeInsets.only(bottom: 5, left: 5, right: 5),
              decoration: BoxDecoration(
                color: Common.colorOverlayBackground,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widgets,
              ),
            ),
            // Container(
            //   width: 12,
            //   height: 6,
            //   child: CustomPaint(
            //     painter: TrianglePainter(context),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  /// 页面控件显示或者隐藏
  Widget _widgetVisibleToggle(
      {required Widget child, Duration? duration, bool? opacity}) {
    if (duration == null) duration = _animatedTime;
    if (opacity == null) opacity = visibleWidget;

    return AnimatedOpacity(
      opacity: opacity ? 1 : 0,
      duration: duration,
      child: child,
    );
  }

  /// 显示或隐藏菜单栏
  void _toggleControls() {
    clearAutoHideControlbarTimer();

    if (!_visibleStuff) {
      _visibleStuff = true;
      createAutoHideControlbarTimer();
    } else {
      _visibleStuff = false;
    }
    setState(() {
      if (_visibleStuff) {
        controlBarAnimationController.forward();
      } else {
        controlBarAnimationController.reverse();
      }
    });
  }

  /// 点击播放或暂停
  void _togglePlay() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      /// 恢复播放，并隐藏控件
      _controller.resume();
    }
  }

  /// 切换播放倍数
  void _changeRate(double rate) {
    setState(() {
      this._visibleRateListPanel = false;
      // _controller.setPlaybackSpeed(rate);
      _currentPlaybackSpeed = rate;
    });
  }

  /// 切换清晰度的方法
  void _changeVideoQuality(VideoQuality quality) {
    setState(() {
      this._visibleVideoQualityListPanel = false;
      // 自适应码流通过index 来切换，这样可以无缝切换
      if (quality.index != null) {
        _controller.setVideoQuality(index: quality.index);
      } else {
        if (quality.url != null) {
          _controller.setVideoQuality(url: quality.url);
        }
      }
    });

    _currentVideoQuality = quality;
  }

  void createAutoHideControlbarTimer() {
    clearAutoHideControlbarTimer();

    ///如果是播放状态5秒后自动隐藏
    autoHideControllerTime = Timer(Duration(milliseconds: 5000), () {
      if (_controller.value.isPlaying) {
        if (_visibleStuff) {
          setState(() {
            _visibleStuff = false;
            _visibleRateListPanel = false;
            _visibleVideoQualityListPanel = false;
            controlBarAnimationController.reverse();
          });
        }
      }
    });
  }

  void clearAutoHideControlbarTimer() {
    autoHideControllerTime?.cancel();
  }

  /// 计算水平滑动的位置
  Duration _computeHorizontalSlideDuration() {
    double? layoutWidth = context.size?.width;
    // 进度条百分控制
    double valueHorizontal =
        double.parse((durationMoveTotal / layoutWidth!).toStringAsFixed(2));
    // 当前进度条百分比
    double currentValue = _durationWhenStarSlide.inMilliseconds /
        _controller.value.duration.inMilliseconds;
    double value =
        double.parse((currentValue + valueHorizontal).toStringAsFixed(2));
    if (value >= 1.00) {
      value = 1.00;
    } else if (value <= 0.00) {
      value = 0.00;
    }
    print("滑动value: $value");
    int milliseconds =
        (value * _controller.value.duration.inMilliseconds).toInt();

    Duration duration = Duration(milliseconds: milliseconds);

    print("滑动duration: $duration");

    return duration;
  }
}

class VideoFullScreenPage extends StatefulWidget {
  final VideoPlayerController controller;

  VideoFullScreenPage(this.controller);

  @override
  _VideoFullScreenPageState createState() => _VideoFullScreenPageState();
}

class _VideoFullScreenPageState extends State<VideoFullScreenPage> {
  Size get _window => MediaQueryData.fromWindow(window).size;

  @override
  void initState() {
    super.initState();
    // ///关闭状态栏，与底部虚拟操作按钮
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    AutoOrientation.landscapeAutoMode();
  }

  @override
  Widget build(BuildContext context) {
    double width = _window.width;
    double height = _window.height;
    return Container(
        width: width,
        height: height,
        color: Colors.black,
        child: VideoPlayer(
          controller: widget.controller,
        ));
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    widget.controller.setFullScreen(false);
    AutoOrientation.portraitUpMode();

    super.dispose();
  }
}
