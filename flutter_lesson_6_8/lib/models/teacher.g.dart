// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teacher _$TeacherFromJson(Map<String, dynamic> json) => Teacher(
      brief: json['brief'] as String?,
      company: json['company'] as String?,
      courses: json['courses'] as int?,
      id: json['id'] as int?,
      isFollow: json['is_follow'] as int?,
      jobTitle: json['job_title'] as String?,
      logoUrl: json['logo_url'] as String?,
      students: json['students'] as int?,
      teacherName: json['teacher_name'] as String?,
      teacherCourse: (json['teacher_course'] as List<dynamic>?)
          ?.map((e) => Course.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TeacherToJson(Teacher instance) => <String, dynamic>{
      'brief': instance.brief,
      'company': instance.company,
      'courses': instance.courses,
      'id': instance.id,
      'is_follow': instance.isFollow,
      'job_title': instance.jobTitle,
      'logo_url': instance.logoUrl,
      'students': instance.students,
      'teacher_name': instance.teacherName,
      'teacher_course': instance.teacherCourse,
    };
