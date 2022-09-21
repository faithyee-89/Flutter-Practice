import 'package:cainiaowo/common/application.dart';
import 'package:cainiaowo/common/constant.dart';
import 'package:cainiaowo/common/icons.dart';
import 'package:cainiaowo/common/values/index.dart';
import 'package:cainiaowo/models/lesson.dart';
import 'package:cainiaowo/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef LessonOnTap = void Function(Lesson lesson, bool hasAuthority);

class LessonItem extends StatelessWidget {
  final Lesson lesson;
  final LessonOnTap? onTap;
  final bool hasAuthority;
  final int courseId;

  const LessonItem(
      {Key? key,
      required this.lesson,
      this.onTap,
      this.hasAuthority = false,
      required this.courseId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _lessionItem(context);
  }

  Widget _lessionItem(BuildContext context) {
    List<Widget> children = [
      Icon(
        CNWFonts.play,
        size: 15,
        color: AppColors.black,
      ),
      Expanded(
          child: Padding(
        padding: const EdgeInsets.only(left: PAGE_PADDING, right: PAGE_PADDING),
        child: Text(lesson.name ?? '',
            style: TextStyle(
              fontSize: AppFontSize.normalSp,
              color: lesson.state == 1 ? AppColors.black : AppColors.gray,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
            )),
      ))
    ];

    if (lesson.isFree == 1) {
      children.add(_freeLabel());
    }

    return InkWell(
      onTap: () {
        if (onTap != null) {
          bool lessonAuthority = lesson.isFree == 1 ? true : hasAuthority;
          onTap!(lesson, lessonAuthority);
          return;
        }

        if (lesson.state != 1) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('该课时还未发布，请耐心等待')));
          return;
        }

        if (lesson.isFree == 1 || hasAuthority) {
          Application.router.navigateTo(context,
              '${Routes.lessonPlay}?courseId=$courseId&lessonKey=${lesson.key}');

          return;
        }

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('您没有该课程的学习权限，请先购买')));
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              ),
            ),
            Divider(
              indent: 25,
              endIndent: 14,
              height: 1,
              thickness: 1,
              color: AppColors.greyLight,
            ),
          ],
        ),
      ),
    );
  }

  Widget _freeLabel() {
    return Container(
      width: 100.w,
      height: 40.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: AppColors.backgroundColor),
      child: Text(
        "免费",
        style: TextStyle(
            fontSize: AppFontSize.smallSp, color: AppColors.primaryColor),
      ),
    );
  }
}
