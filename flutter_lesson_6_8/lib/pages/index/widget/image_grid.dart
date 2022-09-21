import 'package:cached_network_image/cached_network_image.dart';
import 'package:cainiaowo/models/course.dart';
import 'package:cainiaowo/utils/utils_string.dart';
import 'package:cainiaowo/models/grade.dart';
import 'package:cainiaowo/common/application.dart';
import 'package:cainiaowo/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({Key? key, required this.grades}) : super(key: key);

  final List<Grade> grades;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SliverPadding(
        padding: const EdgeInsets.all(10),
        sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                Grade grade = grades[index];
                Course? gradeCourse = grade.course;
                return Container(
                  width: 300.w,
                  child: InkWell(
                    onTap: () {
                      Application.navigateTo(context, Routes.webViewPage,
                          params: {"url": gradeCourse?.h5site});
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.w),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: UtilsString.fixedHttpStart(
                            gradeCourse?.imgUrl ?? ""),
                      ),
                    ),
                  ),
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
