import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_lesson_6_6/business/index/models/course.dart';
import 'package:flutter_lesson_6_6/network/course/net_course.dart';
import 'package:equatable/equatable.dart';

part 'course_event.dart';
part 'course_state.dart';

const int CourseListPageSize = 20;

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(CourseState());

  @override
  Stream<CourseState> mapEventToState(
    CourseEvent event,
  ) async* {
    if (event is CourseEventLoadData) {
      yield* _mapLoadDataToState(event, state);
    }
  }

  Stream<CourseState> _mapLoadDataToState(
    CourseEvent event,
    CourseState state,
  ) async* {
    Map? params = (event as CourseEventLoadData).params;
    // 获取 课程列表 数据
    Map data = await CNWCourseNetManager.courseList(
      courseType: params!['courseType'],
      code: params['code'],
      difficulty: params['difficulty'],
      isFree: params['isFree'],
      q: params['q'],
      page: params['page'],
      size: params['size'] ?? CourseListPageSize,
    );
    List<Course> courses = List<Map>.from(data['datas'])
        .map((dynamic e) => Course.fromJson(e))
        .toList();

    if (params['page'] != null && params['page'] > 1) {
      courses.insertAll(0, state.courses);
    }

    yield state.copyWith(
      courses: courses,
      noMore: (data['page'] ?? 1) >= (data['total_page'] ?? 1),
    );
  }
}
