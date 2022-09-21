import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cainiaowo/models/adbanner.dart';
import 'package:cainiaowo/models/course.dart';
import 'package:cainiaowo/api/index/net_index.dart';
import 'package:cainiaowo/models/grade.dart';
import 'package:cainiaowo/models/page_module.dart';
import 'package:cainiaowo/models/teacher.dart';
import 'package:equatable/equatable.dart';
part 'recommend_event.dart';
part 'recommend_state.dart';

enum RecommendType {
  none,
  teacher, // 老师
  course, // 课程
  banner, // 轮播
  ad, // 广告
  grade, // 班级
  partner, // 合作伙伴
  contentblock, // 内容块
  icon, // 图标
  studentstory, // 学员故事
}

class RecommendBloc extends Bloc<RecommendEvent, RecommendState> {
  RecommendBloc() : super(RecommendState()) {
    // 注册event
    on<GetBannerEvent>((event, emit) async => await _getBanners(emit));

    on<GetPageModuleEvent>((event, emit) async => await _getModules(emit));
  }

  _getBanners(Emitter<RecommendState> emit) async {
    final List<AdBanner> banners = await CNWIndexNetManager.bannerList();
    emit(state.copyWith(banners: banners));
  }

  _getModules(Emitter<RecommendState> emit) async {
    // 获取 modules 列表数据
    List<PageModule> modules = await CNWIndexNetManager.moduleList();
    List<PageModule> newModules = [];
    // 获取具体的 module 的数据 （component）
    await Future.forEach(modules, (PageModule module) async {
      // 执行具体的请求
      List data =
          await CNWIndexNetManager.componentList(module.id!, module.type!);
      switch (RecommendType.values[module.type!]) {
        case RecommendType.teacher:
          {
            newModules.add(module.copyWith(
              components: data.map((e) => Teacher.fromJson(e)).toList(),
            ));
          }
          break;
        case RecommendType.course:
          {
            newModules.add(module.copyWith(
              components: data.map((e) => Course.fromJson(e)).toList(),
            ));
          }
          break;
        case RecommendType.grade:
          {
            newModules.add(module.copyWith(
              components: data.map((e) => Grade.fromJson(e)).toList(),
            ));
          }
          break;
        default:
      }
    });

    emit(state.copyWith(modules: newModules));
  }

  // Stream<RecommendState> mapEventToState(
  //   RecommendEvent event,
  // ) async* {
  //   if (event is RecommendEventLoadData) {
  //     yield* _mapLoadDataToState(event, state);
  //   }
  // }

}
