import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import "tcplayer.dart";
import "video_url.dart";
part 'video_play_info.g.dart';

@JsonSerializable()
class VideoPlayInfo extends Equatable {
    const VideoPlayInfo({
              this.status,
        this.experDuration,
        this.isExper,
        this.isLogin,
        this.videoSource,
        this.seek,
        this.isLive,
        this.tcplayer,
        this.urls,

    });
  final int? status;

  @JsonKey(name: "exper_duration")
  final int? experDuration;

  @JsonKey(name: "is_exper")
  final bool? isExper;

  @JsonKey(name: "is_login")
  final bool? isLogin;

  @JsonKey(name: "video_source")
  final int? videoSource;

  final int? seek;

  @JsonKey(name: "is_live")
  final int? isLive;

  final Tcplayer? tcplayer;

  final VideoUrl? urls;

  
  factory VideoPlayInfo.fromJson(Map<String,dynamic> json) => _$VideoPlayInfoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoPlayInfoToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
                status ?? "",
        experDuration ?? "",
        isExper ?? "",
        isLogin ?? "",
        videoSource ?? "",
        seek ?? "",
        isLive ?? "",
        tcplayer ?? "",
        urls ?? "",

    ];

  VideoPlayInfo copyWith({
              int? status,
        int? experDuration,
        bool? isExper,
        bool? isLogin,
        int? videoSource,
        int? seek,
        int? isLive,
        Tcplayer? tcplayer,
        VideoUrl? urls,

    }){

     return VideoPlayInfo(
               status: status ?? this.status,
        experDuration: experDuration ?? this.experDuration,
        isExper: isExper ?? this.isExper,
        isLogin: isLogin ?? this.isLogin,
        videoSource: videoSource ?? this.videoSource,
        seek: seek ?? this.seek,
        isLive: isLive ?? this.isLive,
        tcplayer: tcplayer ?? this.tcplayer,
        urls: urls ?? this.urls,

     );
  }
}