import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'video_url_resolution.g.dart';

@JsonSerializable()
class VideoUrlResolution extends Equatable {
    const VideoUrlResolution({
              this.hd,
        this.sd,
        this.shd,

    });
  final String? hd;

  final String? sd;

  final String? shd;

  
  factory VideoUrlResolution.fromJson(Map<String,dynamic> json) => _$VideoUrlResolutionFromJson(json);
  Map<String, dynamic> toJson() => _$VideoUrlResolutionToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
                hd ?? "",
        sd ?? "",
        shd ?? "",

    ];

  VideoUrlResolution copyWith({
              String? hd,
        String? sd,
        String? shd,

    }){

     return VideoUrlResolution(
               hd: hd ?? this.hd,
        sd: sd ?? this.sd,
        shd: shd ?? this.shd,

     );
  }
}