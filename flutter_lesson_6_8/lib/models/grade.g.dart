// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Grade _$GradeFromJson(Map<String, dynamic> json) => Grade(
      applyDeadlineTime: json['apply_deadline_time'] == null
          ? null
          : DateTime.parse(json['apply_deadline_time'] as String),
      buttonDesc: json['button_desc'] as String?,
      course: json['course'] == null
          ? null
          : Course.fromJson(json['course'] as Map<String, dynamic>),
      createdTime: json['created_time'] == null
          ? null
          : DateTime.parse(json['created_time'] as String),
      currentPrice: (json['current_price'] as num?)?.toDouble(),
      id: json['id'] as int?,
      isApplyStop: json['is_apply_stop'] as int?,
      learningMode: json['learning_mode'] as int?,
      number: json['number'] as int?,
      originalPrice: (json['original_price'] as num?)?.toDouble(),
      startClassTime: json['start_class_time'] == null
          ? null
          : DateTime.parse(json['start_class_time'] as String),
      status: json['status'] as int?,
      studentCount: json['student_count'] as int?,
      studentLimit: json['student_limit'] as int?,
      studyExpiryDay: json['study_expiry_day'] as int?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$GradeToJson(Grade instance) => <String, dynamic>{
      'apply_deadline_time': instance.applyDeadlineTime?.toIso8601String(),
      'button_desc': instance.buttonDesc,
      'course': instance.course,
      'created_time': instance.createdTime?.toIso8601String(),
      'current_price': instance.currentPrice,
      'id': instance.id,
      'is_apply_stop': instance.isApplyStop,
      'learning_mode': instance.learningMode,
      'number': instance.number,
      'original_price': instance.originalPrice,
      'start_class_time': instance.startClassTime?.toIso8601String(),
      'status': instance.status,
      'student_count': instance.studentCount,
      'student_limit': instance.studentLimit,
      'study_expiry_day': instance.studyExpiryDay,
      'title': instance.title,
    };
