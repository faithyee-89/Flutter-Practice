import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cainiaowo/business/index/models/module.dart';
import 'package:equatable/equatable.dart';

part 'index_event.dart';
part 'index_state.dart';

class IndexBloc extends Bloc<IndexEvent, IndexState> {
  IndexBloc() : super(IndexState());

  @override
  Stream<IndexState> mapEventToState(
    IndexEvent event,
  ) async* {
    if (event is IndexEventLoadData) {
      yield _mapLoadDataToState(event, state);
    } else if (event is IndexEventSelectedIndexChanged) {
      yield _mapSelectedIndexChangedToState(event, state);
    } else if (event is IndexEventGeadeModuleChanged) {
      yield _mapGradeModuleToState(event, state);
    }
  }

  IndexState _mapLoadDataToState(
    IndexEvent event,
    IndexState state,
  ) {
    // 网络请求
    return state.copyWith();
  }

  IndexState _mapSelectedIndexChangedToState(
    IndexEvent event,
    IndexState state,
  ) {
    return state.copyWith(
        selectedIndex: (event as IndexEventSelectedIndexChanged).selectedIndex);
  }

  IndexState _mapGradeModuleToState(
    IndexEvent event,
    IndexState state,
  ) {
    return state.copyWith(
        gradeModule: (event as IndexEventGeadeModuleChanged).gradeModule);
  }
}
