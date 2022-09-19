import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cainiaowo/business/course/models/course_category.dart';
import 'package:cainiaowo/network/course/net_course.dart';
import 'package:equatable/equatable.dart';

part 'courselist_event.dart';
part 'courselist_state.dart';

class CourseListBloc extends Bloc<CourseListEvent, CourseListState> {
  CourseListBloc() : super(CourseListState());

  @override
  Stream<CourseListState> mapEventToState(
    CourseListEvent event,
  ) async* {
    if (event is CourseListEventLoadData) {
      yield* _mapLoadDataToState(event, state);
    } else if (event is CourseListEventSelectedTabIndexChanged) {
      yield _mapSelectedTabIndexToState(event, state);
    } else if (event is CourseListEventFilterSelectedIndexChanged) {
      yield _mapFliterSelectedIndexsToState(event, state);
    }
  }

  Stream<CourseListState> _mapLoadDataToState(
    CourseListEvent event,
    CourseListState state,
  ) async* {
    // 请求课程分类的数据
    List list = await CNWCourseNetManager.courseCategory();

    List<CourseCategory> categories = [];

    categories.add(CourseCategory(code: 'all', id: -1, title: '全部'));
    categories.addAll(List<Map>.from(list)
        .map((dynamic e) => CourseCategory.fromJson(e))
        .toList());

    yield state.copyWith(tabs: categories);
  }

  CourseListState _mapSelectedTabIndexToState(
    CourseListEvent event,
    CourseListState state,
  ) {
    return state.copyWith(
        selectedTabIndex:
            (event as CourseListEventSelectedTabIndexChanged).selectedTabIndex);
  }

  CourseListState _mapFliterSelectedIndexsToState(
    CourseListEvent event,
    CourseListState state,
  ) {
    List<int> indexs = List.from(state.filterSelectedIndexs);
    indexs[(event as CourseListEventFilterSelectedIndexChanged).index] =
        (event as CourseListEventFilterSelectedIndexChanged).value;
    return state.copyWith(filterSelectedIndexs: indexs);
  }
}
