import 'package:cainiaowo/business/authentication/authentication.dart';
import 'package:cainiaowo/business/course/bloc/courselist_bloc.dart';
import 'package:cainiaowo/business/course/view/courselist_page.dart';
import 'package:cainiaowo/business/home/cubit/tab_cubit.dart';
import 'package:cainiaowo/business/index/view/index_page.dart';
import 'package:cainiaowo/business/profile/profile.dart';
import 'package:cainiaowo/business/study_center/view/studycenter_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final List<BottomNavigationBarItem> bottomNavItems = [
  BottomNavigationBarItem(
    backgroundColor: Colors.white,
    icon: Image.asset(
      "assets/home/index.png",
      width: 27,
      height: 27,
    ),
    activeIcon: Image.asset(
      "assets/home/index_selected.png",
      width: 27,
      height: 27,
    ),
    label: "优惠",
  ),
  BottomNavigationBarItem(
    backgroundColor: Colors.white,
    icon: Image.asset(
      "assets/home/course.png",
      width: 27,
      height: 27,
    ),
    activeIcon: Image.asset(
      "assets/home/course_selected.png",
      width: 27,
      height: 27,
    ),
    label: "课程",
  ),
  BottomNavigationBarItem(
    backgroundColor: Colors.white,
    icon: Image.asset(
      "assets/home/college.png",
      width: 27,
      height: 27,
    ),
    activeIcon: Image.asset(
      "assets/home/college_selected.png",
      width: 27,
      height: 27,
    ),
    label: "学习中心",
  ),
  BottomNavigationBarItem(
    backgroundColor: Colors.white,
    icon: Image.asset(
      "assets/home/my.png",
      width: 27,
      height: 27,
    ),
    activeIcon: Image.asset(
      "assets/home/my_selected.png",
      width: 27,
      height: 27,
    ),
    label: "我的",
  ),
];

final pages = [
  IndexPage(),
  CourseListPage(),
  StudyCenterPage(),
  ProfilePage(),
];

PageController _pageController = PageController();

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TabCubit(),
      child: Scaffold(
        // appBar: AppBar(title: const Text('Home')),
        bottomNavigationBar:
            BlocBuilder<TabCubit, int>(builder: (context, state) {
          return CupertinoTabBar(
            items: bottomNavItems,
            currentIndex: state,
            activeColor: Color(0xffFC9900),
            inactiveColor: Color(0xff606266),
            onTap: (index) => _onTabChanged(context, index),
          );
        }),
        body: PageView(
          children: pages,
          controller: _pageController,
        ),
        // BlocBuilder<TabCubit, int>(builder: (context, state) {
        //   return pages[state];
        // }),
      ),
    );
  }

  void _onTabChanged(BuildContext context, int index) {
    context.read<TabCubit>().update(index);
    _pageController.jumpToPage(index);
  }
}
