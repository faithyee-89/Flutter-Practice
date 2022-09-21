import 'package:cainiaowo/common/constant.dart';
import 'package:cainiaowo/models/chapter.dart';
import 'package:cainiaowo/models/lesson.dart';
import 'package:cainiaowo/pages/common/bloc/course_bloc.dart';

import 'package:cainiaowo/widgets/course/lesson_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vant_kit/main.dart';

typedef LessonOnTap = void Function(Lesson lesson, bool hasAuthority);

class LessonList extends StatelessWidget {
  const LessonList({
    Key? key,
    required this.courseId,
    required this.hasAuthority,
    this.onLessonTap,
  }) : super(key: key);

  final int courseId;
  final bool hasAuthority;
  final LessonOnTap? onLessonTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider(
      create: (context) {
        CourseBloc courseBloc = CourseBloc();
        courseBloc.add(GetLessonsEvent(courseId));
        return courseBloc;
      },
      child: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          List<Chapter>? chapters = state.chapters;
          return chapters == null
              ? Skeleton(
                  row: 5,
                  loading: chapters == null ? true : false,
                )
              : chapters.length <= 0
                  ? _empty()
                  : _buildChpaters(chapters);
        },
      ),
    ));
  }

  Widget _empty() {
    return Container(
      child: Text("暂时没有发布课时"),
    );
  }

  Widget _buildChpaters(List<Chapter> chapters) {
    return ListView.builder(
        itemCount: chapters.length,
        itemBuilder: (context, index) {
          return _buildChapterItem(chapters[index], chapters.length);
        });
  }

  Widget _buildChapterItem(Chapter? chapter, size) {
    List<LessonItem>? items = chapter?.lessons?.map((lesson) {
      return LessonItem(
        lesson: lesson,
        courseId: courseId,
        onTap: onLessonTap,
        hasAuthority: hasAuthority,
      );
    }).toList();

    List<Widget> children = [];

    if (size > 1) {
      String title = "第${chapter?.rank}章：${chapter?.title}";
      children.add(_buildChapterTitle(title));
    }

    if (items != null) {
      children.addAll(items);
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildChapterTitle(String? title) {
    return Padding(
      padding: const EdgeInsets.all(PAGE_PADDING),
      child: Text(title ?? "",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.none,
          )),
    );
  }
}
