import 'package:cainiaowo/models/teacher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vant_kit/main.dart';

import 'teacher_cell.dart';

class TeacherSwiper extends StatelessWidget {
  const TeacherSwiper({Key? key, required this.teachers}) : super(key: key);

  final List<Teacher> teachers;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cellWidth = screenWidth * 4 / 5;
    double leftOffsetWidth = screenWidth / 5 / 2;

    return Container(
      width: screenWidth,
      height: 750.h,
      child: Swipe(
        autoPlay: true,
        children: _swipeItem(cellWidth, leftOffsetWidth),
      ),
    );
  }

  List<Widget> _swipeItem(double cellWidth, double leftOffsetWidth) {
    return teachers.map((teacher) {
      return Container(
        width: cellWidth,
        padding: const EdgeInsets.only(bottom: 30),
        child: TeacherCellWidget(
          teacher: teacher,
        ),
      );
    }).toList();
  }

  // @override
  // Widget build(BuildContext context) {
  //   double screenWidth = MediaQuery.of(context).size.width;
  //   double cellWidth = screenWidth * 4 / 5;
  //   double leftOffsetWidth = screenWidth / 5 / 2;
  //   return Container(
  //     width: screenWidth,
  //     height: 410,
  //     child: Swiper(
  //       itemCount: teachers.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         return Container(
  //           padding: const EdgeInsets.only(bottom: 30),
  //           child: TeacherCellWidget(
  //             teacher: teachers[index],
  //           ),
  //         );
  //       },
  //       autoplay: true,
  //       pagination: SwiperPagination(
  //         builder: DotSwiperPaginationBuilder(
  //           size: 7,
  //           activeSize: 7,
  //           color: Color(0xFF999999),
  //           activeColor: Color(0xFFFC9900),
  //         ),
  //       ),
  //       layout: SwiperLayout.CUSTOM,
  //       itemWidth: cellWidth,
  //       customLayoutOption: CustomLayoutOption(
  //         startIndex: -2,
  //         stateCount: 5,
  //       ).addTranslate([
  //         Offset(-(leftOffsetWidth + cellWidth * 2), 0),
  //         Offset(-(leftOffsetWidth + cellWidth), 0),
  //         Offset(-leftOffsetWidth, 0),
  //         Offset(cellWidth - leftOffsetWidth, 0),
  //         Offset(cellWidth * 2 - leftOffsetWidth, 0),
  //       ]),
  //     ),
  //   );
  // }
}
