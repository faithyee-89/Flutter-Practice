import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_lesson_6_6/business/index/models/adbanner.dart';
import 'package:flutter_lesson_6_6/business/index/models/course.dart';
import 'package:flutter_lesson_6_6/business/index/models/grade.dart';
import 'package:flutter_lesson_6_6/business/index/models/lecturer.dart';
import 'package:flutter_lesson_6_6/business/index/models/module.dart';
import 'package:flutter_lesson_6_6/network/common/net_manager.dart';
import 'package:flutter_lesson_6_6/network/index/net_index.dart';
import 'package:equatable/equatable.dart';

part 'recommend_event.dart';
part 'recommend_state.dart';

enum RecommendType {
  none,
  lecturer, // 老师
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
  RecommendBloc() : super(RecommendState());

  @override
  Stream<RecommendState> mapEventToState(
    RecommendEvent event,
  ) async* {
    if (event is RecommendEventLoadData) {
      yield* _mapLoadDataToState(event, state);
    }
  }

  Stream<RecommendState> _mapLoadDataToState(
    RecommendEvent event,
    RecommendState state,
  ) async* {
    // 获取 banner 数据
    List list = await CNWIndexNetManager.bannerList();
    List<AdBanner> banners =
        List<Map<String, dynamic>>.from(list).map((e) => AdBanner.fromJson(e)).toList();

    // 获取 modules 列表数据
    list = await CNWIndexNetManager.moduleList();
    List<Module> modules =
        List<Map<String, dynamic>>.from(list).map((e) => Module.fromJson(e)).toList();

    List<Module> newModules = [];

    // 获取具体的 module 的数据 （component）
    await Future.forEach(modules, (Module module) async {
      // 执行具体的请求
      List data =
          await CNWIndexNetManager.componentList(module.id!, module.type!);
      switch (RecommendType.values[module.type!]) {
        case RecommendType.lecturer:
          {
            newModules.add(module.copyWith(
              components: data.map((e) => Lecturer.fromJson(e)).toList(),
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

    yield state.copyWith(
      banners: banners,
      modules: newModules,
    );
  }
}
