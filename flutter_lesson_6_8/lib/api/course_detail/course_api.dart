import 'package:cainiaowo/libs/http/http_manager.dart';
import 'package:cainiaowo/models/category.dart';
import 'package:cainiaowo/models/chapter.dart';
import 'package:cainiaowo/models/comment.dart';
import 'package:cainiaowo/models/course.dart';
import 'package:cainiaowo/models/course_authority.dart';
import 'package:cainiaowo/models/last_play_lesson_info.dart';
import 'package:cainiaowo/models/pagination.dart';
import 'package:cainiaowo/api/course_detail/course_api_path.dart';

class CourseApi {
  /// 课程详情
  static Future<Course> courseDetail({
    required int courseId,
  }) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['course_id'] = courseId;

    return HttpManager.get(net_coursedetail_path_detail,
            params: queryParameters)
        .then((json) => Course.fromJson(json));
  }

  static Future<CourseAuthority> getCourseAuthority({
    required int courseId,
  }) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['course_id'] = courseId;

    return HttpManager.get("/course/authority", params: queryParameters)
        .then((json) => CourseAuthority.fromJson(json));
  }

  // 课程章节目录
  static Future<List<Chapter>> courseLessons({
    required int courseId,
  }) {
    Map<String, dynamic> queryParameters = {};
    queryParameters['course_id'] = courseId;

    return HttpManager.get(
      net_coursedetail_path_lessions,
      params: queryParameters,
    ).then((response) {
      return List<Map>.from(response)
          .map((dynamic e) => Chapter.fromJson(e))
          .toList();
    });
  }

  // 课程评论列表
  static Future<Pagination<List<Comment>>> commentList({
    required int courseId,
    int page = 1,
    int size = 20,
  }) {
    Map<String, dynamic> queryParameters = {
      "course_id": courseId,
      "page": page,
      "size": size
    };

    return HttpManager.get(
      net_coursedetail_path_comments,
      params: queryParameters,
    ).then((response) => Pagination.fromJson(
        response,
        (json) => List<Map>.from(json)
            .map((dynamic e) => Comment.fromJson(e))
            .toList()));
  }

  // 课程分类
  static Future<List<Category>> courseCategory() {
    return HttpManager.get(net_course_path_category).then((response) =>
        List<Map>.from(response)
            .map((dynamic e) => Category.fromJson(e))
            .toList());
  }

  // 课程列表接口实现
  static Future<Pagination<List<Course>>> courseList({
    int? courseType = -1,
    String? code = 'all',
    int? difficulty = -1,
    int? isFree = -1,
    int? q = -1,
    int page = 1,
    int size = 20,
  }) {
    Map<String, dynamic> params = {};
    if (courseType != null) params['course_type'] = courseType;
    if (code != null) params['code'] = code;
    if (difficulty != null) params['difficulty'] = difficulty;
    if (isFree != null) params['is_free'] = isFree;
    if (q != null) params['q'] = q;
    params['page'] = page;
    params['size'] = size;

    return HttpManager.get(net_course_path_courselist, params: params)
        .then((response) {
      return Pagination<List<Course>>.fromJson(response, (json) {
        return List<Map>.from(json)
            .map((dynamic e) => Course.fromJson(e))
            .toList();
      });
    });
  }

  static Future<LastPlayLessonInfo> getCourseLastPlayInfo({
    required int courseId,
  }) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['course_id'] = courseId;

    return HttpManager.get(net_course_last_playinfo, params: queryParameters)
        .then((json) => LastPlayLessonInfo.fromJson(json));
  }
}
