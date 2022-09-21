part of 'course_bloc.dart';

class CourseState extends Equatable {
  const CourseState({
    this.chapters,
    this.courseDetail,
    this.comments,
    this.playInfo,
    this.lastPlayInfo,
    this.courseAuthority,
  });

  final List<Chapter>? chapters;
  final Course? courseDetail;
  final List<Comment>? comments;
  final VideoPlayInfo? playInfo;
  final LastPlayLessonInfo? lastPlayInfo;

  /// 是否有课程的学习权限
  final CourseAuthority? courseAuthority;

  CourseState copyWith(
      {List<Chapter>? lessons,
      Course? courseDetail,
      List<Comment>? comments,
      VideoPlayInfo? playInfo,
      LastPlayLessonInfo? lastPlayInfo,
      CourseAuthority? courseAuthority}) {
    return CourseState(
        chapters: lessons ?? this.chapters,
        courseDetail: courseDetail ?? this.courseDetail,
        comments: comments ?? this.comments,
        playInfo: playInfo ?? this.playInfo,
        lastPlayInfo: lastPlayInfo ?? this.lastPlayInfo,
        courseAuthority: courseAuthority ?? this.courseAuthority);
  }

  @override
  List<Object> get props => [
        chapters ?? "",
        courseDetail ?? "",
        comments ?? "",
        playInfo ?? "",
        courseAuthority ?? ""
      ];
}
