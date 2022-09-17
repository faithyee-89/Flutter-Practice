import 'package:equatable/equatable.dart';

import 'teacher_course.dart';

class Lecturer extends Equatable {
  final String? brief;
  final String? company;
  final int? id;
  final String? jobTitle;
  final String? logoUrl;
  final List<TeacherCourse?>? teacherCourse;
  final String? teacherName;

  const Lecturer({
    this.brief,
    this.company,
    this.id,
    this.jobTitle,
    this.logoUrl,
    this.teacherCourse,
    this.teacherName,
  });

  factory Lecturer.fromJson(Map<String, dynamic> json) {
    return Lecturer(
      brief: json['brief'] as String,
      company: json['company'] as String,
      id: json['id'] as int,
      jobTitle: json['job_title'] as String,
      logoUrl: json['logo_url'] as String,
      teacherCourse: (json['teacher_course'] as List<dynamic>)
          ?.map((e) => e == null
              ? null
              : TeacherCourse.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      teacherName: json['teacher_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brief': brief,
      'company': company,
      'id': id,
      'job_title': jobTitle,
      'logo_url': logoUrl,
      'teacher_course': teacherCourse?.map((e) => e?.toJson())?.toList(),
      'teacher_name': teacherName,
    };
  }

  Lecturer copyWith({
    String? brief,
    String? company,
    int? id,
    String? jobTitle,
    String? logoUrl,
    List<TeacherCourse>? teacherCourse,
    String? teacherName,
  }) {
    return Lecturer(
      brief: brief ?? this.brief,
      company: company ?? this.company,
      id: id ?? this.id,
      jobTitle: jobTitle ?? this.jobTitle,
      logoUrl: logoUrl ?? this.logoUrl,
      teacherCourse: teacherCourse ?? this.teacherCourse,
      teacherName: teacherName ?? this.teacherName,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      brief!,
      company!,
      id!,
      jobTitle!,
      logoUrl!,
      teacherCourse!,
      teacherName!,
    ];
  }
}
