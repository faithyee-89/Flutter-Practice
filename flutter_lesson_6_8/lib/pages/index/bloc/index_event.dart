part of 'index_bloc.dart';

abstract class IndexEvent extends Equatable {
  const IndexEvent();

  @override
  List<Object> get props => [];
}

class IndexEventLoadData extends IndexEvent {
  const IndexEventLoadData();
}

class SelectedIndexChangedEevnt extends IndexEvent {
  const SelectedIndexChangedEevnt(this.selectedIndex);

  final int selectedIndex;
}

class GradeModuleChangedEvent extends IndexEvent {
  const GradeModuleChangedEvent(this.gradeModule);

  final PageModule gradeModule;
}
