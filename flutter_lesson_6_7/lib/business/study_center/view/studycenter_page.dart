import 'package:cainiaowo/business/authentication/authentication.dart';
import 'package:cainiaowo/business/common/utils_string.dart';
import 'package:cainiaowo/business/study_center/bloc/studycenter_bloc.dart';
import 'package:cainiaowo/business/study_center/models/bought_course.dart';
import 'package:cainiaowo/business/study_center/view/study_coursecell.dart';
import 'package:cainiaowo/business/study_center/view/study_courselist.dart';
import 'package:cainiaowo/common/view/loginhint_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

StudycenterBloc studyCenterBloc = StudycenterBloc();

class StudyCenterPage extends StatefulWidget {
  StudyCenterPage({Key key}) : super(key: key);

  @override
  _StudyCenterPageState createState() => _StudyCenterPageState();
}

class _StudyCenterPageState extends State<StudyCenterPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

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
            studyCenterBloc.add(StudycenterEventLoadStudyInfo());
            studyCenterBloc.add(StudycenterEventLoadStudiedCourses());
            studyCenterBloc.add(StudycenterEventLoadBoughtCourses());
          }
          return state.status == AuthenticationStatus.authenticated
              ? BlocProvider(
                  create: (_) => studyCenterBloc,
                  child: _studyCenterPage(),
                )
              : LoginHintPage();
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
              backgroundColor: Colors.white,
              forceElevated: innerBoxIsScrolled,
              bottom: PreferredSize(
                  child: Container(), preferredSize: Size.fromHeight(170)),

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
                        color: Color(0x33999999),
                        child: state.user.logo != null
                            ? Image.network(
                                UtilsString.fixedHttpStart(state.user.logo) ??
                                    '',
                                width: 80,
                                height: 80)
                            : Container(width: 80, height: 80),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Text(state.user.username ?? '昵称',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff000000),
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      state.studyInfo.todayStudyTime.toString() ??
                          '0', //state.user.username ??
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff000000),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 3,
                        top: 3,
                      ),
                      child: Text(
                        '分钟', //state.user.username ??
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF999999),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text('今日学习', //state.user.username ??
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF999999),
                        )))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      state.studyInfo.totalStudyTime.toString() ??
                          '0', //state.user.username ??
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff000000),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 3,
                        top: 3,
                      ),
                      child: Text(
                        '分钟', //state.user.username ??
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF999999),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text('总共学习', //state.user.username ??
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF999999),
                        )))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  state.studyInfo.rank == 0?
                      '千里之外':state.studyInfo.rank.toString(), //state.user.username ??
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff000000),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text('学习排名', //state.user.username ??
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF999999),
                        )))
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _tabBar() {
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
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff303133),
                      )),
                ),
              ),
              Tab(
                child: Container(
                  color: Colors.white,
                  child: Text('我的课程', //state.user.username ??
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff303133),
                      )),
                ),
              ),
            ],
            // isScrollable: true,
            unselectedLabelColor: Color(0xFF999999),
            labelColor: Color(0xFFFC9900),
            indicatorColor: Color(0xFFFC9900),
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
              type: StudyCourseCellType.progressOnly,
              courses: state.studiedCourses ?? [],
            );
          },
        ),
        BlocBuilder<StudycenterBloc, StudycenterState>(
          buildWhen: (p, c) => p.boughtCourses != c.boughtCourses,
          builder: (context, state) {
            return StudyCourseList(
              type: StudyCourseCellType.fullInfo,
              courses: state.boughtCourses.map((BoughtCourse e) => e.course).toList() ?? [],
            );
          },
        ),
      ],
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  StickyTabBarDelegate({@required this.child});

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
