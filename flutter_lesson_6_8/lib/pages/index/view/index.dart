import 'package:cainiaowo/pages/index/course/bloc/course_bloc.dart';
import 'package:cainiaowo/pages/index/course/view/index.dart';
import 'package:cainiaowo/pages/index/grade/view/index.dart';
import 'package:cainiaowo/pages/index/recommend/view/index.dart';
import 'package:cainiaowo/common/values/index.dart';
import 'package:cainiaowo/widgets/tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:cainiaowo/pages/index/bloc/index_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key? key}) : super(key: key);

  final IndexBloc indexBloc = IndexBloc();

  final tabViews = <Widget>[
    RecommendPage(),
    CoursePage(
      courseBloc: CourseBloc(),
      params: {'courseType': -1, 'isFree': 1},
    ),
    CoursePage(
      courseBloc: CourseBloc(),
      params: {'courseType': 3, 'isFree': -1},
    ),
    GradePage(),
  ];

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.indexBloc,
      child: BlocBuilder<IndexBloc, IndexState>(
        builder: (context, state) {
          return DefaultTabController(
            length: state.tabs.length,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                // 去掉导航条下面的阴影
                elevation: 0,
                title: _searchBar(),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      onTap: (int index) {
                        context
                            .read<IndexBloc>()
                            .add(SelectedIndexChangedEevnt(index));
                      },
                      isScrollable: true,
                      labelColor: Color(0xFFFC9900),
                      labelStyle: TextStyle(
                          fontSize: 45.sp, fontWeight: FontWeight.w500),
                      unselectedLabelColor: Color(0xFF303132),
                      indicator: TabSizeIndicator(
                          wantWidth: 50.w,
                          borderSide:
                              BorderSide(width: 3.0, color: Color(0xFFFC9900))),
                      tabs: state.tabs
                          .map((value) => Text(
                                value,
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TabBarView(
                  // physics: NeverScrollableScrollPhysics(),
                  children: widget.tabViews,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 100.h,
      // 圆角部分实现
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // 放大镜
          SizedBox(
            child: Icon(
              Icons.search,
              size: 50.sp,
              color: AppColors.gray,
            ),
          ),
          Expanded(
            child: TextField(
              focusNode: FocusNode(),
              controller: TextEditingController(),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: '搜索课程',
                hintStyle: TextStyle(
                  fontSize: AppFontSize.normalSp,
                  color: AppColors.gray,
                ),
              ),
              style: TextStyle(
                fontSize: AppFontSize.normalSp,
                color: AppColors.primaryTextColor,
              ),
              textInputAction: TextInputAction.search,
              onTap: null,
              onSubmitted: null,
            ),
          ),
        ],
      ),
    );
  }
}
