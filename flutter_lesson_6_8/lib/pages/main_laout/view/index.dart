import 'package:cainiaowo/pages/course/view/index.dart';
import 'package:cainiaowo/pages/index/view/index.dart';
import 'package:cainiaowo/pages/main_laout/cubit/tab_cubit.dart';
import 'package:cainiaowo/pages/profile/profile.dart';
import 'package:cainiaowo/pages/study_center/view/index.dart';
import 'package:cainiaowo/common/values/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final List<BottomNavigationBarItem> bottomNavItems = [
  BottomNavigationBarItem(
    backgroundColor: Colors.white,
    icon: Image.asset(
      "assets/home/index.png",
      width: 70.w,
      height: 70.h,
    ),
    activeIcon: Image.asset(
      "assets/home/index_selected.png",
      width: 70.w,
      height: 70.h,
    ),
    label: "首页",
  ),
  BottomNavigationBarItem(
    backgroundColor: Colors.white,
    icon: Image.asset(
      "assets/home/course.png",
      width: 70.w,
      height: 70.h,
    ),
    activeIcon: Image.asset(
      "assets/home/course_selected.png",
      width: 70.w,
      height: 70.h,
    ),
    label: "课程",
  ),
  BottomNavigationBarItem(
    backgroundColor: Colors.white,
    icon: Image.asset(
      "assets/home/college.png",
      width: 70.w,
      height: 70.h,
    ),
    activeIcon: Image.asset(
      "assets/home/college_selected.png",
      width: 70.w,
      height: 70.h,
    ),
    label: "学习",
  ),
  BottomNavigationBarItem(
    backgroundColor: Colors.white,
    icon: Image.asset(
      "assets/home/my.png",
      width: 70.w,
      height: 70.h,
    ),
    activeIcon: Image.asset(
      "assets/home/my_selected.png",
      width: 70.w,
      height: 70.h,
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

class MainLayout extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MainLayout());
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
            activeColor: AppColors.primaryColor,
            inactiveColor: Color(0xff606266),
            onTap: (index) => _onTabChanged(context, index),
          );
        }),
        body: PageView(
          children: pages,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
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
