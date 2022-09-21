import 'package:cainiaowo/common/application.dart';
import 'package:cainiaowo/common/values/index.dart';
import 'package:cainiaowo/models/course.dart';
import 'package:cainiaowo/models/studied_course.dart';
import 'package:cainiaowo/router/routes.dart';
import 'package:cainiaowo/widgets/course/course_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum StudyCourseItemType {
  progressOnly,
  fullInfo,
}

class StudyCourseItem extends StatefulWidget {
  StudyCourseItem({
    Key? key,
    this.type = StudyCourseItemType.progressOnly,
    required this.course,
  }) : super(key: key);

  final StudyCourseItemType type;
  final StudiedCourse course;

  @override
  _StudyCourseItemState createState() => _StudyCourseItemState();
}

class _StudyCourseItemState extends State<StudyCourseItem> {
  StudiedCourse get course => widget.course;

  @override
  Widget build(BuildContext context) {
    String? imageUrl =
        course.courseType == 3 ? course.imgUrl : course.course?.imgUrl;

    Course courseTemp =
        Course(name: course.name ?? "", imgUrl: imageUrl, id: course.id);
    return CourseItem(
      course: courseTemp,
      rightChild: _rightWidget(),
      onTap: (course) {
        Application.router
            .navigateTo(context, '${Routes.lessonPlay}?courseId=${course.id}');
      },
    );
  }

  Widget _rightWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SizedBox(
          height: 180.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.name ?? course.course?.name ?? "",
                maxLines: 1,
                style: TextStyle(
                  fontSize: AppFontSize.normalSp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              widget.type == StudyCourseItemType.progressOnly
                  ? _progressOnlySubLabel(course.progress ?? 0)
                  : _fullInfoSubLabel(course.progress ?? 0,
                      course.commentCount ?? 0, course.lessonsPlayedTime ?? 0)
            ],
          )),
    );
  }

  Widget _progressOnlySubLabel(double progress) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 2,
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.lineColor,
              valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: (progress * 100).toInt(),
                child: Container(),
              ),
              Container(
                height: 20,
                width: 60,
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                  color: AppColors.primaryColor, // 底色
                  borderRadius: new BorderRadius.circular((10.0)), // 圆角度
                ),
                child: Text(
                  '${(progress * 100).toInt()}%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
              Expanded(
                flex: (100 - progress * 100).toInt(),
                child: Container(),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _fullInfoSubLabel(double progress, int qustion, int studyTime) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "进度：${progress.toString()}%",
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF999999),
            ),
          ),
          Text(
            "提问：${qustion.toString()}",
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF999999),
            ),
          ),
          Text(
            "学习：${studyTime.toString()} m",
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF999999),
            ),
          )
        ],
      ),
    );
  }
}
