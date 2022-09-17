import 'package:flutter_lesson_6_6/business/index/course/bloc/course_bloc.dart';
import 'package:flutter_lesson_6_6/business/index/course/view/course_page.dart';
import 'package:flutter_lesson_6_6/business/index/grade/view/grade_page.dart';
import 'package:flutter_lesson_6_6/business/index/recommend/view/recommend_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lesson_6_6/business/index/bloc/index_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  preferredSize: const Size.fromHeight(40),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      onTap: (int index) {
                        context
                            .read<IndexBloc>()
                            .add(IndexEventSelectedIndexChanged(index));
                      },
                      isScrollable: true,
                      unselectedLabelColor: Color(0xFF999999),
                      labelColor: Color(0xFFFC9900),
                      indicatorColor: Color(0xFFFC9900),
                      indicatorWeight: 3,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: state.tabs
                          .asMap()
                          .map((int index, String title) => MapEntry(
                              index,
                              Text(title,
                                  style: TextStyle(
                                    color: state.selectedIndex == index
                                        ? Color(0xFFFC9900)
                                        : Color(0xFF999999),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ))))
                          .values
                          .toList(),
                    ),
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
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
      height: 40,
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
              size: 22,
              color: Color(0xFF999999),
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
                  fontSize: 15,
                  color: Color(0xFF999999),
                ),
              ),
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF333333),
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
