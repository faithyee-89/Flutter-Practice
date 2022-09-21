part of cniao5_super_player;

class NetStatus {
  ///连接的服务器 IP
  String? serverIp;

  /// 当前瞬时 CPU 使用率
  String? cpuUsage;

  int? audioCache;

  ///缓冲区（jitterbuffer）大小，缓冲区当前长度为0，说明离卡顿就不远了
  int? cacheSize;

  /// 视频分辨率 - 宽
  int? videoWidth;

  /// 视频分辨率 - 高
  int? videoHeight;

  /// 当前流媒体的视频帧率
  int? videoFps;

  ///当前的网络数据接收速度
  int? netSpeed;

  int? videoDps;

  NetStatus(
      {this.audioCache,
      this.cacheSize,
      this.cpuUsage,
      this.netSpeed,
      this.serverIp,
      this.videoDps,
      this.videoFps,
      this.videoHeight,
      this.videoWidth});

  factory NetStatus.fromJson(Map<String, dynamic> json) {
    return NetStatus(
      audioCache: json['audioCache'] as int,
      cacheSize: json['cacheSize'] as int,
      cpuUsage: json['cpuUsage'] as String?,
      serverIp: json['serverIp'] as String?,
      netSpeed: json['netSpeed'] as int,
      videoDps: json['videoDps'] as int,
      videoFps: json['videoFps'] as int,
      videoHeight: json['videoHeight'] as int,
      videoWidth: json['videoWidth'] as int,
    );
  }
}
