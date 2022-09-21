part of 'lessonplay_bloc.dart';

class LessonPlayState extends Equatable {
  const LessonPlayState({
    this.lessons = const [],
    this.courseDetail,
    this.lessonUrls,
  });

  final List<Chapter> lessons;
  final Course? courseDetail;
  final VideoPlayInfo? lessonUrls;

  LessonPlayState copyWith({
    List<Chapter>? lessons,
    Course? courseDetail,
    VideoPlayInfo? lessonUrls,
  }) {
    return LessonPlayState(
      lessons: lessons ?? this.lessons,
      courseDetail: courseDetail ?? this.courseDetail,
      lessonUrls: lessonUrls ?? this.lessonUrls,
    );
  }

  @override
  List<Object> get props => [
        lessons,
        courseDetail!,
        lessonUrls!,
      ];
}
