import 'package:cainiaowo/common/values/index.dart';
import 'package:cainiaowo/utils/utils_string.dart';
import 'package:cainiaowo/common/application.dart';
import 'package:cainiaowo/models/course.dart';
import 'package:cainiaowo/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef CourseItemOnTap = void Function(Course course);

class CourseItem extends StatelessWidget {
  const CourseItem(
      {Key? key, required this.course, this.onTap, this.rightChild})
      : super(key: key);

  final Course course;
  final CourseItemOnTap? onTap;
  final Widget? rightChild;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap?.call(course);
          return;
        }
        Application.router.navigateTo(
            context, '${Routes.courseDetail}?courseId=${course.id}');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: Row(
          children: [
            Container(
              width: 310.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.w),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      UtilsString.fixedHttpStart(course.imgUrl ?? '') ?? '',
                ),
              ),
            ),
            Expanded(
              child: rightChild ?? _buildRightWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 6, top: 5, bottom: 0, right: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            course.name ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 42.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Icon(
                  Icons.person_outline,
                  color: AppColors.gray,
                  size: 30.sp,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Text(
                    "${course.lessonsPlayedTime}" +
                        (course.commentCount != null
                            ? "  ${course.commentCount}人评价"
                            : ''),
                    style: TextStyle(
                      fontSize: 30.sp,
                      color: AppColors.gray,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: _coursePircesWidgets(),
          )
        ],
      ),
    );
  }

  List<Widget> _coursePircesWidgets() {
    List<Widget> widgets = [];

    if (course.isFree == 1) {
      widgets.add(Text(
        "免费",
        style: TextStyle(
          fontSize: 36.sp,
          fontWeight: FontWeight.w500,
          color: Colors.blueAccent,
        ),
      ));
    } else {
      widgets.add(Text(
        "￥${course.nowPrice ?? ''}",
        style: TextStyle(
          fontSize: 36.sp,
          fontWeight: FontWeight.w500,
          color: Color(0xFFFB2E06),
        ),
      ));
    }

    if (course.isShareCard ?? false) {
      widgets.add(Container(
        margin: const EdgeInsets.only(left: 7),
        width: 100.w,
        height: 40.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          color: Colors.black,
          borderRadius: BorderRadius.circular((50.w)),
        ),
        child: Text(
          '免费学',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFFC9900),
            fontSize: 24.sp,
          ),
        ),
      ));
    }

    return widgets;
  }
}
