import 'package:flutter_lesson_6_6/business/common/utils_string.dart';
import 'package:flutter_lesson_6_6/business/index/models/grade.dart';
import 'package:flutter_lesson_6_6/business/index/models/grade_course.dart';
import 'package:flutter/material.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({Key? key, required this.grades}) : super(key: key);

  final List<dynamic> grades;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SliverPadding(
        padding: const EdgeInsets.all(13),
        sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                Grade grade = grades[index];
                GradeCourse? gradeCourse = grade.course;
                return Container(
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          UtilsString.fixedHttpStart(gradeCourse?.imgUrl ?? ''),
                        ),
                      )),
                );
              },
              childCount: grades.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 13,
              crossAxisSpacing: 13,
              childAspectRatio: 160 / 90,
            )),
      ),
    );
  }
}
