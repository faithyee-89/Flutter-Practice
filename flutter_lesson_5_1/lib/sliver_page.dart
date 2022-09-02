import 'package:flutter/material.dart';

class SliverPage extends StatefulWidget {
  const SliverPage({Key? key}) : super(key: key);

  @override
  State<SliverPage> createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage>
    with SingleTickerProviderStateMixin {
  final List _tabs = <String>['tab 1', 'tab 2', 'tab 3'];
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
