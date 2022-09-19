import 'package:cainiaowo/business/index/bloc/index_bloc.dart';
import 'package:cainiaowo/business/index/models/module.dart';
import 'package:cainiaowo/business/index/recommend/bloc/recommend_bloc.dart';
import 'package:cainiaowo/business/index/view/course_list.dart';
import 'package:cainiaowo/business/index/view/image_banner.dart';
import 'package:cainiaowo/business/index/view/image_grid.dart';
import 'package:cainiaowo/business/index/view/lecturer_swiper.dart';
import 'package:cainiaowo/business/index/view/title.dart';
import 'package:cainiaowo/common/view/sep_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

final RecommendBloc recommendBloc = RecommendBloc();

class RecommendPage extends StatelessWidget {
  const RecommendPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    recommendBloc.add(RecommendEventLoadData());

    return BlocProvider(
      create: (context) => recommendBloc,
      child: BlocBuilder<RecommendBloc, RecommendState>(
        builder: (BuildContext context, RecommendState state) {
          // 更新 grade module 数据
          state.modules.forEach((Module module) {
            if (RecommendType.values[module.type] == RecommendType.grade) {
              context
                  .read<IndexBloc>()
                  .add(IndexEventGeadeModuleChanged(module));
            }
          });

          List<Widget> slivers = [];
          slivers.addAll(_sliversFromState(state));
          slivers.add(SliverToBoxAdapter(
            child: state.modules.length > 0
                ? SepDivider(
                    text: Text('人家也是有底线的',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF999999),
                        )),
                  )
                : Container(),
          ));
          return EasyRefresh.custom(
            header: BallPulseHeader(),
            footer: null,
            slivers: slivers,
            onRefresh: () async {
              await _loadData();
            },
            onLoad: null,
          );
        },
      ),
    );
  }

  Future<void> _loadData() async {
    recommendBloc.add(RecommendEventLoadData());

    await Future.delayed(Duration(seconds: 2));
  }

  List<Widget> _sliversFromState(RecommendState state) {
    List<Widget> slivers = [];

    // 添加 banner
    slivers.add(SliverToBoxAdapter(
      child: ImageBanner(
        banners: state.banners,
      ),
    ));

    // 添加接口请求回来的各个模块
    state.modules.forEach((Module element) {
      slivers.addAll(_sliverForModule(element));
    });

    return slivers;
  }

  List<Widget> _sliverForModule(Module module) {
    Widget sliver;
    switch (RecommendType.values[module.type]) {
      case RecommendType.lecturer:
        {
          sliver = SliverToBoxAdapter(
              child: LecturerSwiper(
            lecturers: module.components,
          ));
        }
        break;
      case RecommendType.course:
        {
          sliver = CourseList(
            courses: module.components,
          );
        }
        break;
      case RecommendType.grade:
        {
          sliver = ImageGrid(
            grades: module.components,
          );
        }
        break;
      default:
    }
    return sliver != null
        ? [
            SliverToBoxAdapter(
              child: IndexTitle(title: module.title),
            ),
            sliver,
          ]
        : [];
  }
}
