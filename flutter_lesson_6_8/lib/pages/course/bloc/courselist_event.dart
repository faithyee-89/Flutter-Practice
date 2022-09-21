part of 'courselist_bloc.dart';

abstract class CourseListEvent extends Equatable {
  const CourseListEvent();

  @override
  List<Object> get props => [];
}

class GetCategoriesEvent extends CourseListEvent {
  const GetCategoriesEvent();
}

class SelectedTabIndexChangedEvent extends CourseListEvent {
  const SelectedTabIndexChangedEvent(this.selectedTabIndex);

  final int selectedTabIndex;
}

class FilterSelectedIndexChangedEvent extends CourseListEvent {
  const FilterSelectedIndexChangedEvent(this.index, this.value);

  final int index;
  final int value;
}
