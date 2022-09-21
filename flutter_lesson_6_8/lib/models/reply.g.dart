// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reply _$ReplyFromJson(Map<String, dynamic> json) => Reply(
      createdTime: json['created_time'] == null
          ? null
          : DateTime.parse(json['created_time'] as String),
      id: json['id'] as int?,
      replyMsg: json['reply_msg'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReplyToJson(Reply instance) => <String, dynamic>{
      'created_time': instance.createdTime?.toIso8601String(),
      'id': instance.id,
      'reply_msg': instance.replyMsg,
      'user': instance.user,
    };
