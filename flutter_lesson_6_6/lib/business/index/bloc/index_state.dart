part of 'index_bloc.dart';

class IndexState extends Equatable {
  final int selectedIndex;
  final List<String> tabs;
  final Module? gradeModule;
  const IndexState({
    this.tabs = const ['推荐', '免费课程', '实战课程', '就业课'],
    this.selectedIndex = 0,
    this.gradeModule,
  });

  IndexState copyWith({
    List<String>? tabs,
    int? selectedIndex,
    Module? gradeModule,
  }) {
    return IndexState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      tabs: tabs ?? this.tabs,
      gradeModule: gradeModule ?? this.gradeModule,
    );
  }

  @override
  List<Object> get props => [
        selectedIndex,
        tabs,
        gradeModule!,
      ];
}
