import 'package:cainiaowo/libs/http/http_manager.dart';
import 'package:cainiaowo/api/play/net_play_path.dart';
import 'package:cainiaowo/models/video_play_info.dart';

class CNWPlayNetManager {
  static Future<VideoPlayInfo> lessonUrls(String lessonKey) {
    Map<String, dynamic> queryParameters = {
      'key': lessonKey,
    };
    return HttpManager.get(
      net_play_urls,
      params: queryParameters,
    ).then((response) => VideoPlayInfo.fromJson(response));
  }
}
