import 'package:cainiaowo/business/common/utils_string.dart';
import 'package:cainiaowo/business/study_center/models/course.dart';
import 'package:flutter/material.dart';

enum StudyCourseCellType {
  progressOnly,
  fullInfo,
}

class StudyCourseCell extends StatefulWidget {
  StudyCourseCell({
    Key key,
    this.type = StudyCourseCellType.progressOnly,
    this.course,
  }) : super(key: key);

  final StudyCourseCellType type;
  final Course course;

  @override
  _StudyCourseCellState createState() => _StudyCourseCellState();
}

class _StudyCourseCellState extends State<StudyCourseCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Row(
        children: [
          Container(
            width: 150,
            height: 100,
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(UtilsString.fixedHttpStart(widget.course.imgUrl) ?? ''),
                )),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 7, top: 10, bottom: 10, right: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.course.name ?? '',
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  widget.type == StudyCourseCellType.progressOnly
                      ? _progressOnlySubLabel(widget.course.progress??0)
                      : _fullInfoSubLabel(widget.course.progress??0, widget.course.commentCount??0, widget.course.lessonsPlayedTime??0),
                ],
              ),
            ),
          ),
        ],
      ),
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
              backgroundColor: Color(0x88999999),
              valueColor: AlwaysStoppedAnimation(Color(0xFFFC9900)),
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
                  color: Color(0xFFFC9900), // 底色
                  borderRadius: new BorderRadius.circular((10.0)), // 圆角度
                ),
                child: Text(
                  '${(progress*100).toInt()}%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
              Expanded(
                flex: (100-progress*100).toInt(),
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
