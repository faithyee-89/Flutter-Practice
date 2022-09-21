import 'package:bloc/bloc.dart';
import 'package:cainiaowo/models/page_module.dart';
import 'package:equatable/equatable.dart';

part 'index_event.dart';
part 'index_state.dart';

class IndexBloc extends Bloc<IndexEvent, IndexState> {
  IndexBloc() : super(IndexState()) {
    on<SelectedIndexChangedEevnt>(
        (event, emit) => _changeSelectedIndex(event, emit));

    on<GradeModuleChangedEvent>((event, emit) => _getGradeModule(event, emit));
  }

  _changeSelectedIndex(
      SelectedIndexChangedEevnt event, Emitter<IndexState> emit) async {
    emit(state.copyWith(selectedIndex: event.selectedIndex));
  }

  _getGradeModule(GradeModuleChangedEvent event, Emitter<IndexState> emit) {
    emit(state.copyWith(gradeModule: event.gradeModule));
  }
}
