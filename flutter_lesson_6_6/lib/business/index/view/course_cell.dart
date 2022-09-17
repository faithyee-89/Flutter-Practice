import 'package:flutter_lesson_6_6/business/common/utils_string.dart';
import 'package:flutter_lesson_6_6/business/index/models/course.dart';
import 'package:flutter/material.dart';

class CourseCell extends StatelessWidget {
  const CourseCell({Key? key, required this.course}) : super(key: key);

  final Course course;

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
                  image: NetworkImage(
                      UtilsString.fixedHttpStart(course.imgUrl) ?? ''),
                )),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 7, top: 10, bottom: 10, right: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      course.name ?? '',
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person_outline,
                          color: Color(0xFF999999),
                          size: 13,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "${course.lessonsPlayedTime}" +
                                (course.commentCount != null
                                    ? "  ${course.commentCount}人评价"
                                    : ''),
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF999999),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        course.nowPrice.toString() ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFFB2E06),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Text(
                          course.costPrice.toString() ?? '',
                          style: TextStyle(
                            color: const Color(0xFF999999),
                            decoration: TextDecoration.lineThrough,
                            decorationColor: const Color(0xFF999999),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      course.isShareCard == true
                          ? Container(
                              margin: const EdgeInsets.only(left: 7),
                              width: 50,
                              height: 20,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                color: Colors.black,
                                borderRadius: BorderRadius.circular((15.0)),
                              ),
                              child: Text(
                                '免费学',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFFC9900),
                                  fontSize: 13,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
