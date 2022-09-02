> ### 本节课⽬标
> - 掌握sliver组件使⽤

#### 什么是SliverAppBar
SliverAppBar类似于Android中的CollapsingToolbarLayout，可以轻松实现⻚⾯头部展开、合并的效果。与AppBar⼤部分的属性重合，相当于AppBar的加强版 ，⽤
来实现各种复杂的滚动效果,它的slivers属性⾥可以放置各种sliver组件。

#### 常⽤属性


```
const SliverAppBar({
 Key key,
 this.leading,//左侧的图标或文字，多为返回箭头
 this.automaticallyImplyLeading = true,//没有leading为true的时候，
默认返回箭头，没有leading且为false，则显示title
 this.title,//标题
 this.actions,//标题右侧的操作
 this.flexibleSpace,//可以理解为SliverAppBar的背景内容区
 this.bottom,//SliverAppBar的底部区
 this.elevation,//阴影
 this.forceElevated = false,//是否显示阴影
 this.backgroundColor,//背景颜色
 this.brightness,//状态栏主题，默认Brightness.dark，可选参数light
 this.iconTheme,//SliverAppBar图标主题
 this.actionsIconTheme,//action图标主题
 this.textTheme,//文字主题
 this.primary = true,//是否显示在状态栏的下面,false就会占领状态栏的高度
 this.centerTitle,//标题是否居中显示
 this.titleSpacing = NavigationToolbar.kMiddleSpacing,//标题横向间
距
 this.expandedHeight,//合并的高度，默认是状态栏的高度加AppBar的高度
 this.floating = false,//滑动时是否悬浮
 this.pinned = false,//标题栏是否固定
 this.snap = false,//配合floating使用
 })
```

#### 实现效果

![Untitled](https://note.youdao.com/yws/public/resource/b87fc7473b263bbeecc00ebeaa158670/2391F2003E334D62A0FB1EBC7F0ED7F4?ynotemdtimestamp=1662130057537)

#### 代码示例

```
import 'package:flutter/material.dart';

class SliverPage extends StatefulWidget {
  const SliverPage({Key? key}) : super(key: key);

  @override
  State<SliverPage> createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage>
    with SingleTickerProviderStateMixin {
  List _tabs = <String>['tab 1', 'tab 2', 'tab 3'];
  TabController? _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        body: TabBarView(
          controller: _tabController,
          children: List.generate(
              _tabs.length,
              (index) => Center(
                    child: Text(index.toString()),
                  )),
        ),
        headerSliverBuilder: (BuildContext, bool) {
          return [
            _appbar(),
          ];
        },
      ),
    );
  }

  Widget _appbar() {
    return SliverAppBar(
      bottom: TabBar(
        controller: _tabController,
        tabs: _tabs
            .map((e) => Tab(
                  text: e,
                ))
            .toList(),
      ),
      leading: Icon(Icons.home),
      expandedHeight: 230,
      floating: false,
      pinned: true,
      snap: false,
      flexibleSpace: FlexibleSpaceBar(
        // title: Text('sliver'),
        // collapseMode: CollapseMode.pin,
        background: Image.asset(
          'image/header_image.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

```

![sliver](https://note.youdao.com/yws/public/resource/b87fc7473b263bbeecc00ebeaa158670/D6430A5855C043A6B3CA920ECB35B3D1?ynotemdtimestamp=1662130057537)

