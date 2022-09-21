import 'package:tx_super_player/cniao5_super_player.dart';

typedef VideoCallback<T> = void Function(T t);

/// 自定义播放参数
class VideoPlayOptions {
  VideoPlayOptions({
    this.title,
    this.shoTopBar = true,
    this.aspectRatio = 16 / 9,
    this.startPosition = const Duration(seconds: 0),
    this.loop = false,
    this.seekSeconds = 15,
    this.progressGestureUnit = 1000,
    this.volumeGestureUnit = 0.01,
    this.brightnessGestureUnit = 0.01,
    this.autoplay = true,
    this.allowScrubbing = true,
    this.rates = const [1.0, 1.2, 1.5, 1.75, 2],
    this.onInit,
    this.onPlay,
    this.ontimeUpdate,
    this.onPause,
    this.onEnded,
    this.onVolume,
    this.onBrightness,
    this.onNetwork,
    this.onFullscreen,
    this.onBackClick,
  });

  ///标题
  final String? title;

  /// 是否显示播放器标题栏
  final bool shoTopBar;

  /// 开始播放节点
  final Duration? startPosition;

  /// 是否循环播放
  final bool? loop;

  /// 视频快进秒数
  final num? seekSeconds;

  /// 设置（横向）手势调节视频进度的秒数单位，默认为`1s`
  final double? progressGestureUnit;

  /// 设置（右侧垂直）手势调节视频音量的单位，必须为0～1之间（不能小于0，不能大于1），默认为`0.01`
  final double volumeGestureUnit;

  /// 设置（左侧垂直）手势调节视频亮度的单位，必须为0～1之间（不能小于0，不能大于1），默认为`0.01`
  final double brightnessGestureUnit;

  /// 是否自动播放
  final bool autoplay;

  /// 视频播放比例
  final num aspectRatio;

  /// 是否运行进度条拖拽
  final bool allowScrubbing;

  /// 倍速播放配置
  final List<double> rates;

  /// 初始化完成回调事件
  final VideoCallback<VideoPlayerController>? onInit;

  /// 播放开始回调
  final VideoCallback<VideoPlayerValue>? onPlay;

  /// 播放开始回调
  final VideoCallback<VideoPlayerValue>? ontimeUpdate;

  /// 播放暂停回调
  final VideoCallback<VideoPlayerValue>? onPause;

  /// 播放结束回调
  final VideoCallback<VideoPlayerValue>? onEnded;

  /// 播放声音大小回调
  final VideoCallback<double>? onVolume;

  /// 屏幕亮度回调
  final VideoCallback<double>? onBrightness;

  /// 网络变化回调
  final VideoCallback<String>? onNetwork;

  /// 屏幕亮度回调
  final VideoCallback<bool>? onFullscreen;
  //顶部控制栏点击返回回调
  final VideoCallback<VideoPlayerValue>? onBackClick;

  /// 进度被拖拽的回调
  // final VideoProgressDragHandle onProgressDrag;
}
