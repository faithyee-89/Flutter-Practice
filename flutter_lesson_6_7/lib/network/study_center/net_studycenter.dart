import 'package:cainiaowo/network/common/net_manager.dart';
import 'package:cainiaowo/network/study_center/net_studycenter_path.dart';

class CNWStudyCenterNetManager {
  // 用户学习详情
  static Future<Map> memberStudyInfo() async {
    Map map = await CNWNetManager.get<Map>(
      net_studycenter_path_info,
    );
    return map;
  }

  // 学习过的课程列表
  static Future<Map> memberCoursesStydied({
    int page = 1,
    int size = 20,
  }) async {
    Map<String, dynamic> queryParameters = {};
    if (page != null) queryParameters['page'] = page;
    if (size != null) queryParameters['size'] = size;

    Map map = await CNWNetManager.get<Map>(
      net_studycenter_path_coursestudied,
      queryParameters: queryParameters,
    );
    return map;
  }

  // 学习过的课程列表
  static Future<Map> memberCoursesBought({
    int page = 1,
    int size = 20,
  }) async {
    Map<String, dynamic> queryParameters = {};
    if (page != null) queryParameters['page'] = page;
    if (size != null) queryParameters['size'] = size;

    Map map = await CNWNetManager.get<Map>(
      net_studycenter_path_coursesbought,
      queryParameters: queryParameters,
    );
    return map;
  }
}
