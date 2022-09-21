part of 'courselist_bloc.dart';

class CourseListState extends Equatable {
  const CourseListState({
    this.tabs,
    this.selectedTabIndex = 0,
    this.filterSelectedIndexs = const [0, 0, 0, 0],
  });

  final List<Category>? tabs;
  final int selectedTabIndex;
  final List<int> filterSelectedIndexs;

  CourseListState copyWith({
    List<Category>? tabs,
    int? selectedTabIndex,
    List<int>? filterSelectedIndexs,
  }) {
    return CourseListState(
      tabs: tabs ?? this.tabs,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      filterSelectedIndexs: filterSelectedIndexs ?? this.filterSelectedIndexs,
    );
  }

  @override
  List<Object> get props => [
        tabs ?? "",
        selectedTabIndex,
        filterSelectedIndexs,
      ];
}
