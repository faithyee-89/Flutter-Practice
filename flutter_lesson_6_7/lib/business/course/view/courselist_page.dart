import 'package:cainiaowo/business/course/bloc/courselist_bloc.dart';
import 'package:cainiaowo/business/course/models/course_category.dart';
import 'package:cainiaowo/business/course/view/courselist_const.dart';
import 'package:cainiaowo/business/course/view/dropdownlist.dart';
import 'package:cainiaowo/business/index/course/bloc/course_bloc.dart';
import 'package:cainiaowo/business/index/course/view/course_page.dart';
import 'package:cainiaowo/common/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final CourseListBloc courseListBloc = CourseListBloc();
final Map<int, CourseBloc> courseBlocs = {};
final Map<int, CoursePage> coursePages = {};

class CourseListPage extends StatefulWidget {
  CourseListPage({Key key}) : super(key: key);

  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  OverlayEntry _overlayEntry;
  bool isShowDrop = false;

  final filterTabKey = GlobalKey();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    courseListBloc.add(CourseListEventLoadData());
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
                initialIndex: state.selectedTabIndex ?? 0,
                length: state.tabs.length ?? 1,
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
          height: 40,
          child: TabBar(
            controller: _tabController,
            onTap: (int index) {
              courseListBloc.add(CourseListEventSelectedTabIndexChanged(index));
            },
            tabs: state.tabs
                .asMap()
                .map((int index, CourseCategory tab) => MapEntry(
                    index,
                    Text(tab.title,
                        style: TextStyle(
                          color: state.selectedTabIndex == index
                              ? Color(0xFFFC9900)
                              : Color(0xFF999999),
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ))))
                .values
                .toList(),
            isScrollable: true,
            unselectedLabelColor: Color(0xFF999999),
            labelColor: Color(0xFFFC9900),
            indicatorColor: Color(0xFFFC9900),
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.label,
          ),
        );
      },
    );
  }

  Widget _filterTabs() {
    return BlocBuilder<CourseListBloc, CourseListState>(
        builder: (context, state) {
      return Container(
        key: filterTabKey,
        height: 50,
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
          _overlayEntry?.remove();
          isShowDrop = false;
          return;
        }

        final box = filterTabKey.currentContext.findRenderObject() as RenderBox;
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
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Icon(
              CNWFonts.down,
              size: 12,
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
                .asMap()
                .map((int index, CourseCategory category) {
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
                .toList(),
          ),
        );
      },
    );
  }

  CourseBloc _courseBlocAtIndex(int index) {
    CourseBloc bloc = courseBlocs[index];
    if (bloc == null) {
      bloc = CourseBloc();
      courseBlocs[index] = bloc;
    }
    return bloc;
  }

  CoursePage _coursePageAtIndex(int index, Map params, bool refresh) {
    CoursePage page = coursePages[index];
    CourseBloc bloc = _courseBlocAtIndex(index);
    if (page == null) {
      page = CoursePage(
        courseBloc: bloc,
        params: params,
      );
      coursePages[index] = page;
    }
    if (refresh) bloc.add(CourseEventLoadData(params: params));
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
                          courseListBloc.add(
                              CourseListEventFilterSelectedIndexChanged(
                                  filterMenuIndex, index));
                          _overlayEntry.remove();
                          _overlayEntry = null;
                          isShowDrop = false;
                        },
                      ),
                    ),
                    Expanded(child: GestureDetector(onTap: () {
                      _overlayEntry.remove();
                      _overlayEntry = null;
                      isShowDrop = false;
                    })),
                  ],
                ),
              ),
            ));
    Overlay.of(context).insert(_overlayEntry);
  }
}
