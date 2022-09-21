import 'package:bloc/bloc.dart';
import 'package:cainiaowo/api/play/net_play.dart';
import 'package:cainiaowo/models/chapter.dart';
import 'package:cainiaowo/models/course.dart';
import 'package:cainiaowo/models/comment.dart';
import 'package:cainiaowo/models/course_authority.dart';
import 'package:cainiaowo/models/last_play_lesson_info.dart';
import 'package:cainiaowo/models/pagination.dart';
import 'package:cainiaowo/api/course_detail/course_api.dart';
import 'package:cainiaowo/models/video_play_info.dart';
import 'package:equatable/equatable.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(CourseState()) {
    on<GetCourseDetailEvent>((event, emit) => _getCourseDetail(event, emit));
    on<GetLessonsEvent>((event, emit) => _getLessons(event, emit));

    on<GetCommentsEvent>((event, emit) => _getComments(event, emit));

    on<GetPlayInfoEvent>((event, emit) => _getPlayInfo(event, emit));

    on<GetCourseLastPlayInfoEvent>(
        (event, emit) => _getCourseLastPlayInfo(event, emit));

    on<GetCourseAuthorityEvent>(
        (event, emit) => _getCourseAuthority(event, emit));
  }

  _getCourseDetail(
      GetCourseDetailEvent event, Emitter<CourseState> emit) async {
    Course detail = await CourseApi.courseDetail(courseId: event.courseId);

    emit(state.copyWith(courseDetail: detail));
  }

  _getCourseAuthority(
      GetCourseAuthorityEvent event, Emitter<CourseState> emit) async {
    CourseAuthority authority =
        await CourseApi.getCourseAuthority(courseId: event.courseId);

    emit(state.copyWith(courseAuthority: authority));
  }

  _getLessons(GetLessonsEvent event, Emitter<CourseState> emit) async {
    // 请求课程章节列表
    List<Chapter> lessons =
        await CourseApi.courseLessons(courseId: event.courseId);
    emit(state.copyWith(lessons: lessons));
  }

  _getComments(GetCommentsEvent event, Emitter<CourseState> emit) async {
    // 请求课程评论列表
    Pagination<List<Comment>> pagination =
        await CourseApi.commentList(courseId: event.courseId);
    List<Comment> comments = pagination.datas;
    emit(state.copyWith(comments: comments));
  }

  _getPlayInfo(GetPlayInfoEvent event, Emitter<CourseState> emit) async {
    VideoPlayInfo playInfo =
        await CNWPlayNetManager.lessonUrls(event.lessonKey);

    emit(state.copyWith(playInfo: playInfo));
  }

  _getCourseLastPlayInfo(
      GetCourseLastPlayInfoEvent event, Emitter<CourseState> emit) async {
    LastPlayLessonInfo playInfo =
        await CourseApi.getCourseLastPlayInfo(courseId: event.courseId);

    emit(state.copyWith(lastPlayInfo: playInfo));
  }
}
