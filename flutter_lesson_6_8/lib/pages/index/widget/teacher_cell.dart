import 'package:cainiaowo/common/values/index.dart';
import 'package:cainiaowo/models/teacher.dart';
import 'package:cainiaowo/utils/utils_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/course/course_item.dart';

class TeacherCellWidget extends StatelessWidget {
  const TeacherCellWidget({Key? key, required this.teacher}) : super(key: key);

  final Teacher teacher;

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

    children.addAll(teacher.teacherCourse
            ?.map((e) => Flexible(
                    child: SizedBox(
                  height: 180.h,
                  child: CourseItem(
                    course: e,
                  ),
                )))
            .toList() ??
        []);

    return children;
  }

  Widget _headerCell() {
    return Padding(
      padding: const EdgeInsets.only(left: 13, bottom: 15, top: 15),
      child: Column(
        children: [
          ClipOval(
            child: Container(
              color: AppColors.greyLight,
              child: Image.network(
                UtilsString.fixedHttpStart(teacher.logoUrl ?? ""),
                width: 120.w,
                height: 120.h,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Text(
              teacher.teacherName ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: AppFontSize.normalSp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
