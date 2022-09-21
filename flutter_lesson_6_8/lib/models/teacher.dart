import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import "course.dart";
part 'teacher.g.dart';

@JsonSerializable()
class Teacher extends Equatable {
    const Teacher({
              this.brief,
        this.company,
        this.courses,
        this.id,
        this.isFollow,
        this.jobTitle,
        this.logoUrl,
        this.students,
        this.teacherName,
        this.teacherCourse,

    });
  final String? brief;

  final String? company;

  final int? courses;

  final int? id;

  @JsonKey(name: "is_follow")
  final int? isFollow;

  @JsonKey(name: "job_title")
  final String? jobTitle;

  @JsonKey(name: "logo_url")
  final String? logoUrl;

  final int? students;

  @JsonKey(name: "teacher_name")
  final String? teacherName;

  @JsonKey(name: "teacher_course")
  final List<Course>? teacherCourse;

  
  factory Teacher.fromJson(Map<String,dynamic> json) => _$TeacherFromJson(json);
  Map<String, dynamic> toJson() => _$TeacherToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
                brief ?? "",
        company ?? "",
        courses ?? "",
        id ?? "",
        isFollow ?? "",
        jobTitle ?? "",
        logoUrl ?? "",
        students ?? "",
        teacherName ?? "",
        teacherCourse ?? "",

    ];

  Teacher copyWith({
              String? brief,
        String? company,
        int? courses,
        int? id,
        int? isFollow,
        String? jobTitle,
        String? logoUrl,
        int? students,
        String? teacherName,
        List<Course>? teacherCourse,

    }){

     return Teacher(
               brief: brief ?? this.brief,
        company: company ?? this.company,
        courses: courses ?? this.courses,
        id: id ?? this.id,
        isFollow: isFollow ?? this.isFollow,
        jobTitle: jobTitle ?? this.jobTitle,
        logoUrl: logoUrl ?? this.logoUrl,
        students: students ?? this.students,
        teacherName: teacherName ?? this.teacherName,
        teacherCourse: teacherCourse ?? this.teacherCourse,

     );
  }
}