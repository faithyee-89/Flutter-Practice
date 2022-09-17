import 'package:flutter_lesson_6_6/business/index/course/bloc/course_bloc.dart';
import 'package:flutter_lesson_6_6/business/index/view/course_list.dart';
import 'package:flutter_lesson_6_6/common/view/sep_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({Key? key, this.params, required this.courseBloc})
      : super(key: key);

  final CourseBloc courseBloc;
  final Map? params;

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  void initState() {
    _loadData(widget.params);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.courseBloc,
      child: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          return EasyRefresh.custom(
            header: BallPulseHeader(),
            footer: BallPulseFooter(),
            slivers: [
              CourseList(courses: state.courses),
              SliverToBoxAdapter(
                child: state.noMore
                    ? SepDivider(
                        text: Text('人家也是有底线的',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF999999),
                            )),
                      )
                    : Container(),
              ),
            ],
            onRefresh: () async {
              widget.params!['page'] = 1;
              await _loadData(widget.params);
            },
            onLoad: () async {
              widget.params!['page'] = (widget.params!['page'] ?? 1) + 1;
              await _loadData(widget.params);
            },
          );
        },
      ),
    );
  }

  Future<void> _loadData(Map? params) async {
    widget.courseBloc.add(CourseEventLoadData(params: params));

    await Future.delayed(Duration(seconds: 2));
  }
}
