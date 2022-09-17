# 课程目标
- 需求介绍
- 首页接口封装
- 首页的UI实现
    - 首页父布局：index_page
        - bloc实现index_page逻辑
        - tab按钮逻辑
    - 子页面：推荐页recommend_page
    - 子页面：课程页course_page
    - 子页面：实战页grade_page

# 正文

### 需求介绍

推荐页

![推荐页](https://note.youdao.com/yws/public/resource/847c77db8b20d19d36ca7495773552de/66554528504D47A3BA6E4478FF4542EE?ynotemdtimestamp=1663417654646)

course页

![course页](https://note.youdao.com/yws/public/resource/847c77db8b20d19d36ca7495773552de/3E51C96C0E604FE69B2DF5798055FBC5?ynotemdtimestamp=1663417654646)

grade页

![grade页](https://note.youdao.com/yws/public/resource/847c77db8b20d19d36ca7495773552de/84004F8D766C400B9962723A60FCAFE8?ynotemdtimestamp=1663417654646)

### 首页接口封装

net_index.dart


```dart
import 'package:cainiaowo/network/common/net_manager.dart';
import 'package:cainiaowo/network/index/net_index_path.dart';
import 'package:dio/dio.dart';

class CNWIndexNetManager {
  // 首页banner 图的接口实现
  static Future<List> bannerList({int type, int pageShow}) async {
    Map<String, dynamic> queryParameters = {};
    if (type != null) queryParameters['type'] = type;
    if (pageShow != null) queryParameters['page_show'] = pageShow;

    List list = await CNWNetManager.get<List>(
      net_index_path_bannerlist,
      queryParameters: queryParameters,
    );
    return list;
  }

  // 首页模块列表接口实现
  static Future<List> moduleList() async {
    List list = await CNWNetManager.get<List>(
      net_index_path_modulelist,
    );
    return list;
  }

  // 首页 模块详情列表接口实现
  static Future<List> componentList(int moduleId, int type) async {
    if (moduleId == null || type == null) {
      Response response = Response(statusCode: 404, data: {
        "errorCode": '-1',
        "errorMsg": 'moudleId or type can not be null.'
      });
      return response.data;
    }

    Map<String, dynamic> queryParameters = {
      'module_id': moduleId ?? '',
      'module_type': type ?? ''
    };

    List list = await CNWNetManager.get<List>(
      net_index_path_componentlist,
      queryParameters: queryParameters,
    );
    return list;
  }
}

```


```dart
// 获取首页 轮播图
const String net_index_path_bannerlist = '/ad/new/banner/list';
// 获取首页的模块列表
const String net_index_path_modulelist = '/allocation/module/list';
// 获取首页模块详情
const String net_index_path_componentlist = '/allocation/component/list';

```


### 首页的UI实现

#### 1. 首页父布局：index_page

1.1 bloc实现index_page逻辑

首先实现index的bloc相关类：index.bloc、index_event、index_state


```dart
class IndexBloc extends Bloc<IndexEvent, IndexState> {
  IndexBloc() : super(IndexState());

  @override
  Stream<IndexState> mapEventToState(
    IndexEvent event,
  ) async* {
    if (event is IndexEventLoadData) {
      yield _mapLoadDataToState(event, state);
    } else if (event is IndexEventSelectedIndexChanged) {
      yield _mapSelectedIndexChangedToState(event, state);
    } else if (event is IndexEventGeadeModuleChanged) {
      yield _mapGradeModuleToState(event, state);
    }
  }

  IndexState _mapLoadDataToState(
    IndexEvent event,
    IndexState state,
  ) {
    // 网络请求
    return state.copyWith();
  }

  IndexState _mapSelectedIndexChangedToState(
    IndexEvent event,
    IndexState state,
  ) {
    return state.copyWith(
        selectedIndex: (event as IndexEventSelectedIndexChanged).selectedIndex);
  }

  IndexState _mapGradeModuleToState(
    IndexEvent event,
    IndexState state,
  ) {
    return state.copyWith(
        gradeModule: (event as IndexEventGeadeModuleChanged).gradeModule);
  }
}
```


```dart
abstract class IndexEvent extends Equatable {
  const IndexEvent();

  @override
  List<Object> get props => [];
}

class IndexEventLoadData extends IndexEvent {
  const IndexEventLoadData();
}

class IndexEventSelectedIndexChanged extends IndexEvent {
  const IndexEventSelectedIndexChanged(this.selectedIndex);

  final int selectedIndex;
}

class IndexEventGeadeModuleChanged extends IndexEvent {
  const IndexEventGeadeModuleChanged(this.gradeModule);

  final Module gradeModule;
}
```


```dart
class IndexState extends Equatable {
  final int selectedIndex;
  final List<String> tabs;
  final Module gradeModule;
  const IndexState({
    this.tabs = const ['推荐', '免费课程', '实战课程', '就业课'],
    this.selectedIndex = 0,
    this.gradeModule,
  });

  IndexState copyWith({
    List<String> tabs,
    int selectedIndex,
    Module gradeModule,
  }) {
    return IndexState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      tabs: tabs ?? this.tabs,
      gradeModule: gradeModule ?? this.gradeModule,
    );
  }

  @override
  List<Object> get props => [
        selectedIndex,
        tabs,
        gradeModule,
      ];
}
```

然后在index_page页面中，使用BlocProvider来为UI提供bloc、state和event。

BlocProvider代码


```dart
class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.indexBloc,
      child: BlocBuilder<IndexBloc, IndexState>(
        builder: (context, state) {
          return DefaultTabController(
```

state绑定代码


```dart
return DefaultTabController(
            length: state.tabs.length,
            child: Scaffold(
```

event发送代码


```dart
child: TabBar(
  onTap: (int index) {
    context
        .read<IndexBloc>()
        .add(IndexEventSelectedIndexChanged(index));
  },
```





1.2  tab按钮逻辑

UI布局外层包裹DefaultTabController

```
class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.indexBloc,
      child: BlocBuilder<IndexBloc, IndexState>(
        builder: (context, state) {
          return DefaultTabController(
```

1.3 list转换api

在使用tab按钮时候，需要给DefaultTabController的tabs属性传入widget数组，代码是通过list<String>进行转换传入


```dart
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
```


#### 2. 子页面：推荐页recommend_page

页面实现逻辑和index_page的实现方式一样，首先实现bloc类、event类、state类，然后在recommend_page页面代码中，对bloc相关的类进行绑定和回调

bloc类


```dart
class RecommendBloc extends Bloc<RecommendEvent, RecommendState> {
  RecommendBloc() : super(RecommendState());

  @override
  Stream<RecommendState> mapEventToState(
    RecommendEvent event,
  ) async* {
    if (event is RecommendEventLoadData) {
      yield* _mapLoadDataToState(event, state);
    }
  }

  Stream<RecommendState> _mapLoadDataToState(
    RecommendEvent event,
    RecommendState state,
  ) async* {
    // 获取 banner 数据
    List list = await CNWIndexNetManager.bannerList();
    List<AdBanner> banners =
        List<Map>.from(list).map((e) => AdBanner.fromJson(e)).toList();

    // 获取 modules 列表数据
    list = await CNWIndexNetManager.moduleList();
    List<Module> modules =
        List<Map>.from(list).map((e) => Module.fromJson(e)).toList();

    List<Module> newModules = [];

    // 获取具体的 module 的数据 （component）
    await Future.forEach(modules, (Module module) async {
      // 执行具体的请求
      List data =
          await CNWIndexNetManager.componentList(module.id, module.type);
      switch (RecommendType.values[module.type]) {
        case RecommendType.lecturer:
          {
            newModules.add(module.copyWith(
              components: data.map((e) => Lecturer.fromJson(e)).toList(),
            ));
          }
          break;
        case RecommendType.course:
          {
            newModules.add(module.copyWith(
              components: data.map((e) => Course.fromJson(e)).toList(),
            ));
          }
          break;
        case RecommendType.grade:
          {
            newModules.add(module.copyWith(
              components: data.map((e) => Grade.fromJson(e)).toList(),
            ));
          }
          break;
        default:
      }
    });

    yield state.copyWith(
      banners: banners,
      modules: newModules,
    );
  }
}

```

state类


```dart
class RecommendState extends Equatable {
  final List<Module> modules;
  final List<AdBanner> banners;
  const RecommendState({
    this.modules = const [],
    this.banners = const [],
  }) : super();

  RecommendState copyWith({
    List<Module> modules,
    List<AdBanner> banners,
  }) {
    return RecommendState(
      modules: modules ?? this.modules,
      banners: banners ?? this.banners,
    );
  }

  @override
  List<Object> get props => [modules, banners];
}

```

event类


```dart
abstract class RecommendEvent extends Equatable {
  const RecommendEvent();

  @override
  List<Object> get props => [];
}

class RecommendEventLoadData extends RecommendEvent {
  const RecommendEventLoadData();
}
```

UI类


```dart
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

```


#### 3. 子页面：课程页course_page

这个页面就不展开讲解了，具体可以具体代码

#### 4. 子页面：实战页grade_page

这个页面就不展开讲解了，具体可以具体代码