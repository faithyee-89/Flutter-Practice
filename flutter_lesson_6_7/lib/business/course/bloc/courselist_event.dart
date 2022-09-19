part of 'courselist_bloc.dart';

abstract class CourseListEvent extends Equatable {
  const CourseListEvent();

  @override
  List<Object> get props => [];
}

class CourseListEventLoadData extends CourseListEvent {
  const CourseListEventLoadData();
}

class CourseListEventSelectedTabIndexChanged extends CourseListEvent {
  const CourseListEventSelectedTabIndexChanged(this.selectedTabIndex);

  final int selectedTabIndex;
}

class CourseListEventFilterSelectedIndexChanged extends CourseListEvent {
  const CourseListEventFilterSelectedIndexChanged(this.index, this.value);

  final int index;
  final int value;
}
