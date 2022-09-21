part of 'course_bloc.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object> get props => [];
}

class GetDataEvent extends CourseEvent {
  const GetDataEvent({required this.params});
  final Map params;
}
