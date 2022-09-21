import 'dart:ui';

import 'package:cainiaowo/models/last_play_lesson_info.dart';
import 'package:cainiaowo/models/video_play_info.dart';
import 'package:cainiaowo/pages/common/bloc/course_bloc.dart';
import 'package:cainiaowo/common/values/index.dart';
import 'package:cainiaowo/models/course.dart';
import 'package:cainiaowo/models/tcplayer.dart';
import 'package:cainiaowo/widgets/course/course_item.dart';
import 'package:cainiaowo/widgets/course/lesson_list.dart';
import 'package:cainiaowo/widgets/video_player/video_play_options.dart';
import 'package:cainiaowo/widgets/video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vant_kit/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tx_super_player/cniao5_super_player.dart';

class LessonPlayPage extends StatefulWidget {
  LessonPlayPage({
    Key? key,
    required this.courseId,
    this.lessonKey,
  }) : super(key: key);

  final int courseId;
  final String? lessonKey;

  @override
  LessonPlayPageState createState() =>
      LessonPlayPageState(lessonKey: lessonKey);
}

class LessonPlayPageState extends State<LessonPlayPage>
    with WidgetsBindingObserver {
  LessonPlayPageState({this.lessonKey});

  String? lessonKey;

  late VideoPlayerController _controller;

  get courseId => widget.courseId;
  get isCourse => widget.courseId.toString().length == 5;

  String? fileId;

  Course? course;

  CourseBloc courseBloc = CourseBloc();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addObserver(this);

    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    _controller = VideoPlayerController();
    _controller.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    _controller.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
      case AppLifecycleState.inactive:
        _controller.pause();
        break;
      case AppLifecycleState.resumed: //从后台切换前台，界面可见
        _controller.resume();
        break;
      case AppLifecycleState.paused: // 界面不可见，后台
        _controller.pause();
        break;
      case AppLifecycleState.detached: // APP结束时调用
        _controller.dispose();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQueryData.fromWindow(window).padding.top),
        child: SafeArea(
          top: true,
          child: Offstage(),
        ),
      ),
      body: BlocProvider(
        create: (context) {
          if (this.isCourse)
            courseBloc.add(GetCourseDetailEvent(this.courseId));

          if (this.lessonKey != null) {
            courseBloc.add(GetPlayInfoEvent(this.lessonKey!));
          } else {
            courseBloc.add(GetCourseLastPlayInfoEvent(this.courseId));
          }

          return courseBloc;
        },
        child: BlocBuilder<CourseBloc, CourseState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              return _buildBody(context);
            }),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buidVideoPlayer(),
        this.isCourse ? _buidCourseDetail() : Container(),
        _sepLine(),
        Expanded(
          child: _lessonList(context),
        ),
      ],
    );
  }

  Widget _buidVideoPlayer() {
    return BlocListener<CourseBloc, CourseState>(
        listener: (context, state) {
          if (state.lastPlayInfo != null && this.lessonKey == null) {
            LastPlayLessonInfo lastPlayLessonInfo = state.lastPlayInfo!;

            if (lastPlayLessonInfo.has!) {
              this.lessonKey = lastPlayLessonInfo.lessonKey;
              courseBloc.add(GetPlayInfoEvent(this.lessonKey!));
            }
          }

          if (state.playInfo != null) {
            Tcplayer tcplayer = state.playInfo!.tcplayer!;

            if (fileId == null || fileId != tcplayer.fileId) {
              fileId = tcplayer.fileId;
              TencentVideoPlayModel tencentModel = TencentVideoPlayModel(
                  appId: tcplayer.appId!,
                  fileId: tcplayer.fileId!,
                  psign: tcplayer.psign);

              if (_controller.value.isPlaying) {
                _controller.stop();
              }
              _controller.playTencentVideo(tencentModel);
            }
          }
        },
        child: BlocSelector<CourseBloc, CourseState, VideoPlayInfo?>(
            selector: (state) => state.playInfo,
            builder: (context, playInfo) {
              if (playInfo == null)
                return Skeleton(
                  row: 8,
                );
              else {
                return Container(
                    height: 600.h,
                    color: Colors.black,
                    child: VideoPlayer(
                      controller: _controller,
                      options: VideoPlayOptions(),
                    ));
              }
            }));
  }

  Widget _buidCourseDetail() {
    return BlocSelector<CourseBloc, CourseState, Course?>(
      selector: (state) => state.courseDetail,
      builder: (context, courseDetail) {
        course = courseDetail;

        return Padding(
          padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
          child: SizedBox(
            height: 180.h,
            child: Skeleton(
                row: 2,
                loading: courseDetail == null ? true : false,
                child: CourseItem(
                    course: Course(
                        id: courseDetail?.id,
                        imgUrl: courseDetail?.imgUrl,
                        name: courseDetail?.name,
                        lessonsPlayedTime: courseDetail?.lessonsPlayedTime,
                        commentCount: courseDetail?.commentCount,
                        nowPrice: courseDetail?.nowPrice,
                        costPrice: courseDetail?.costPrice))),
          ),
        );
      },
    );
  }

  Widget _sepLine() {
    return const Divider(
      height: 20,
      thickness: 20,
      color: AppColors.greyLight,
    );
  }

  Widget _lessonList(BuildContext context) {
    return LessonList(
      courseId: courseId,
      hasAuthority: course?.hasAuthority ?? false,
      onLessonTap: (lesson, lessonAuthority) {
        if (!lessonAuthority) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('您没有该课程的学习权限，请先购买')));
          return;
        }
        _controller.stop();
        context.read<CourseBloc>().add(GetPlayInfoEvent(lesson.key!));
      },
    );
  }
}
