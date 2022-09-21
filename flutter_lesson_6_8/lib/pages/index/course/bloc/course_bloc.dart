import 'package:bloc/bloc.dart';
import 'package:cainiaowo/api/course_detail/course_api.dart';
import 'package:cainiaowo/models/course.dart';
import 'package:cainiaowo/models/pagination.dart';
import 'package:equatable/equatable.dart';

part 'course_event.dart';
part 'course_state.dart';

const int pageSize = 20;

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(CourseState()) {
    on<GetDataEvent>((event, emit) => _getDatas(event, emit));
  }

  _getDatas(GetDataEvent event, Emitter<CourseState> emit) async {
    Map params = event.params;

    emit(state.copyWith(isLoading: true));

    Pagination<List<Course>> pagination = await CourseApi.courseList(
      courseType: params['courseType'],
      code: params['code'],
      difficulty: params['difficulty'],
      isFree: params['isFree'],
      q: params['q'],
      page: params['page'] ?? 1,
      size: params['size'] ?? pageSize,
    );

    List<Course> courses = pagination.datas;

    courses.insertAll(0, state.courses);
    emit(state.copyWith(
      isLoading: false,
      courses: courses,
      noMore: (pagination.page) >= (pagination.totalPage),
    ));
  }
}
