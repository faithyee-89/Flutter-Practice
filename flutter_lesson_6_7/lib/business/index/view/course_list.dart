import 'package:cainiaowo/business/index/models/course.dart';
import 'package:cainiaowo/business/index/view/course_cell.dart';
import 'package:flutter/material.dart';

class CourseList extends StatelessWidget {
  const CourseList({Key key, @required this.courses}) : super(key: key);

  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return CourseCell(
              course: courses[index],
            );
          },
          childCount: courses.length,
        ),
        itemExtent: 120,
      ),
    );
  }
}
