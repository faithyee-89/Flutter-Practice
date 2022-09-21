// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chapter _$ChapterFromJson(Map<String, dynamic> json) => Chapter(
      beginTime: (json['begin_time'] == null || json['begin_time'] == "")
          ? null
          : DateTime.parse(json['begin_time'] as String),
      brief: json['brief'] as String?,
      coverUrl: json['cover_url'] as String?,
      createdTime: json['created_time'] == null
          ? null
          : DateTime.parse(json['created_time'] as String),
      endTime: (json['end_time'] == null || json['end_time'] == "")
          ? null
          : DateTime.parse(json['end_time'] as String),
      id: json['id'] as int?,
      isOpen: json['is_open'] as int?,
      lessons: (json['lessons'] as List<dynamic>?)
          ?.map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      rank: json['rank'] as int?,
      teacher: json['teacher'] == null
          ? null
          : Teacher.fromJson(json['teacher'] as Map<String, dynamic>),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ChapterToJson(Chapter instance) => <String, dynamic>{
      'begin_time': instance.beginTime?.toIso8601String(),
      'brief': instance.brief,
      'cover_url': instance.coverUrl,
      'created_time': instance.createdTime?.toIso8601String(),
      'end_time': instance.endTime?.toIso8601String(),
      'id': instance.id,
      'is_open': instance.isOpen,
      'lessons': instance.lessons,
      'rank': instance.rank,
      'teacher': instance.teacher,
      'title': instance.title,
    };
