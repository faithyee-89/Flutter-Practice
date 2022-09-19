part of 'index_bloc.dart';

abstract class IndexEvent extends Equatable {
  const IndexEvent();

  @override
  List<Object> get props => [];
}

class IndexEventLoadData extends IndexEvent {
  const IndexEventLoadData();
}

class IndexEventSelectedIndexChanged extends IndexEvent {
  const IndexEventSelectedIndexChanged(this.selectedIndex);

  final int selectedIndex;
}

class IndexEventGeadeModuleChanged extends IndexEvent {
  const IndexEventGeadeModuleChanged(this.gradeModule);

  final Module gradeModule;
}
