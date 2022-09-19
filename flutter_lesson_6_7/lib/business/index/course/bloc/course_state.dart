part of 'course_bloc.dart';

class CourseState extends Equatable {
  const CourseState({
    this.courses = const [],
    this.noMore = false,
  }) : super();

  final List<Course> courses;
  final bool noMore;

  CourseState copyWith({
    List<Course> courses,
    bool noMore,
  }) {
    return CourseState(
      courses: courses ?? this.courses,
      noMore: noMore ?? this.noMore,
    );
  }

  @override
  List<Object> get props => [courses, noMore];
}
