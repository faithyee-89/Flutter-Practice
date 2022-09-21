part of cniao5_super_player;

class VideoEventType {
  //播放器已初始化
  static const String initialized = "initialized";
  static const String destroy = "destroy";

  //开始播放
  static const String beginPlay = "begin_play";
  //暂停播放
  static const String pause = "pause";
  static const String stop = "stop";

  static const String progress = "progress";

  // 播放器进入缓冲
  static const String loading = "loading";
  // 缓冲结束
  static const String loadingEnd = "loading_end";

  static const String error = "error";

  /// 清晰度（分辨率）列表更新
  static const String videoQualityListChange = "video_quality_list_change";

  /// 网络状态
  static const String netStatus = "net_status";

  ///开始切换清晰度
  static const String switchVideoQualityStart = "switch_quality_start";

  ///清晰度切换成功
  static const String switchVideoQualityEnd = "switch_quality_end";
}
