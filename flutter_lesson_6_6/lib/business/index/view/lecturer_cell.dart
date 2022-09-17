import 'package:flutter_lesson_6_6/business/common/utils_string.dart';
import 'package:flutter_lesson_6_6/business/index/models/course.dart';
import 'package:flutter_lesson_6_6/business/index/models/lecturer.dart';
import 'package:flutter_lesson_6_6/business/index/view/course_cell.dart';
import 'package:flutter/material.dart';

class LecturerCell extends StatelessWidget {
  const LecturerCell({Key? key, required this.lecturer}) : super(key: key);

  final Lecturer lecturer;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _children(),
      ),
    );
  }

  List<Widget> _children() {
    List<Widget> children = [];
    children.add(_headerCell());

    children.addAll(lecturer.teacherCourse
        !.map((e) => Flexible(
                child: CourseCell(
              course: Course.fromJson(e!.toJson()),
            )))
        .toList());

    return children;
  }

  Widget _headerCell() {
    return Padding(
      padding: const EdgeInsets.only(left: 13),
      child: Column(
        children: [
          ClipOval(
            child: Container(
              color: Color(0x33999999),
              child: Image.network(
                UtilsString.fixedHttpStart(lecturer.logoUrl ?? ""),
                width: 80,
                height: 80,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Text(
              lecturer.teacherName ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              lecturer.company ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF999999),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
