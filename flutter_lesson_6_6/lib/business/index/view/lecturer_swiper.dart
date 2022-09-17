import 'package:flutter_lesson_6_6/business/index/models/lecturer.dart';
import 'package:flutter_lesson_6_6/business/index/view/lecturer_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class LecturerSwiper extends StatelessWidget {
  const LecturerSwiper({Key? key, required this.lecturers}) : super(key: key);

  final List<dynamic> lecturers;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cellWidth = screenWidth * 4 / 5;
    double leftOffsetWidth = screenWidth / 5 / 2;
    return Container(
      width: screenWidth,
      height: 410,
      child: Swiper(
        itemCount: lecturers.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.only(bottom: 30),
            child: LecturerCell(
              lecturer: lecturers[index],
            ),
          );
        },
        autoplay: true,
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            size: 7,
            activeSize: 7,
            color: Color(0xFF999999),
            activeColor: Color(0xFFFC9900),
          ),
        ),
        layout: SwiperLayout.CUSTOM,
        itemWidth: cellWidth,
        customLayoutOption: CustomLayoutOption(
          startIndex: -2,
          stateCount: 5,
        ).addTranslate([
          Offset(-(leftOffsetWidth + cellWidth * 2), 0),
          Offset(-(leftOffsetWidth + cellWidth), 0),
          Offset(-leftOffsetWidth, 0),
          Offset(cellWidth - leftOffsetWidth, 0),
          Offset(cellWidth * 2 - leftOffsetWidth, 0),
        ]),
      ),
    );
  }
}
