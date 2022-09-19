part of 'course_bloc.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object> get props => [];
}

class CourseEventLoadData extends CourseEvent {
  const CourseEventLoadData({this.params});
  final Map params;
}
