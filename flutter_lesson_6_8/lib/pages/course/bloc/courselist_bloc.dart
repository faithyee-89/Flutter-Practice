import 'package:bloc/bloc.dart';
import 'package:cainiaowo/api/course_detail/course_api.dart';
import 'package:cainiaowo/models/category.dart';
import 'package:equatable/equatable.dart';

part 'courselist_event.dart';
part 'courselist_state.dart';

class CourseListBloc extends Bloc<CourseListEvent, CourseListState> {
  CourseListBloc() : super(CourseListState()) {
    on<GetCategoriesEvent>((event, emit) => _getCategories(emit));

    on<SelectedTabIndexChangedEvent>((event, emit) =>
        emit(state.copyWith(selectedTabIndex: (event).selectedTabIndex)));
    on<FilterSelectedIndexChangedEvent>((event, emit) {
      List<int> indexs = List.from(state.filterSelectedIndexs);
      indexs[event.index] = event.value;
      emit(state.copyWith(filterSelectedIndexs: indexs));
    });
  }

  _getCategories(Emitter<CourseListState> emit) async {
    // 请求课程分类的数据
    List<Category> list = await CourseApi.courseCategory();

    List<Category> categories = [];

    categories.add(Category(code: 'all', id: -1, title: '全部'));
    categories.addAll(list);

    emit(state.copyWith(tabs: categories));
  }
}
