// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_url.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoUrl _$VideoUrlFromJson(Map<String, dynamic> json) => VideoUrl(
      orig: json['orig'] as String?,
      mp4: json['mp4'] == null
          ? null
          : VideoUrlResolution.fromJson(json['mp4'] as Map<String, dynamic>),
      hls: json['hls'] == null
          ? null
          : VideoUrlResolution.fromJson(json['hls'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VideoUrlToJson(VideoUrl instance) => <String, dynamic>{
      'orig': instance.orig,
      'mp4': instance.mp4,
      'hls': instance.hls,
    };
