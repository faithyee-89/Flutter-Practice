part of cniao5_super_player;

enum DataSourceType { asset, network, file, tencent }

class VideoPlayerController extends ValueNotifier<VideoPlayerValue>
    implements PlayerController {
  final String channelName = "cloud.tencent.com/mysuperplayer/";
  final String channelEventName = "cloud.tencent.com/mysuperplayer/event/";
  final String channelNetName = "cloud.tencent.com/mysuperplayer/net/";

  int _playerId = -1;
  bool _isDisposed = false;

  Completer<int>? _creatingCompleter;
  Completer<int>? _createTexture;

  late MethodChannel _channel;
  late StreamSubscription _eventSubscription;
  // late StreamSubscription _netSubscription;

  final StreamController<Map<dynamic, dynamic>> _netStatusStreamController =
      StreamController.broadcast();

  Stream<Map<dynamic, dynamic>> get onPlayerNetStatusBroadcast =>
      _netStatusStreamController.stream;

  /// 播放源类型
  // final DataSourceType dataSourceType;
  // TencentVideoPlayModel? videoPlayModel;
  // String? url;

  VideoPlayerController() : super(VideoPlayerValue(duration: Duration.zero));

  // VideoPlayerController.tencent(this.videoPlayModel)
  //     : dataSourceType = DataSourceType.tencent,
  //       super(VideoPlayerValue(duration: Duration.zero));

  // VideoPlayerController.url(this.url)
  //     : dataSourceType = DataSourceType.network,
  //       super(VideoPlayerValue(duration: Duration.zero));

  /// 必须先调用该方法进行初始化
  Future<void> initialize({bool? onlyAudio}) async {
    _creatingCompleter = Completer();
    _createTexture = Completer();

    _playerId = await SuperPlayerPlugin.createSuperPlayer();
    _channel = MethodChannel("$channelName$_playerId");
    _eventSubscription = EventChannel("$channelEventName$_playerId")
        .receiveBroadcastStream("event")
        .listen(_eventHandler, onError: _errorHandler);

    // _netSubscription = EventChannel("$channelNetName$_playerId")
    //     .receiveBroadcastStream("net")
    // .listen(_netHandler, onError: _errorHandler);

    _creatingCompleter!.complete(_playerId);

    // await _creatingCompleter!.future;
    final textureId =
        await _channel.invokeMethod(PlayerControllerEvent.methodInit, {
      "onlyAudio": onlyAudio ?? false,
    });
    _createTexture!.complete(textureId);
    value = value.copyWith(isInitialized: true);
  }

  /// 接收原生端发来的事件，处理后转发到UI层
  _eventHandler(event) {
    if (event == null) return;

    String eventName = event["event"];
    switch (eventName) {
      case VideoEventType.initialized:
        value = value.copyWith(isInitialized: true);
        break;

      case VideoEventType.destroy:
        value = value.copyWith(disposed: true);
        break;

      case VideoEventType.loading:
        value = value.copyWith(isBuffering: true);
        break;

      case VideoEventType.loadingEnd:
        value = value.copyWith(isBuffering: false);
        break;

      case VideoEventType.beginPlay:
        String videoName = event["videoName"];
        value = value.copyWith(isPlaying: true, videoName: videoName);
        break;

      case VideoEventType.pause:
        value = value.copyWith(isPlaying: false);
        break;

      case VideoEventType.stop:
        value = value.copyWith(isPlaying: false);
        break;

      case VideoEventType.progress:
        value = value.copyWith(isPlaying: true);

        // 总时长
        int duration = event["duration"] as int;
        if (value.duration == Duration.zero && duration > 0) {
          value = value.copyWith(
              videoInitialized: true, duration: Duration(seconds: duration));
        } else {
          // 当前播放进度
          int current = event["current"] as int;
          int playableDuration = event["playableDuration"] as int;
          value = value.copyWith(
            position: Duration(seconds: current),
            playableDuration: Duration(seconds: playableDuration),
          );
        }
        break;
      case VideoEventType.switchVideoQualityStart:
        // bool success = event["success"];
        // String qualityJson = event["quality"];

        break;

      // 点播播放器好像不能回调该事件
      case VideoEventType.switchVideoQualityEnd:
        bool success = event["success"];
        if (success) {
          String qualityJson = event["quality"];
          Map<String, dynamic> map = jsonDecode(qualityJson);
          int? index = map["index"];
          String? url = map["url"];
          VideoQuality? currentQuality = value.videoQualitys?.firstWhere(
              (element) => (element.index == index || element.url == url));
          value = value.copyWith(currentVideoQuality: currentQuality);
        }
        break;

      case VideoEventType.videoQualityListChange:
        String? urlsJson = event["urls"];
        String? defaultQualityJson = event["default"];

        List<VideoQuality>? videoQualitys;
        VideoQuality? defaultQuality;
        if (urlsJson != null && urlsJson != "") {
          List<dynamic> urls = jsonDecode(urlsJson);

          videoQualitys =
              urls.map((json) => VideoQuality.fromJson(json)).toList();

          value = value.copyWith(videoQualitys: videoQualitys);
        }

        if (defaultQualityJson != null && defaultQualityJson != "") {
          defaultQuality =
              VideoQuality.fromJson(jsonDecode(defaultQualityJson));

          value = value.copyWith(currentVideoQuality: defaultQuality);
        }

        break;

      case VideoEventType.netStatus:
        String netStatusJson = event["netStatus"];
        NetStatus netStatus = NetStatus.fromJson(jsonDecode(netStatusJson));

        Size size = Size(netStatus.videoWidth?.toDouble() ?? 0,
            netStatus.videoHeight?.toDouble() ?? 0);
        if (value.size != Size.zero) {
          value = value.copyWith(size: size);
        }

        // _netHandler(netStatus);
        break;

      case VideoEventType.error:
        String message = event["message"];
        value = value.copyWith(errorDescription: message);

        break;
    }
  }

  /// 网络状态事件
  // _netHandler(event) {
  //   if (event == null) return;
  //   final Map<dynamic, dynamic> map = event;

  //   _netStatusStreamController.add(map);
  // }

  _errorHandler(error) {}

  /// 开始播放视频
  // startPlay() {
  //   if (this.dataSourceType == DataSourceType.network) {
  //     this.play(this.url!);
  //   }

  //   if (this.dataSourceType == DataSourceType.tencent) {
  //     this.playTencentVideo(this.videoPlayModel!);
  //   }
  // }

  Future<bool> play(String url) async {
    if (_isDisposedOrNotInitialized) {
      return false;
    }

    // 放在 invokeMethod 方法前面才有效
    value = value.copyWith(isPlaying: true);

    final result = await _channel
        .invokeMethod(PlayerControllerEvent.methodPlay, {"url": url});
    return result == 0;
  }

  Future<bool> playTencentVideo(TencentVideoPlayModel params) async {
    if (_isDisposedOrNotInitialized) {
      return false;
    }
    value = value.copyWith(isPlaying: true);
    final result = await _channel.invokeMethod(
        PlayerControllerEvent.methodPlayTencentVideo, params.toJson());
    return result == 0;
  }

  Future<void> pause() async {
    if (_isDisposedOrNotInitialized) {
      return;
    }
    value = value.copyWith(isPlaying: false);
    await _channel.invokeMethod(PlayerControllerEvent.methodPause);
  }

  Future<void> resume() async {
    if (_isDisposedOrNotInitialized) {
      return;
    }
    value = value.copyWith(isPlaying: true);

    await _channel.invokeMethod(PlayerControllerEvent.methodResume);
  }

  Future<bool> stop() async {
    if (_isDisposedOrNotInitialized) {
      return false;
    }
    value = value.copyWith(
        isPlaying: false,
        videoInitialized: false,
        isInitialized: false,
        duration: Duration.zero,
        position: Duration.zero,
        playableDuration: Duration.zero);

    final result =
        await _channel.invokeMethod(PlayerControllerEvent.methodStop);

    return result == 0;
  }

  /// 跳转到指定播放位置
  Future<void> seek(int position) async {
    if (_isDisposedOrNotInitialized) {
      return;
    }
    value = value.copyWith(position: Duration(seconds: position));

    await _channel
        .invokeMethod(PlayerControllerEvent.methodSeek, {"position": position});
  }

  /// 设置播放速率
  Future<void> setPlaybackSpeed(double speed) async {
    if (_isDisposedOrNotInitialized) {
      return;
    }
    value = value.copyWith(playbackSpeed: speed);
    await _channel
        .invokeMethod(PlayerControllerEvent.methodSetRate, {"rate": speed});
  }

  /// 静音切换
  Future<void> setMute(bool mute) async {
    if (_isDisposedOrNotInitialized) {
      return;
    }
    value = value.copyWith(isMetu: mute, volume: 0);
    await _channel
        .invokeMethod(PlayerControllerEvent.methodSetMute, {"isMute": mute});
  }

  /// 设置声音大小，0-100
  Future<void> setVolume(int volume) async {
    if (_isDisposedOrNotInitialized) {
      return;
    }
    value = value.copyWith(
        volume: volume.toDouble(), isMetu: volume <= 0 ? true : false);
    await _channel.invokeMethod(
        PlayerControllerEvent.methodSetVolume, {"volume": volume});
  }

  /// 切换清晰度，index 和 url 同时只能传一个
  Future<void> setVideoQuality({int? index, String? url}) async {
    if (_isDisposedOrNotInitialized) {
      return;
    }
    VideoQuality? quality = value.videoQualitys?.firstWhere(
        (element) => (element.index == index || element.url == url));

    if (quality != null) {
      value = value.copyWith(currentVideoQuality: quality);
    }
    await _channel.invokeMethod(PlayerControllerEvent.methodSwitchVideoQuality,
        {"index": index, "url": url});
  }

  /// 设计镜像
  Future<void> setMirror(bool isMirror) async {
    if (_isDisposedOrNotInitialized) {
      return;
    }
    await _channel.invokeMethod(
        PlayerControllerEvent.methodSetMirror, {"isMirror": isMirror});
  }

  /// 全屏切换
  Future<void> setFullScreen(bool isFullScreen) async {
    value = value.copyWith(isFullScreen: isFullScreen);
  }

  Future<bool> isPlaying() async {
    if (_isDisposedOrNotInitialized) {
      return false;
    }
    bool isPlaying =
        await _channel.invokeMethod(PlayerControllerEvent.methodIsPlaying);
    value = value.copyWith(isPlaying: isPlaying);
    return isPlaying;
  }

  // Future<void> setLooping(bool looping) async {
  //   await _initPlayer.future;
  //   await _channel.invokeMethod("setLoop", {"loop": looping});
  //   value = value.copyWith(isLooping: looping);
  // }

  // Future<void> setRenderRotation(int rotation) async {
  //   await _initPlayer.future;
  //   await _channel.invokeMethod("setRenderRotation", {"rotation": rotation});
  // }

  // Future<void> setIsAutoPlay({bool? isAutoPlay}) async {
  //   await _initPlayer.future;
  //   await _channel
  //       .invokeMethod("setIsAutoPlay", {"isAutoPlay": isAutoPlay ?? false});
  // }

  // /// 获取播放时长,单位秒
  // Future<double> getDuration() async {
  //   await _initPlayer.future;
  //   double duration = await _channel.invokeMethod("getDuration");

  //   value = value.copyWith(duration: Duration(seconds: duration.toInt()));
  //   return duration;
  // }

  // /// 获取当前播放位置,单位秒
  // Future<double> getCurrentTime() async {
  //   await _initPlayer.future;
  //   double curr = await _channel.invokeMethod("getCurrentTime");
  //   value = value.copyWith(position: Duration(seconds: curr.toInt()));
  //   return curr;
  // }

  Future<void> _release() async {
    if (_isDisposedOrNotInitialized) {
      return;
    }
    await SuperPlayerPlugin.releasePlayer(_playerId);
    value = value.copyWith(disposed: true);
  }

  @override
  void dispose() async {
    if (_creatingCompleter != null) {
      if (!_isDisposed) {
        await _eventSubscription.cancel();
        await _release();
        _netStatusStreamController.close();
        value = value.copyWith(disposed: true);
      }
    }
    _isDisposed = true;
    super.dispose();
  }

  Future<int> get textureId async {
    return _createTexture!.future;
  }

  @override
  void removeListener(VoidCallback listener) {
    if (!_isDisposed) {
      super.removeListener(listener);
    }
  }

  bool get _isDisposedOrNotInitialized => _isDisposed || !value.isInitialized;
}

// enum PlayerState {
//   paused, // 暂停播放
//   failed, // 播放失败
//   buffering, // 缓冲中
//   playing, // 播放中
//   stopped, // 停止播放
//   disposed // 控件释放了
// }

