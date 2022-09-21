import 'package:cainiaowo/common/values/index.dart';
import 'package:cainiaowo/pages/index/course/bloc/course_bloc.dart';
import 'package:cainiaowo/common/view/sep_divider.dart';
import 'package:cainiaowo/widgets/course/course_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_vant_kit/main.dart';

class CoursePage extends StatefulWidget {
  CoursePage({Key? key, required this.params, required this.courseBloc})
      : super(key: key);

  final CourseBloc courseBloc;
  final Map params;

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _loadData(widget.params);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => widget.courseBloc,
      child: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          return Skeleton(
            row: 18,
            loading: state.isLoading,
            child: EasyRefresh.custom(
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
                                color: AppColors.gray,
                              )),
                        )
                      : Container(),
                ),
              ],
              onRefresh: () async {
                widget.params['page'] = 1;
                await _loadData(widget.params);
              },
              onLoad: () async {
                widget.params['page'] = (widget.params['page'] ?? 1) + 1;
                await _loadData(widget.params);
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _loadData(Map params) async {
    widget.courseBloc.add(GetDataEvent(params: params));

    await Future.delayed(Duration(seconds: 2));
  }
}
