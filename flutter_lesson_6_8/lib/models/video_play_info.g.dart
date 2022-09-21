// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_play_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoPlayInfo _$VideoPlayInfoFromJson(Map<String, dynamic> json) =>
    VideoPlayInfo(
      status: json['status'] as int?,
      experDuration: json['exper_duration'] as int?,
      isExper: json['is_exper'] as bool?,
      isLogin: json['is_login'] as bool?,
      videoSource: json['video_source'] as int?,
      seek: json['seek'] as int?,
      isLive: json['is_live'] as int?,
      tcplayer: json['tcplayer'] == null
          ? null
          : Tcplayer.fromJson(json['tcplayer'] as Map<String, dynamic>),
      urls: json['urls'] == null
          ? null
          : VideoUrl.fromJson(json['urls'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VideoPlayInfoToJson(VideoPlayInfo instance) =>
    <String, dynamic>{
      'status': instance.status,
      'exper_duration': instance.experDuration,
      'is_exper': instance.isExper,
      'is_login': instance.isLogin,
      'video_source': instance.videoSource,
      'seek': instance.seek,
      'is_live': instance.isLive,
      'tcplayer': instance.tcplayer,
      'urls': instance.urls,
    };
