import 'package:cainiaowo/models/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'course_item.dart';

class CourseList extends StatelessWidget {
  const CourseList(
      {Key? key, required this.courses, this.onTap, this.rightChild})
      : super(key: key);

  final List<Course> courses;

  final CourseItemOnTap? onTap;
  final Widget? rightChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return CourseItem(
              course: courses[index],
              onTap: onTap,
              rightChild: rightChild,
            );
          },
          childCount: courses.length,
        ),
        itemExtent: 210.h,
      ),
    );
  }
}
