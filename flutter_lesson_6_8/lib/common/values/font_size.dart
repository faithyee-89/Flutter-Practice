import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFontSize {
  // 超大，一般用于正标题
  static const double extraLarge = 100;

  // 大，一般用于主标题
  static const double large = 80;

  static double largeSp = ScreenUtil().setSp(large);

// 大，一般用于小标题
  static const double medium = 50;

  static double mediumSp = ScreenUtil().setSp(medium);

  static const double normal = 40;
  static double normalSp = ScreenUtil().setSp(normal);

  static const double small = 30;

  static double smallSp = ScreenUtil().setSp(small);

  static const double extraSmall = 20;

  static double extraSmallSp = ScreenUtil().setSp(extraSmall);
}
