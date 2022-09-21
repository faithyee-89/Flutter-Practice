part of 'course_bloc.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object> get props => [];
}

class GetCourseDetailEvent extends CourseEvent {
  const GetCourseDetailEvent(this.courseId);

  final int courseId;
}

class GetCourseAuthorityEvent extends CourseEvent {
  const GetCourseAuthorityEvent(this.courseId);

  final int courseId;
}

class GetLessonsEvent extends CourseEvent {
  const GetLessonsEvent(this.courseId);

  final int courseId;
}

// 课程最后一次播放记录
class GetCourseLastPlayInfoEvent extends CourseEvent {
  const GetCourseLastPlayInfoEvent(this.courseId);

  final int courseId;
}

class GetCommentsEvent extends CourseEvent {
  const GetCommentsEvent(this.courseId);

  final int courseId;
}

class GetPlayInfoEvent extends CourseEvent {
  const GetPlayInfoEvent(this.lessonKey);
  final String lessonKey;
}
