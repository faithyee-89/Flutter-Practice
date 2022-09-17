import 'package:flutter_lesson_6_6/network/common/net_manager.dart';
import 'package:flutter_lesson_6_6/network/course/net_course_path.dart';

class CNWCourseNetManager {
  // 课程分类
  static Future<List> courseCategory() async {
    List list = await CNWNetManager.get<List>(
      net_course_path_category,
    );
    return list;
  }

  // 课程列表接口实现
  static Future<Map> courseList({
    int courseType = -1,
    String code = 'all',
    int difficulty = -1,
    int isFree = -1,
    int q = -1,
    int page = 1,
    int size = 20,
  }) async {
    Map<String, dynamic> queryParameters = {};
    if (courseType != null) queryParameters['course_type'] = courseType;
    if (code != null) queryParameters['code'] = code;
    if (difficulty != null) queryParameters['difficulty'] = difficulty;
    if (isFree != null) queryParameters['is_free'] = isFree;
    if (q != null) queryParameters['q'] = q;
    if (page != null) queryParameters['page'] = page;
    if (size != null) queryParameters['size'] = size;

    Map map = await CNWNetManager.get<Map>(
      net_course_path_courselist,
      queryParameters: queryParameters,
    );
    return map;
  }
}
