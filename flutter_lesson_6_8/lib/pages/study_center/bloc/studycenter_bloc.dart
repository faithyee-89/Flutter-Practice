import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cainiaowo/models/pagination.dart';
import 'package:cainiaowo/models/studied_course.dart';
import 'package:cainiaowo/models/study_info.dart';
import 'package:cainiaowo/api/study_center/net_studycenter.dart';
import 'package:equatable/equatable.dart';
part 'studycenter_event.dart';
part 'studycenter_state.dart';

const int StudyCenterPageSize = 20;

class StudycenterBloc extends Bloc<StudycenterEvent, StudycenterState> {
  StudycenterBloc() : super(StudycenterState()) {
    on<GetStudyInfoEvent>((event, emit) => _getStudyInfo(event, emit));

    on<GetStudiedCoursesEvent>(
        (event, emit) => _getStudiedCourses(event, emit));
    on<GetBoughtCoursesEvent>((event, emit) => _getBoughtCourses(event, emit));
  }

  _getStudyInfo(GetStudyInfoEvent event, Emitter<StudycenterState> emit) async {
    StudyInfo studyInfo = await CNWStudyCenterNetManager.memberStudyInfo();
    emit(state.copyWith(
      studyInfo: studyInfo,
    ));
  }

  _getStudiedCourses(
      GetStudiedCoursesEvent event, Emitter<StudycenterState> emit) async {
    Map params = event.params;
    // 获取 课程列表 数据
    Pagination<List<StudiedCourse>> pagination =
        await CNWStudyCenterNetManager.memberCoursesStydied(
      page: params['page'] ?? 1,
      size: params['size'] ?? StudyCenterPageSize,
    );

    List<StudiedCourse> studiedCourses = pagination.datas;

    studiedCourses.insertAll(0, state.studiedCourses ?? []);

    emit(state.copyWith(
      studiedCourses: studiedCourses,
      noMoreForStudied: (pagination.page) >= (pagination.totalPage),
    ));
  }

  _getBoughtCourses(
      GetBoughtCoursesEvent event, Emitter<StudycenterState> emit) async {
    Map params = event.params;
    // 获取 课程列表 数据
    Pagination<List<StudiedCourse>> pagination =
        await CNWStudyCenterNetManager.memberCoursesBought(
      page: params['page'] ?? 1,
      size: params['size'] ?? StudyCenterPageSize,
    );
    List<StudiedCourse> boughtCourses = pagination.datas;

    boughtCourses.insertAll(0, state.boughtCourses ?? []);

    emit(state.copyWith(
      boughtCourses: boughtCourses,
      noMoreForBought: (pagination.page) >= (pagination.totalPage),
    ));
  }
}
