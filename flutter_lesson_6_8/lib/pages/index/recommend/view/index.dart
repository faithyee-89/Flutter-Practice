import 'package:cainiaowo/common/constant.dart';
import 'package:cainiaowo/models/course.dart';
import 'package:cainiaowo/models/grade.dart';
import 'package:cainiaowo/models/page_module.dart';
import 'package:cainiaowo/models/teacher.dart';
import 'package:cainiaowo/pages/index/bloc/index_bloc.dart';
import 'package:cainiaowo/pages/index/recommend/bloc/recommend_bloc.dart';
import 'package:cainiaowo/pages/index/view/title.dart';
import 'package:cainiaowo/widgets/course/course_list.dart';
import 'package:cainiaowo/pages/index/widget/image_banner.dart';
import 'package:cainiaowo/pages/index/widget/image_grid.dart';
import 'package:cainiaowo/pages/index/widget/teacher_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_vant_kit/main.dart';
// import 'package:flutter_vant_kit/main.dart';

bool isSyncGradeModule = false;

class RecommendPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final RecommendBloc recommendBloc = RecommendBloc();
        // 加载Banner 图片
        recommendBloc.add(GetBannerEvent());
        // 加载页面模块
        recommendBloc.add(GetPageModuleEvent());
        return recommendBloc;
      },
      child: BlocBuilder<RecommendBloc, RecommendState>(
        builder: (BuildContext context, RecommendState state) {
          return _mainContainer(context, state);
        },
      ),
    );
  }

  Widget _mainContainer(BuildContext context, RecommendState state) {
    List<Widget> slivers = [];
    slivers.add(_bannerSliver(state));
    slivers.addAll(_modulesSliver(context, state));

    return EasyRefresh.custom(
      header: BallPulseHeader(),
      footer: null,
      slivers: slivers,
      onRefresh: () async {
        // await _loadData();
      },
      onLoad: null,
    );
  }

  Widget _bannerSliver(RecommendState state) {
    return SliverToBoxAdapter(
        child: Padding(
            padding: EdgeInsets.all(PAGE_PADDING),
            child: Skeleton(
              row: 3,
              loading: state.banners == null ? true : false,
              child: ImageBanner(banners: state.banners ?? []),
            )));
  }

  List<Widget> _modulesSliver(BuildContext context, RecommendState state) {
    List<Widget> slivers = [];

    if (state.modules != null) {
      state.modules?.forEach((PageModule element) {
        if (!isSyncGradeModule) {
          if (RecommendType.values[element.type!] == RecommendType.grade) {
            context.read<IndexBloc>().add(GradeModuleChangedEvent(element));
            isSyncGradeModule = true;
          }
        }
        slivers.addAll(_sliverForModule(element));
      });

      return slivers;
    }

    slivers.add(SliverToBoxAdapter(
        child: Padding(
      padding: EdgeInsets.all(PAGE_PADDING),
      child: Skeleton(
        row: 20,
      ),
    )));

    return slivers;
  }

  List<Widget> _sliverForModule(PageModule module) {
    late Widget sliver;
    switch (RecommendType.values[module.type!]) {
      case RecommendType.teacher:
        {
          sliver = SliverToBoxAdapter(
              child: TeacherSwiper(
            teachers: module.components as List<Teacher>,
          ));
        }
        break;
      case RecommendType.course:
        {
          sliver = CourseList(
            courses: module.components as List<Course>,
          );
        }
        break;
      case RecommendType.grade:
        {
          sliver = ImageGrid(
            grades: module.components as List<Grade>,
          );
        }
        break;
      default:
    }
    return [
      SliverToBoxAdapter(
        child: IndexTitle(title: module.title ?? ""),
      ),
      sliver,
    ];
  }
}
