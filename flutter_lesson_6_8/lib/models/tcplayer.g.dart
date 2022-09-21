// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tcplayer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tcplayer _$TcplayerFromJson(Map<String, dynamic> json) => Tcplayer(
      appId: json['app_id'] as int?,
      fileId: json['file_id'] as String?,
      psign: json['psign'] as String?,
    );

Map<String, dynamic> _$TcplayerToJson(Tcplayer instance) => <String, dynamic>{
      'app_id': instance.appId,
      'file_id': instance.fileId,
      'psign': instance.psign,
    };
