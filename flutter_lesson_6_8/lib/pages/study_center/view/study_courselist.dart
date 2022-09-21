import 'package:cainiaowo/pages/study_center/bloc/studycenter_bloc.dart';
import 'package:cainiaowo/widgets/course/study_course_item.dart';
import 'package:cainiaowo/models/studied_course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vant_kit/main.dart';

class StudyCourseList extends StatefulWidget {
  StudyCourseList({
    Key? key,
    this.type = StudyCourseItemType.progressOnly,
    this.courses = const [],
  }) : super(key: key);

  final StudyCourseItemType type;
  final List<StudiedCourse> courses;

  @override
  _StudyCourseListState createState() => _StudyCourseListState();
}

class _StudyCourseListState extends State<StudyCourseList> {
  Map<String, dynamic> params = {'page': 1, 'size': 20};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.courses.isEmpty) {
      return Skeleton(
        row: 10,
      );
    }
    return Container(
      child: EasyRefresh(
        header: BallPulseHeader(),
        footer: BallPulseFooter(),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return StudyCourseItem(
              type: widget.type,
              course: widget.courses[index],
            );
          },
          itemCount: widget.courses.length,
          itemExtent: 220.h,
        ),
        onRefresh: () async {
          params['page'] = 1;
          await _loadData(params);
        },
        onLoad: () async {
          params['page'] = (params['page'] ?? 1) + 1;
          await _loadData(params);
        },
      ),
    );
  }

  Future<void> _loadData(Map<String, dynamic> params) async {
    context.read<StudycenterBloc>().add(
        widget.type == StudyCourseItemType.progressOnly
            ? GetStudiedCoursesEvent(params: params)
            : GetBoughtCoursesEvent(params: params));

    await Future.delayed(Duration(seconds: 2));
  }
}
