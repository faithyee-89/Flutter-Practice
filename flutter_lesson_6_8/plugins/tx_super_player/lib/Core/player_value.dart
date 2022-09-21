part of cniao5_super_player;

/// The duration, current position, buffering state, error state and settings
/// of a [VideoPlayerController].
class VideoPlayerValue {
  /// Constructs a video with the given values. Only [duration] is required. The
  /// rest will initialize with default values when unset.
  VideoPlayerValue(
      {required this.duration,
      this.size = Size.zero,
      this.position = Duration.zero,
      this.playableDuration = Duration.zero,
      // this.caption = Caption.none,
      // this.buffered = const <DurationRange>[],
      this.isInitialized = false,
      this.videoInitialized = false,
      this.disposed = false,
      this.isPlaying = false,
      this.isLooping = false,
      this.isBuffering = false,
      this.volume = 1.0,
      this.playbackSpeed = 1.0,
      this.errorDescription,
      this.currentVideoQuality,
      this.videoQualitys,
      this.isMetu = false,
      this.isFullScreen = false,
      this.videoName,
      this.netStatus});

  /// Returns an instance for a video that hasn't been loaded.
  VideoPlayerValue.uninitialized()
      : this(duration: Duration.zero, isInitialized: false);

  /// Returns an instance with the given [errorDescription].
  VideoPlayerValue.erroneous(String errorDescription)
      : this(
            duration: Duration.zero,
            isInitialized: false,
            errorDescription: errorDescription);

  /// The total duration of the video.
  ///
  /// The duration is [Duration.zero] if the video hasn't been initialized.
  final Duration duration;

  /// The current playback position.
  final Duration position;

  /// 视频已经加载（缓存）的进度
  final Duration playableDuration;

  /// The [Caption] that should be displayed based on the current [position].
  ///
  /// This field will never be null. If there is no caption for the current
  /// [position], this will be a [Caption.none] object.
  // final Caption caption;

  // /// The currently buffered ranges.
  // final List<DurationRange> buffered;

  /// True if the video is playing. False if it's paused.
  final bool isPlaying;

  /// True if the video is looping.
  final bool isLooping;

  /// True if the video is currently buffering.
  final bool isBuffering;

  /// The current volume of the playback.
  final double volume;

  /// The current speed of the playback.
  final double playbackSpeed;

  /// A description of the error if present.
  ///
  /// If [hasError] is false this is `null`.
  final String? errorDescription;

  /// The [size] of the currently loaded video.
  final Size size;

  final bool isInitialized;

  final bool disposed;

  ///视频是否已经初始化完成
  final bool videoInitialized;

  /// Indicates whether or not the video is in an error state. If this is true
  /// [errorDescription] should have information about the problem.
  bool get hasError => errorDescription != null;

  /// Returns [size.width] / [size.height].
  ///
  /// Will return `1.0` if:
  /// * [isInitialized] is `false`
  /// * [size.width], or [size.height] is equal to `0.0`
  /// * aspect ratio would be less than or equal to `0.0`
  double get aspectRatio {
    if (!isInitialized || size.width == 0 || size.height == 0) {
      return 1.0;
    }
    final double aspectRatio = size.width / size.height;
    if (aspectRatio <= 0) {
      return 1.0;
    }
    return aspectRatio;
  }

  /// 视频清晰度（分辨率）列表
  final List<VideoQuality>? videoQualitys;

  /// 当前清晰度
  final VideoQuality? currentVideoQuality;

  /// 是否静音
  final bool isMetu;

  /// 是否全屏
  final bool isFullScreen;

  final String? videoName;

  /// 网络状态，每秒更新一次
  final NetStatus? netStatus;

  VideoPlayerValue copyWith(
      {Duration? duration,
      Size? size,
      Duration? position,
      Duration? playableDuration,
      // Caption? caption,
      // List<DurationRange>? buffered,
      bool? isInitialized,
      bool? videoInitialized,
      bool? disposed,
      bool? isPlaying,
      bool? isLooping,
      bool? isBuffering,
      double? volume,
      double? playbackSpeed,
      String? errorDescription,
      VideoQuality? currentVideoQuality,
      List<VideoQuality>? videoQualitys,
      bool? isMetu,
      bool? isFullScreen,
      String? videoName,
      NetStatus? netStatus}) {
    return VideoPlayerValue(
        duration: duration ?? this.duration,
        size: size ?? this.size,
        position: position ?? this.position,
        playableDuration: playableDuration ?? this.playableDuration,
        // caption: caption ?? this.caption,
        // buffered: buffered ?? this.buffered,
        isInitialized: isInitialized ?? this.isInitialized,
        videoInitialized: videoInitialized ?? this.videoInitialized,
        disposed: disposed ?? this.disposed,
        isPlaying: isPlaying ?? this.isPlaying,
        isLooping: isLooping ?? this.isLooping,
        isBuffering: isBuffering ?? this.isBuffering,
        volume: volume ?? this.volume,
        playbackSpeed: playbackSpeed ?? this.playbackSpeed,
        errorDescription: errorDescription ?? this.errorDescription,
        videoQualitys: videoQualitys ?? this.videoQualitys,
        currentVideoQuality: currentVideoQuality ?? this.currentVideoQuality,
        isFullScreen: isFullScreen ?? this.isFullScreen,
        isMetu: isMetu ?? this.isMetu,
        videoName: videoName ?? this.videoName,
        netStatus: netStatus ?? this.netStatus);
  }

  @override
  String toString() {
    return '$runtimeType('
        'duration: $duration, '
        'size: $size, '
        'position: $position, '
        // 'caption: $caption, '
        // 'buffered: [${buffered.join(', ')}], '
        'isInitialized: $isInitialized, '
        'isPlaying: $isPlaying, '
        'isLooping: $isLooping, '
        'isBuffering: $isBuffering, '
        'volume: $volume, '
        'playbackSpeed: $playbackSpeed, '
        'errorDescription: $errorDescription)';
  }
}
