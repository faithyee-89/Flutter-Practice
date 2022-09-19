import 'package:cainiaowo/business/study_center/bloc/studycenter_bloc.dart';
import 'package:cainiaowo/business/study_center/models/course.dart';
import 'package:cainiaowo/business/study_center/view/study_coursecell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudyCourseList extends StatefulWidget {
  StudyCourseList({
    Key key,
    this.type = StudyCourseCellType.progressOnly,
    this.courses = const [],
  }) : super(key: key);

  final StudyCourseCellType type;
  final List<Course> courses;

  @override
  _StudyCourseListState createState() => _StudyCourseListState();
}

class _StudyCourseListState extends State<StudyCourseList> {
  Map<String, int> params = {'page': 1, 'size': 20};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: EasyRefresh(
        header: BallPulseHeader(),
        footer: BallPulseFooter(),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return StudyCourseCell(
              type: widget.type,
              course: widget.courses[index],
            );
          },
          itemCount: widget.courses.length,
          itemExtent: 120,
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

  Future<void> _loadData(Map params) async {
    context.read<StudycenterBloc>().add(
        widget.type == StudyCourseCellType.progressOnly
            ? StudycenterEventLoadStudiedCourses(params: params)
            : StudycenterEventLoadBoughtCourses(params: params));

    await Future.delayed(Duration(seconds: 2));
  }
}
