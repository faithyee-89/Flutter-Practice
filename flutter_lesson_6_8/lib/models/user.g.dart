// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      isBindPhone: json['is_bind_phone'] as bool,
      logoUrl: json['logo_url'] as String?,
      username: json['username'] as String?,
      isTeacher: json['is_teacher'] as bool?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'is_bind_phone': instance.isBindPhone,
      'logo_url': instance.logoUrl,
      'username': instance.username,
      'is_teacher': instance.isTeacher,
    };

LoginInfo _$LoginInfoFromJson(Map<String, dynamic> json) => LoginInfo(
      User.fromJson(json['user'] as Map<String, dynamic>),
      json['token'] as String,
    );

Map<String, dynamic> _$LoginInfoToJson(LoginInfo instance) => <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
    };
