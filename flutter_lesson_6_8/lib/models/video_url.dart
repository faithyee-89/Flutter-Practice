import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import "video_url_resolution.dart";
part 'video_url.g.dart';

@JsonSerializable()
class VideoUrl extends Equatable {
    const VideoUrl({
              this.orig,
        this.mp4,
        this.hls,

    });
  final String? orig;

  final VideoUrlResolution? mp4;

  final VideoUrlResolution? hls;

  
  factory VideoUrl.fromJson(Map<String,dynamic> json) => _$VideoUrlFromJson(json);
  Map<String, dynamic> toJson() => _$VideoUrlToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
                orig ?? "",
        mp4 ?? "",
        hls ?? "",

    ];

  VideoUrl copyWith({
              String? orig,
        VideoUrlResolution? mp4,
        VideoUrlResolution? hls,

    }){

     return VideoUrl(
               orig: orig ?? this.orig,
        mp4: mp4 ?? this.mp4,
        hls: hls ?? this.hls,

     );
  }
}