// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      comment: json['comment'] as String?,
      createdTime: json['created_time'] == null
          ? null
          : DateTime.parse(json['created_time'] as String),
      id: json['id'] as int?,
      isEssence: json['is_essence'] as int?,
      replys: (json['replys'] as List<dynamic>?)
          ?.map((e) => Reply.fromJson(e as Map<String, dynamic>))
          .toList(),
      resId: json['res_id'] as int?,
      resType: json['res_type'] as int?,
      score: json['score'] as int?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'comment': instance.comment,
      'created_time': instance.createdTime?.toIso8601String(),
      'id': instance.id,
      'is_essence': instance.isEssence,
      'replys': instance.replys,
      'res_id': instance.resId,
      'res_type': instance.resType,
      'score': instance.score,
      'user': instance.user,
    };
