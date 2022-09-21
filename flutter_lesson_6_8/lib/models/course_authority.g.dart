// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_authority.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseAuthority _$CourseAuthorityFromJson(Map<String, dynamic> json) =>
    CourseAuthority(
      getMethod: json['get_method'] as int?,
      cancelTime: json['cancel_time'] == null
          ? null
          : DateTime.parse(json['cancel_time'] as String),
      days: json['days'] as int?,
      isTrue: json['is_true'] as int?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$CourseAuthorityToJson(CourseAuthority instance) =>
    <String, dynamic>{
      'get_method': instance.getMethod,
      'cancel_time': instance.cancelTime?.toIso8601String(),
      'days': instance.days,
      'is_true': instance.isTrue,
      'type': instance.type,
    };
