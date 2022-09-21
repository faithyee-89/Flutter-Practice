import 'package:cached_network_image/cached_network_image.dart';
import 'package:cainiaowo/models/comment.dart';
import 'package:cainiaowo/pages/common/bloc/course_bloc.dart';
import 'package:cainiaowo/pages/course/view/index.dart';
import 'package:cainiaowo/utils/utils_string.dart';
import 'package:cainiaowo/models/course.dart';
import 'package:cainiaowo/models/chapter.dart';
import 'package:cainiaowo/widgets/course/lesson_list.dart';
import 'package:cainiaowo/common/icons.dart';
import 'package:cainiaowo/common/constant.dart';
import 'package:cainiaowo/common/values/index.dart';
import 'package:cainiaowo/widgets/tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vant_kit/main.dart';

class CourseDetailPage extends StatefulWidget {
  CourseDetailPage({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  final int courseId;

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage>
    with TickerProviderStateMixin {
  TextStyle titleStyle = TextStyle(
    fontSize: AppFontSize.mediumSp,
    color: Colors.black,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );

  var _tabs = <String>["介绍", "目录", "评价"];
  late TabController _tabController;

  late ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: _tabs.length, vsync: this);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
          child: BlocProvider(
        create: (context) {
          final CourseBloc courseBloc = CourseBloc();
          courseBloc.add(GetCourseDetailEvent(widget.courseId));

          courseBloc.add(GetCommentsEvent(widget.courseId));
          return courseBloc;
        },
        child: BlocBuilder<CourseBloc, CourseState>(
          buildWhen: (previous, current) {
            return current.courseDetail != null;
          },
          builder: (context, state) {
            return Skeleton(
              row: 20,
              loading: state.courseDetail == null,
              child: NestedScrollView(
                  controller: _scrollViewController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return _silverBuilder(context, innerBoxIsScrolled);
                  },
                  body: _buildTabBarView(state)),
            );
          },
        ),
      )),
    );
  }

  List<Widget> _silverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      _sliverAppBar(innerBoxIsScrolled),
      _sliverTabBar(),
    ];
  }

  Widget _sliverAppBar(bool innerBoxIsScrolled) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
      title: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          return Text(
            state.courseDetail?.name ?? '课程详情',
            style: TextStyle(color: Colors.black),
          );
        },
      ),
      floating: false,
      snap: false,
      pinned: true,
      elevation: 0,
      expandedHeight: 530.h,
      forceElevated: innerBoxIsScrolled,
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          CNWFonts.back,
          color: Colors.black,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
          background: Container(
              color: AppColors.backgroundColor,
              margin: EdgeInsets.only(top: 150.h),
              height: double.infinity,
              child: BlocBuilder<CourseBloc, CourseState>(
                  builder: (context, state) {
                return _courseSumary(state);
              }))),
    );
  }

  Widget _sliverTabBar() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SilverAppBarDelegate(TabBar(
          labelColor: AppColors.primaryColor,
          labelStyle: TextStyle(
              fontSize: AppFontSize.mediumSp, fontWeight: FontWeight.w500),
          unselectedLabelColor: Colors.black,
          indicator: TabSizeIndicator(
              wantWidth: 40.w,
              borderSide:
                  BorderSide(width: 3.0, color: AppColors.primaryColor)),
          controller: _tabController,
          tabs: _tabs
              .map((value) => new Tab(
                    text: value,
                  ))
              .toList())),
    );
  }

  Widget _courseSumary(CourseState state) {
    Course? course = state.courseDetail;

    return Container(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 240.w,
              height: 300.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.w),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: UtilsString.fixedHttpStart(course?.imgUrl ?? ""),
                ),
              )),
          Expanded(
            child: Container(
              height: 300.h,
              padding: EdgeInsets.only(left: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course?.name ?? '',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: AppFontSize.mediumSp,
                          color: AppColors.primaryTextColor,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            "类别：${course?.firstCategory?.title ?? ""}    ${course?.lessonsPlayedTime}学习   ${state.courseDetail?.lessonsCount} 课时",
                            style: TextStyle(
                              fontSize: AppFontSize.normalSp,
                              color: AppColors.secondaryTextColor,
                            ),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        course?.isFree == 1
                            ? '免费'
                            : "￥${course?.nowPrice.toString() ?? ''}  ",
                        style: TextStyle(
                          fontSize: AppFontSize.mediumSp,
                          color: course?.isFree == 1
                              ? AppColors.blue
                              : AppColors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

// ------  底部 TabBarView -------
  Widget _buildTabBarView(CourseState state) {
    return Container(
        color: Colors.white,
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            _tabViewCourseIntro(state),
            _tabViewLessons(state),
            _tabViewComments(state),
          ],
        ));
  }

  Widget _tabViewCourseIntro(CourseState state) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.backgroundColor,
        child: Column(
          children: [_teacherDesc(), _courseDesc()],
        ),
      ),
    );
  }

  Widget _teacherDesc() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              '讲师介绍',
              style: titleStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: ClipOval(
                      child: Container(
                        color: AppColors.gray,
                        child: BlocBuilder<CourseBloc, CourseState>(
                          builder: (context, state) {
                            return Image.network(
                              UtilsString.fixedHttpStart(
                                  state.courseDetail?.teacher?.logoUrl ??
                                      defualtHeadImg),
                              width: 60,
                              height: 60,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<CourseBloc, CourseState>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.courseDetail?.teacher?.teacherName ??
                                      '',
                                  style: TextStyle(
                                    fontSize: AppFontSize.normalSp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    "${state.courseDetail?.teacher?.company}·${state.courseDetail?.teacher?.teacherName}",
                                    style: TextStyle(
                                      fontSize: AppFontSize.normalSp,
                                      color: AppColors.regularTextColor,
                                    ),
                                  ),
                                ),
                                Divider(
                                  endIndent: 12,
                                  height: 10,
                                  thickness: 1,
                                  color: AppColors.borderColor,
                                ),
                                Text(
                                  state.courseDetail?.teacher?.brief ?? '',
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: AppFontSize.normalSp,
                                    color: AppColors.regularTextColor,
                                  ),
                                ),
                              ]),
                        );
                      },
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  Widget _courseDesc() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 20.h),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '课程介绍',
              style: titleStyle,
            ),
            BlocBuilder<CourseBloc, CourseState>(
              builder: (context, state) {
                // print(state.courseDetail?.desc);
                // return Container();
                return Html(
                  data: """${state.courseDetail?.desc}""",
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabViewLessons(CourseState state) {
    bool hasAuthority = state.courseDetail?.isFree == 1
        ? true
        : (state.courseDetail?.hasAuthority ?? false);
    return LessonList(courseId: widget.courseId, hasAuthority: hasAuthority);
  }

  Widget _tabViewComments(CourseState state) {
    return CustomScrollView(
      slivers: _commentsList(),
    );
  }

  List<Widget> _commentsList() {
    List<Widget> _comments = [];

    _comments.add(
      BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          return (state.comments != null && state.comments!.length > 0)
              ? SliverList(
                  delegate: SliverChildBuilderDelegate((content, index) {
                    Comment comment = state.comments![index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 14),
                                child: ClipOval(
                                  child: Container(
                                    color: AppColors.gray,
                                    child: Image.network(
                                      UtilsString.fixedHttpStart(
                                          comment.user?.logoUrl ?? ""),
                                      width: 45,
                                      height: 45,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  comment.user?.username ?? '',
                                  style: TextStyle(
                                    fontSize: AppFontSize.normalSp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Icon(
                                  CNWFonts.star,
                                  size: 20,
                                  color: Colors.red,
                                ),
                              ),
                              Icon(
                                CNWFonts.star,
                                size: 20,
                                color: Colors.red,
                              ),
                              Icon(
                                CNWFonts.star,
                                size: 20,
                                color: Colors.red,
                              ),
                              Icon(
                                CNWFonts.star_un,
                                size: 20,
                                color: Colors.red,
                              ),
                              Icon(
                                CNWFonts.star_un,
                                size: 20,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 60),
                          child: Text(
                            comment.comment ?? '',
                            // maxLines: 3,
                            style: TextStyle(
                              fontSize: AppFontSize.normalSp,
                              color: AppColors.regularTextColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Divider(
                            indent: 14,
                            endIndent: 14,
                            height: 1,
                            thickness: 1,
                            color: AppColors.gray,
                          ),
                        ),
                      ],
                    );
                  }, childCount: state.comments?.length ?? 0),
                )
              : SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        CNWFonts.no_data,
                        size: 70,
                        color: Color(0xFF999999),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 25,
                        ),
                        child: Text(
                          '暂无评论',
                          // maxLines: 3,
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );

    return _comments;
  }
}

class _SilverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SilverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class CommonSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  PreferredSize child; //传入preferredsize组件，因为此组件需要固定高度
  bool islucency; //入参 是否更加滑动变化透明度，true，false
  Color backgroundColor; //需要设置的背景色
  CommonSliverHeaderDelegate(
      {required this.islucency,
      required this.child,
      this.backgroundColor = Colors.white});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double mainHeight = maxExtent - shrinkOffset; //动态获取滑动剩余高度
    return Container(
      color: backgroundColor,
      child: Opacity(
          opacity: islucency == true && mainHeight != maxExtent
              ? ((mainHeight / maxExtent) * 0.5).clamp(0, 1)
              : 1, //根据滑动高度隐藏显示
          child: child),
    );
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
