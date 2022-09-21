import 'package:cainiaowo/models/pagination.dart';
import 'package:cainiaowo/models/studied_course.dart';
import 'package:cainiaowo/models/study_info.dart';
import 'package:cainiaowo/libs/http/http_manager.dart';
import 'package:cainiaowo/api/study_center/net_studycenter_path.dart';

class CNWStudyCenterNetManager {
  // 用户学习详情
  static Future<StudyInfo> memberStudyInfo() {
    return HttpManager.get(net_studycenter_path_info).then((value) {
      return StudyInfo.fromJson(value);
    });
  }

  // 学习过的课程列表
  static Future<Pagination<List<StudiedCourse>>> memberCoursesStydied({
    int page = 1,
    int size = 20,
  }) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['page'] = page;
    queryParameters['size'] = size;

    return HttpManager.get(net_studycenter_path_coursestudied,
            params: queryParameters)
        .then((response) {
      Pagination<List<StudiedCourse>> pagination =
          Pagination.fromJson(response, (json) {
        return List<Map>.from(json)
            .map((dynamic e) => StudiedCourse.fromJson(e))
            .toList();
      });
      return pagination;
    });
  }

  // 学习过的课程列表
  static Future<Pagination<List<StudiedCourse>>> memberCoursesBought({
    int page = 1,
    int size = 20,
  }) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['page'] = page;
    queryParameters['size'] = size;

    return HttpManager.get(net_studycenter_path_coursesbought,
            params: queryParameters)
        .then((response) {
      Pagination<List<StudiedCourse>> pagination =
          Pagination.fromJson(response, (json) {
        return List<Map>.from(json)
            .map((dynamic e) => StudiedCourse.fromJson(e))
            .toList();
      });
      return pagination;
    });
  }
}
