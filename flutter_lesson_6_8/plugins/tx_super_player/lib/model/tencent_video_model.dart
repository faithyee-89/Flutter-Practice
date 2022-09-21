part of cniao5_super_player;

/// 腾讯云点播播放器 通过fileId 播放的参数
class TencentVideoPlayModel {
  const TencentVideoPlayModel({
    required this.appId,
    required this.fileId,
    this.psign,
  });

  final int appId;
  final String fileId;
  final String? psign;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    json["appId"] = appId;
    json["fileId"] = fileId;
    json["psign"] = psign;

    return json;
  }
}
