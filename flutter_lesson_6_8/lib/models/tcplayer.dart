import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tcplayer.g.dart';

@JsonSerializable()
class Tcplayer extends Equatable {
    const Tcplayer({
              this.appId,
        this.fileId,
        this.psign,

    });
  @JsonKey(name: "app_id")
  final int? appId;

  @JsonKey(name: "file_id")
  final String? fileId;

  final String? psign;

  
  factory Tcplayer.fromJson(Map<String,dynamic> json) => _$TcplayerFromJson(json);
  Map<String, dynamic> toJson() => _$TcplayerToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
                appId ?? "",
        fileId ?? "",
        psign ?? "",

    ];

  Tcplayer copyWith({
              int? appId,
        String? fileId,
        String? psign,

    }){

     return Tcplayer(
               appId: appId ?? this.appId,
        fileId: fileId ?? this.fileId,
        psign: psign ?? this.psign,

     );
  }
}