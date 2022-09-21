import 'package:cainiaowo/pages/course/bloc/courselist_bloc.dart';
import 'package:cainiaowo/pages/course/view/courselist_const.dart';
import 'package:cainiaowo/pages/course/view/dropdownlist.dart';
import 'package:cainiaowo/pages/index/course/bloc/course_bloc.dart';
import 'package:cainiaowo/pages/index/course/view/index.dart';
import 'package:cainiaowo/common/icons.dart';
import 'package:cainiaowo/common/values/index.dart';
import 'package:cainiaowo/models/category.dart';
import 'package:cainiaowo/widgets/tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final CourseListBloc courseListBloc = CourseListBloc();
final Map<int, CourseBloc> courseBlocs = {};
final Map<int, CoursePage> coursePages = {};

class CourseListPage extends StatefulWidget {
  CourseListPage({Key? key}) : super(key: key);

  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;

  late OverlayEntry _overlayEntry;
  bool isShowDrop = false;

  final filterTabKey = GlobalKey();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    courseListBloc.add(GetCategoriesEvent());
    super.initState();
  }

  @override
  void dispose() {
    courseListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      bottom: false,
      child: BlocProvider(
        create: (context) => courseListBloc,
        child: BlocBuilder<CourseListBloc, CourseListState>(
          buildWhen: (previous, current) {
            return previous.tabs != current.tabs;
          },
          builder: (context, state) {
            if (state.tabs == null) return Container();
            _tabController = TabController(
                initialIndex: state.selectedTabIndex,
                length: state.tabs?.length ?? 1,
                vsync: this);
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _tabBar(),
                _filterTabs(),
                _tabViews(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _tabBar() {
    return BlocBuilder<CourseListBloc, CourseListState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.fromLTRB(5, 15, 5, 0),
          height: 60.h,
          child: TabBar(
            controller: _tabController,
            onTap: (int index) {
              courseListBloc.add(SelectedTabIndexChangedEvent(index));
            },
            tabs: _categoriesToTabs(state) ?? [],
            isScrollable: true,
            labelColor: AppColors.primaryColor,
            labelStyle: TextStyle(fontSize: 45.sp, fontWeight: FontWeight.w500),
            unselectedLabelColor: Colors.black,
            indicator: TabSizeIndicator(
                wantWidth: 40.w,
                borderSide:
                    BorderSide(width: 3.0, color: AppColors.primaryColor)),
          ),
        );
      },
    );
  }

  List<Tab>? _categoriesToTabs(CourseListState state) {
    return state.tabs?.map((tab) {
      return Tab(
        text: tab.title ?? "",
      );
    }).toList();
  }

  Widget _filterTabs() {
    return BlocBuilder<CourseListBloc, CourseListState>(
        builder: (context, state) {
      return Container(
        key: filterTabKey,
        height: 80.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: state.filterSelectedIndexs
              .asMap()
              .map((int index, int selectedIndex) {
                List<Map> cTabList = CourseListFilters[index];
                Map cSelectedItem = cTabList[selectedIndex];
                return MapEntry(
                  index,
                  _filterTab(
                      cSelectedItem['title'],
                      index,
                      cTabList.map((Map e) => e['title']).toList(),
                      selectedIndex),
                );
              })
              .values
              .toList(),
        ),
      );
    });
  }

  Widget _filterTab(String title, int index, List menus, int selectedIndex) {
    return GestureDetector(
      onTap: () {
        if (isShowDrop) {
          _overlayEntry.remove();
          isShowDrop = false;
          return;
        }

        final box =
            filterTabKey.currentContext?.findRenderObject() as RenderBox;
        final dy = box.localToGlobal(Offset(0, box.size.height)).dy;
        _showDropDownList(
          menus,
          selectedIndex,
          dy,
          index,
        );
      },
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: AppFontSize.normalSp,
              color: AppColors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Icon(
              CNWFonts.down,
              size: 32.sp,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabViews() {
    return BlocBuilder<CourseListBloc, CourseListState>(
      builder: (context, state) {
        return Expanded(
          child: TabBarView(
            controller: _tabController,
            children: state.tabs
                    ?.asMap()
                    .map((int index, Category category) {
                      Map params = state.filterSelectedIndexs
                          .asMap()
                          .map((int index, int selectedIndex) {
                        List<Map> cTabList = CourseListFilters[index];
                        Map cSelectedItem = cTabList[selectedIndex];
                        return MapEntry(
                          CourseListFilterKeys[index],
                          cSelectedItem['value'],
                        );
                      });
                      params['code'] = category.code;
                      return MapEntry(
                        index,
                        _coursePageAtIndex(
                            index, params, state.selectedTabIndex == index),
                      );
                    })
                    .values
                    .toList() ??
                [],
          ),
        );
      },
    );
  }

  CourseBloc _courseBlocAtIndex(int index) {
    CourseBloc? bloc = courseBlocs[index];
    if (bloc == null) {
      bloc = CourseBloc();
      courseBlocs[index] = bloc;
    }
    return bloc;
  }

  CoursePage _coursePageAtIndex(int index, Map params, bool refresh) {
    CoursePage? page = coursePages[index];
    CourseBloc bloc = _courseBlocAtIndex(index);
    if (page == null) {
      page = CoursePage(
        courseBloc: bloc,
        params: params,
      );
      coursePages[index] = page;
    }
    if (refresh) bloc.add(GetDataEvent(params: params));
    return page;
  }

  void _showDropDownList(
    List menus,
    int selectedIndex,
    double dy,
    int filterMenuIndex,
  ) {
    isShowDrop = true;
    _overlayEntry = OverlayEntry(
        builder: (context) => Positioned.fill(
              top: dy,
              child: Material(
                color: Color(0x55000000),
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      // alignment: Alignment.center,
                      constraints:
                          BoxConstraints.expand(height: 51.0 * menus.length),
                      child: DropDownList(
                        menus: menus,
                        selectedIndex: selectedIndex,
                        onTap: (index) {
                          //
                          courseListBloc.add(FilterSelectedIndexChangedEvent(
                              filterMenuIndex, index));
                          _overlayEntry.remove();
                          // _overlayEntry = null;
                          isShowDrop = false;
                        },
                      ),
                    ),
                    Expanded(child: GestureDetector(onTap: () {
                      _overlayEntry.remove();
                      // _overlayEntry = null;
                      isShowDrop = false;
                    })),
                  ],
                ),
              ),
            ));
    Overlay.of(context)?.insert(_overlayEntry);
  }
}
