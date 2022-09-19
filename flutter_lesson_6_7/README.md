# 课程目标

- 课程页需求分析
- 课程页网络模块封装
- 课程页实现
- 学习页需求分析
- 学习页网络模块封装
- 学习页实现

# 正文

### 1. 课程页及学习页需求分析

![GIF 2022-9-19 11-26-30](https://note.youdao.com/yws/public/resource/dc091bd7831ccf1b9729cc2bb2c4824b/6CE3441E5B524DF98CF1EFA8868747A3?ynotemdtimestamp=1663590166853)

- 课程页

![课程页](https://note.youdao.com/yws/public/resource/dc091bd7831ccf1b9729cc2bb2c4824b/6EB3E451446A4EEEADAA0C2344097FC2?ynotemdtimestamp=1663590166853)

- 学习页-最近学习

![学习页](https://note.youdao.com/yws/public/resource/dc091bd7831ccf1b9729cc2bb2c4824b/5A4EA9180E4E439CB6A37F47DC641D9C?ynotemdtimestamp=1663590166853)

- 学习页-我的课程

![学习页2](https://note.youdao.com/yws/public/resource/dc091bd7831ccf1b9729cc2bb2c4824b/CFEFD734FD0142C68FAC0152736EDA02?ynotemdtimestamp=1663590166853)

### 课程页网络模块封装

1. 课程模块的网络请求代码


```dart
// 获取课程分类
const String net_course_path_category = '/course/category';

// 获取课程列表
const String net_course_path_courselist = '/course/v2/list';
```


```dart
class CNWCourseNetManager {
  // 课程分类
  static Future<List> courseCategory() async {
    List list = await CNWNetManager.get<List>(
      net_course_path_category,
    );
    return list;
  }

  // 课程列表接口实现
  static Future<Map> courseList({
    int courseType = -1,
    String code = 'all',
    int difficulty = -1,
    int isFree = -1,
    int q = -1,
    int page = 1,
    int size = 20,
  }) async {
    Map<String, dynamic> queryParameters = {};
    if (courseType != null) queryParameters['course_type'] = courseType;
    if (code != null) queryParameters['code'] = code;
    if (difficulty != null) queryParameters['difficulty'] = difficulty;
    if (isFree != null) queryParameters['is_free'] = isFree;
    if (q != null) queryParameters['q'] = q;
    if (page != null) queryParameters['page'] = page;
    if (size != null) queryParameters['size'] = size;

    Map map = await CNWNetManager.get<Map>(
      net_course_path_courselist,
      queryParameters: queryParameters,
    );
    return map;
  }
}

```


2. 网络请求代码使用


```
  Stream<CourseListState> _mapLoadDataToState(
    CourseListEvent event,
    CourseListState state,
  ) async* {
    // 请求课程分类的数据
    List list = await CNWCourseNetManager.courseCategory();

    List<CourseCategory> categories = [];

    categories.add(CourseCategory(code: 'all', id: -1, title: '全部'));
    categories.addAll(List<Map>.from(list)
        .map((dynamic e) => CourseCategory.fromJson(e))
        .toList());

    yield state.copyWith(tabs: categories);
  }
```


```dart
 Stream<CourseState> _mapLoadDataToState(
    CourseEvent event,
    CourseState state,
  ) async* {
    Map params = (event as CourseEventLoadData).params;
    // 获取 课程列表 数据
    Map data = await CNWCourseNetManager.courseList(
      courseType: params['courseType'],
      code: params['code'],
      difficulty: params['difficulty'],
      isFree: params['isFree'],
      q: params['q'],
      page: params['page'],
      size: params['size'] ?? CourseListPageSize,
    );
    List<Course> courses = List<Map>.from(data['datas'])
        .map((dynamic e) => Course.fromJson(e))
        .toList();

    if (params['page'] != null && params['page'] > 1) {
      courses.insertAll(0, state.courses);
    }

    yield state.copyWith(
      courses: courses,
      noMore: (data['page'] ?? 1) >= (data['total_page'] ?? 1),
    );
  }
```



### 课程页实现

1. 页面需要保活，避免tab切换的时候，bloc组件状态丢失


```dart
class _CourseListPageState extends State<CourseListPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;
```

2. tabBar使用

![tab组件](https://note.youdao.com/yws/public/resource/dc091bd7831ccf1b9729cc2bb2c4824b/8C94C688A8844FA48ACB2B61A7DD7660?ynotemdtimestamp=1663590166853)


```dart
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
```


```dart
_tabController = TabController(
    initialIndex: state.selectedTabIndex ?? 0,
    length: state.tabs.length ?? 1,
    vsync: this);
```

1. 自定义复杂控件，以下节选部分代码，详细请看代码仓库courselist_page.dart类的_filterTabs()方法

![filter控件](https://note.youdao.com/yws/public/resource/dc091bd7831ccf1b9729cc2bb2c4824b/1BB2BACCE0CB43709662720EDFD98AB6?ynotemdtimestamp=1663590166853)


```dart
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

```

1. 与页面绑定的bloc组件


```dart
class CourseListBloc extends Bloc<CourseListEvent, CourseListState> {
  CourseListBloc() : super(CourseListState());

  @override
  Stream<CourseListState> mapEventToState(
    CourseListEvent event,
  ) async* {
    if (event is CourseListEventLoadData) {
      yield* _mapLoadDataToState(event, state);
    } else if (event is CourseListEventSelectedTabIndexChanged) {
      yield _mapSelectedTabIndexToState(event, state);
    } else if (event is CourseListEventFilterSelectedIndexChanged) {
      yield _mapFliterSelectedIndexsToState(event, state);
    }
  }

  Stream<CourseListState> _mapLoadDataToState(
    CourseListEvent event,
    CourseListState state,
  ) async* {
    // 请求课程分类的数据
    List list = await CNWCourseNetManager.courseCategory();

    List<CourseCategory> categories = [];

    categories.add(CourseCategory(code: 'all', id: -1, title: '全部'));
    categories.addAll(List<Map>.from(list)
        .map((dynamic e) => CourseCategory.fromJson(e))
        .toList());

    yield state.copyWith(tabs: categories);
  }

    ...
}

```


```
abstract class CourseListEvent extends Equatable {
  const CourseListEvent();

  @override
  List<Object> get props => [];
}

class CourseListEventLoadData extends CourseListEvent {
  const CourseListEventLoadData();
}

class CourseListEventSelectedTabIndexChanged extends CourseListEvent {
  const CourseListEventSelectedTabIndexChanged(this.selectedTabIndex);

  final int selectedTabIndex;
}

class CourseListEventFilterSelectedIndexChanged extends CourseListEvent {
  const CourseListEventFilterSelectedIndexChanged(this.index, this.value);

  final int index;
  final int value;
}

```

```dart
class CourseListState extends Equatable {
  const CourseListState({
    this.tabs,
    this.selectedTabIndex = 0,
    this.filterSelectedIndexs = const [0, 0, 0, 0],
  });

  final List<CourseCategory> tabs;
  final int selectedTabIndex;
  final List<int> filterSelectedIndexs;

  CourseListState copyWith({
    List<CourseCategory> tabs,
    int selectedTabIndex,
    List<int> filterSelectedIndexs,
  }) {
    return CourseListState(
      tabs: tabs ?? this.tabs,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      filterSelectedIndexs: filterSelectedIndexs ?? this.filterSelectedIndexs,
    );
  }

  @override
  List<Object> get props => [
        tabs,
        selectedTabIndex,
        filterSelectedIndexs,
      ];
}

```

### 学习页网络模块封装


```dart
// 用户学习详情
const String net_studycenter_path_info = '/member/study/info';

// 学习过的课程列表
const String net_studycenter_path_coursestudied = '/member/courses/studied';

// 用户购买的课程
const String net_studycenter_path_coursesbought = '/member/courses/bought';
```


```dart
class CNWStudyCenterNetManager {
  // 用户学习详情
  static Future<Map> memberStudyInfo() async {
    Map map = await CNWNetManager.get<Map>(
      net_studycenter_path_info,
    );
    return map;
  }

  // 学习过的课程列表
  static Future<Map> memberCoursesStydied({
    int page = 1,
    int size = 20,
  }) async {
    Map<String, dynamic> queryParameters = {};
    if (page != null) queryParameters['page'] = page;
    if (size != null) queryParameters['size'] = size;

    Map map = await CNWNetManager.get<Map>(
      net_studycenter_path_coursestudied,
      queryParameters: queryParameters,
    );
    return map;
  }

  // 学习过的课程列表
  static Future<Map> memberCoursesBought({
    int page = 1,
    int size = 20,
  }) async {
    Map<String, dynamic> queryParameters = {};
    if (page != null) queryParameters['page'] = page;
    if (size != null) queryParameters['size'] = size;

    Map map = await CNWNetManager.get<Map>(
      net_studycenter_path_coursesbought,
      queryParameters: queryParameters,
    );
    return map;
  }
}

```



### 学习页实现

1. 页面需要与用户登录状态同步，也就是说代码的逻辑需要判断是否已登录



```dart
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

```

2. 页面有使用了nestedScrollView,使用方法如下：


```dart
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
```

3. bloc组件内容及页面调用


```dart
const int StudyCenterPageSize = 20;

class StudycenterBloc extends Bloc<StudycenterEvent, StudycenterState> {
  StudycenterBloc() : super(StudycenterState());

  @override
  Stream<StudycenterState> mapEventToState(
    StudycenterEvent event,
  ) async* {
    if (event is StudycenterEventLoadStudyInfo) {
      yield* _mapLoadStudyInfoToState(event, state);
    } else if (event is StudycenterEventLoadStudiedCourses) {
      yield* _mapLoadStudiedCoursesToState(event, state);
    } else if (event is StudycenterEventLoadBoughtCourses) {
      yield* _mapLoadBoughtCoursesToState(event, state);
    }
  }

  Stream<StudycenterState> _mapLoadStudyInfoToState(
    StudycenterEvent event,
    StudycenterState state,
  ) async* {
    
    Map data = await CNWStudyCenterNetManager.memberStudyInfo();
    StudyInfo studyInfo = StudyInfo.fromJson(data);

    yield state.copyWith(
      studyInfo: studyInfo,
    );
  }

    ...
}
```


```dart
abstract class StudycenterEvent extends Equatable {
  const StudycenterEvent();

  @override
  List<Object> get props => [];
}

class StudycenterEventLoadStudyInfo extends StudycenterEvent {
  const StudycenterEventLoadStudyInfo();
}


class StudycenterEventLoadStudiedCourses extends StudycenterEvent {
  const StudycenterEventLoadStudiedCourses({this.params});
  final Map params;
}

class StudycenterEventLoadBoughtCourses extends StudycenterEvent {
  const StudycenterEventLoadBoughtCourses({this.params});
  final Map params;
}
```


```dart
class StudycenterState extends Equatable {
  const StudycenterState({
    this.studyInfo = const StudyInfo(),
    this.studiedCourses,
    this.boughtCourses,
    this.noMoreForStudied,
    this.noMoreForBought,
  });

  final StudyInfo studyInfo;
  final List<Course> studiedCourses;
  final List<BoughtCourse> boughtCourses;
  final bool noMoreForStudied;
  final bool noMoreForBought;

  StudycenterState copyWith({
    StudyInfo studyInfo,
    List<Course> studiedCourses,
    List<BoughtCourse> boughtCourses,
    bool noMoreForStudied,
    bool noMoreForBought,
  }) {
    return StudycenterState(
      studyInfo: studyInfo ?? this.studyInfo,
      studiedCourses: studiedCourses ?? this.studiedCourses,
      boughtCourses: boughtCourses ?? this.boughtCourses,
      noMoreForBought: noMoreForBought ?? this.noMoreForBought,
      noMoreForStudied: noMoreForStudied ?? this.noMoreForStudied,
    );
  }

  @override
  List<Object> get props => [studyInfo, studiedCourses, boughtCourses, noMoreForBought, noMoreForStudied];
}
```

4. 页面调用示例


```dart
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
```


