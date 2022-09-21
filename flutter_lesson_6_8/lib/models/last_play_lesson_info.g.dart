// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_play_lesson_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LastPlayLessonInfo _$LastPlayLessonInfoFromJson(Map<String, dynamic> json) =>
    LastPlayLessonInfo(
      has: json['has'] as bool?,
      isFinished: json['is_finished'] as bool?,
      lessonId: json['lesson_id'] as int?,
      lessonKey: json['lesson_key'] as String?,
      position: json['position'] as int?,
    );

Map<String, dynamic> _$LastPlayLessonInfoToJson(LastPlayLessonInfo instance) =>
    <String, dynamic>{
      'has': instance.has,
      'is_finished': instance.isFinished,
      'lesson_id': instance.lessonId,
      'lesson_key': instance.lessonKey,
      'position': instance.position,
    };
