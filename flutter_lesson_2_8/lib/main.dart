import 'package:flutter/material.dart';
import 'package:flutter_lesson_2_8/wechat_login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'appo_login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //填入设计稿中设备的屏幕尺寸,单位dp
    return ScreenUtilInit(
      designSize: const Size(375, 667),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MaterialApp(
          home: child,
        );
      },
      child: const HomePage(),
    );
  }
}
