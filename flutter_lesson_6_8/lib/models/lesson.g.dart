// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lesson _$LessonFromJson(Map<String, dynamic> json) => Lesson(
      bsort: json['bsort'] as int?,
      id: json['id'] as int?,
      isFree: json['is_free'] as int?,
      isLive: json['is_live'] as int?,
      key: json['key'] as String?,
      livePlanBeginTime: json['live_plan_begin_time'] == null
          ? null
          : DateTime.parse(json['live_plan_begin_time'] as String),
      livePlanEndTime: json['live_plan_end_time'] == null
          ? null
          : DateTime.parse(json['live_plan_end_time'] as String),
      liveStatus: json['live_status'] as int?,
      name: json['name'] as String?,
      state: json['state'] as int?,
    );

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'bsort': instance.bsort,
      'id': instance.id,
      'is_free': instance.isFree,
      'is_live': instance.isLive,
      'key': instance.key,
      'live_plan_begin_time': instance.livePlanBeginTime?.toIso8601String(),
      'live_plan_end_time': instance.livePlanEndTime?.toIso8601String(),
      'live_status': instance.liveStatus,
      'name': instance.name,
      'state': instance.state,
    };
