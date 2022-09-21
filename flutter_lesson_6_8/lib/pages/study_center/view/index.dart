import 'package:cached_network_image/cached_network_image.dart';
import 'package:cainiaowo/common/authentication/authentication.dart';
import 'package:cainiaowo/utils/utils_string.dart';
import 'package:cainiaowo/pages/study_center/bloc/studycenter_bloc.dart';
import 'package:cainiaowo/widgets/course/study_course_item.dart';
import 'package:cainiaowo/pages/study_center/view/study_courselist.dart';
import 'package:cainiaowo/common/constant.dart';
import 'package:cainiaowo/common/values/index.dart';
import 'package:cainiaowo/common/view/loginhint_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vant_kit/main.dart';

StudycenterBloc studyCenterBloc = StudycenterBloc();

// ignore: must_be_immutable
class StudyCenterPage extends StatefulWidget {
  StudyCenterPage({Key? key}) : super(key: key);
  bool isLoadData = false;
  @override
  _StudyCenterPageState createState() => _StudyCenterPageState();
}

class _StudyCenterPageState extends State<StudyCenterPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    this.tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            if (widget.isLoadData == false) {
              studyCenterBloc.add(GetStudyInfoEvent());
              studyCenterBloc.add(GetStudiedCoursesEvent(params: {}));
              studyCenterBloc.add(GetBoughtCoursesEvent(params: {}));
              widget.isLoadData = true;
            }
            return BlocProvider(
              create: (_) => studyCenterBloc,
              child: _studyCenterPage(),
            );
          }
          return LoginHintPage();
        },
      ),
    );
  }

  Widget _studyCenterPage() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),

            ///SliverAppBar也可以实现吸附在顶部的TabBar，但是高度不好计算，总是会有AppBar的空白高度，
            ///所以我就用了SliverPersistentHeader来实现这个效果，SliverAppBar的bottom中只放TabBar顶部的布局
            sliver: SliverAppBar(
              backgroundColor: Colors.transparent,
              forceElevated: innerBoxIsScrolled,
              bottom: PreferredSize(
                  child: Container(), preferredSize: Size.fromHeight(380.h)),

              ///TabBar顶部收缩的部分
              flexibleSpace: Column(
                children: <Widget>[
                  _header(),
                ],
              ),
            ),
          ),

          ///停留在顶部的TabBar
          _tabBar(),
        ];
      },
      body: Container(
        color: Colors.white,
        child: _tabViews(),
      ),
    );
  }

  Widget _header() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) {
        return current.status == AuthenticationStatus.authenticated;
      },
      builder: (context, state) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: ClipOval(
                      child: Container(
                        color: AppColors.greyLight,
                        child: Container(
                          width: 60,
                          height: 60,
                          child: CachedNetworkImage(
                              imageUrl: UtilsString.fixedHttpStart(
                                  state.user?.logoUrl ?? defualtHeadImg)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Text(
                          state.user == null
                              ? "未登录"
                              : state.user?.username ?? "无名",
                          style: TextStyle(
                            fontSize: AppFontSize.mediumSp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          )))
                ],
              ),
              _studyInfoView(),
            ],
          ),
        );
      },
    );
  }

  Widget _studyInfoView() {
    return BlocBuilder<StudycenterBloc, StudycenterState>(
        builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
        child: Skeleton(
          loading: state.studyInfo == null,
          row: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _studyInfoItem(
                  _durationFormat(state.studyInfo?.todayStudyTime ?? 0),
                  '小时',
                  '今日学习'),
              _studyInfoItem(
                  _durationFormat(state.studyInfo?.totalStudyTime ?? 0),
                  '小时',
                  '总共学习'),
              _studyInfoItem(
                  state.studyInfo?.rank == 0
                      ? '千里之外'
                      : state.studyInfo?.rank.toString() ?? "",
                  '',
                  '学习排名')
            ],
          ),
        ),
      );
    });
  }

  Widget _studyInfoItem(String value, String valueSuffix, String label) {
    TextStyle valueTextStyle = TextStyle(
      fontSize: AppFontSize.mediumSp,
      color: AppColors.black,
    );

    TextStyle valueSuffixTextStyle = TextStyle(
      fontSize: AppFontSize.extraSmallSp,
      color: AppColors.placeholdeTextColor,
    );

    TextStyle labelTextStyle = TextStyle(
      fontSize: AppFontSize.smallSp,
      color: AppColors.secondaryTextColor,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              value,
              style: valueTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 3,
                top: 3,
              ),
              child: Text(
                valueSuffix,
                style: valueSuffixTextStyle,
              ),
            )
          ],
        ),
        Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(label, style: labelTextStyle))
      ],
    );
  }

  Widget _tabBar() {
    TextStyle textStyle = TextStyle(
        fontSize: AppFontSize.mediumSp,
        color: AppColors.black,
        fontWeight: FontWeight.w500);
    return SliverPersistentHeader(
      pinned: true,
      delegate: StickyTabBarDelegate(
        child: Container(
          color: Colors.white,
          child: TabBar(
            controller: this.tabController,
            tabs: <Widget>[
              Tab(
                child: Container(
                  color: Colors.white,
                  child: Text('最近学习', //state.user.username ??
                      style: textStyle),
                ),
              ),
              Tab(
                child: Container(
                  color: Colors.white,
                  child: Text('我的课程', //state.user.username ??
                      style: textStyle),
                ),
              ),
            ],
            // isScrollable: true,
            unselectedLabelColor: Color(0xFF999999),
            labelColor: AppColors.primaryColor,
            indicatorColor: AppColors.primaryColor,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.label,
          ),
        ),
      ),
    );
  }

  Widget _tabViews() {
    return TabBarView(
      controller: this.tabController,
      children: <Widget>[
        BlocBuilder<StudycenterBloc, StudycenterState>(
          buildWhen: (p, c) => p.studiedCourses != c.studiedCourses,
          builder: (context, state) {
            return StudyCourseList(
              type: StudyCourseItemType.progressOnly,
              courses: state.studiedCourses ?? [],
            );
          },
        ),
        BlocBuilder<StudycenterBloc, StudycenterState>(
          buildWhen: (p, c) => p.boughtCourses != c.boughtCourses,
          builder: (context, state) {
            return StudyCourseList(
              type: StudyCourseItemType.fullInfo,
              courses: state.boughtCourses ?? [],
            );
          },
        ),
      ],
    );
  }
}

String _durationFormat(double seconds) {
  if (seconds <= 0) return "0";

  int sec = seconds.toInt();
  Duration duation = Duration(seconds: sec);
  String s = duation.toString();

  List<String> strs = s.split(":");

  int hours = int.parse(strs[0]);
  int min = int.parse(strs[1]);
  if (min > 0) {
    double m = double.parse((min / 60).toStringAsFixed(1));
    double result = hours + m;
    return "$result";
  }

  return "$hours";
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  StickyTabBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => 49;

  @override
  double get minExtent => 49;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
