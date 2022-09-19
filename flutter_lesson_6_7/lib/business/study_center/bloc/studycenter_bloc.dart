import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cainiaowo/business/study_center/models/bought_course.dart';
import 'package:cainiaowo/business/study_center/models/course.dart';
import 'package:cainiaowo/business/study_center/models/study_info.dart';
import 'package:cainiaowo/network/study_center/net_studycenter.dart';
import 'package:equatable/equatable.dart';

part 'studycenter_event.dart';
part 'studycenter_state.dart';

const int StudyCenterPageSize = 20;

class StudycenterBloc extends Bloc<StudycenterEvent, StudycenterState> {
  StudycenterBloc() : super(StudycenterState());

  @override
  Stream<StudycenterState> mapEventToState(
    StudycenterEvent event,
  ) async* {
    if (event is StudycenterEventLoadStudyInfo) {
      yield* _mapLoadStudyInfoToState(event, state);
    } else if (event is StudycenterEventLoadStudiedCourses) {
      yield* _mapLoadStudiedCoursesToState(event, state);
    } else if (event is StudycenterEventLoadBoughtCourses) {
      yield* _mapLoadBoughtCoursesToState(event, state);
    }
  }

  Stream<StudycenterState> _mapLoadStudyInfoToState(
    StudycenterEvent event,
    StudycenterState state,
  ) async* {
    
    Map data = await CNWStudyCenterNetManager.memberStudyInfo();
    StudyInfo studyInfo = StudyInfo.fromJson(data);

    yield state.copyWith(
      studyInfo: studyInfo,
    );
  }

  Stream<StudycenterState> _mapLoadStudiedCoursesToState(
    StudycenterEvent event,
    StudycenterState state,
  ) async* {
    Map params = (event as StudycenterEventLoadStudiedCourses).params ?? {};
    // 获取 课程列表 数据
    Map data = await CNWStudyCenterNetManager.memberCoursesStydied(
      page: params['page'],
      size: params['size'] ?? StudyCenterPageSize,
    );
    List<Course> studiedCourses = List<Map>.from(data['datas'])
        .map((dynamic e) => Course.fromJson(e))
        .toList();

    if (params['page'] != null && params['page'] > 1) {
      studiedCourses.insertAll(0, state.studiedCourses);
    }

    yield state.copyWith(
      studiedCourses: studiedCourses,
      noMoreForStudied: (data['page'] ?? 1) >= (data['total_page'] ?? 1),
    );
  }

  Stream<StudycenterState> _mapLoadBoughtCoursesToState(
    StudycenterEvent event,
    StudycenterState state,
  ) async* {
    Map params = (event as StudycenterEventLoadBoughtCourses).params ?? {};
    // 获取 课程列表 数据
    Map data = await CNWStudyCenterNetManager.memberCoursesBought(
      page: params['page'],
      size: params['size'] ?? StudyCenterPageSize,
    );
    List<BoughtCourse> boughtCourses = List<Map>.from(data['datas'])
        .map((dynamic e) => BoughtCourse.fromJson(e))
        .toList();

    if (params['page'] != null && params['page'] > 1) {
      boughtCourses.insertAll(0, state.boughtCourses);
    }

    yield state.copyWith(
      boughtCourses: boughtCourses,
      noMoreForBought: (data['page'] ?? 1) >= (data['total_page'] ?? 1),
    );
  }
}
