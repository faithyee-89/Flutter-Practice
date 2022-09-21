import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lesson.g.dart';

@JsonSerializable()
class Lesson extends Equatable {
    const Lesson({
              this.bsort,
        this.id,
        this.isFree,
        this.isLive,
        this.key,
        this.livePlanBeginTime,
        this.livePlanEndTime,
        this.liveStatus,
        this.name,
        this.state,

    });
  final int? bsort;

  final int? id;

  @JsonKey(name: "is_free")
  final int? isFree;

  @JsonKey(name: "is_live")
  final int? isLive;

  final String? key;

  @JsonKey(name: "live_plan_begin_time")
  final DateTime? livePlanBeginTime;

  @JsonKey(name: "live_plan_end_time")
  final DateTime? livePlanEndTime;

  @JsonKey(name: "live_status")
  final int? liveStatus;

  final String? name;

  final int? state;

  
  factory Lesson.fromJson(Map<String,dynamic> json) => _$LessonFromJson(json);
  Map<String, dynamic> toJson() => _$LessonToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
                bsort ?? "",
        id ?? "",
        isFree ?? "",
        isLive ?? "",
        key ?? "",
        livePlanBeginTime ?? "",
        livePlanEndTime ?? "",
        liveStatus ?? "",
        name ?? "",
        state ?? "",

    ];

  Lesson copyWith({
              int? bsort,
        int? id,
        int? isFree,
        int? isLive,
        String? key,
        DateTime? livePlanBeginTime,
        DateTime? livePlanEndTime,
        int? liveStatus,
        String? name,
        int? state,

    }){

     return Lesson(
               bsort: bsort ?? this.bsort,
        id: id ?? this.id,
        isFree: isFree ?? this.isFree,
        isLive: isLive ?? this.isLive,
        key: key ?? this.key,
        livePlanBeginTime: livePlanBeginTime ?? this.livePlanBeginTime,
        livePlanEndTime: livePlanEndTime ?? this.livePlanEndTime,
        liveStatus: liveStatus ?? this.liveStatus,
        name: name ?? this.name,
        state: state ?? this.state,

     );
  }
}