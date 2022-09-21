import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'last_play_lesson_info.g.dart';

@JsonSerializable()
class LastPlayLessonInfo extends Equatable {
  const LastPlayLessonInfo({
    this.has,
    this.isFinished,
    this.lessonId,
    this.lessonKey,
    this.position,
  });
  final bool? has;

  @JsonKey(name: "is_finished")
  final bool? isFinished;

  @JsonKey(name: "lesson_id")
  final int? lessonId;

  @JsonKey(name: "lesson_key")
  final String? lessonKey;

  final int? position;

  factory LastPlayLessonInfo.fromJson(Map<String, dynamic> json) =>
      _$LastPlayLessonInfoFromJson(json);
  Map<String, dynamic> toJson() => _$LastPlayLessonInfoToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        has ?? "",
        isFinished ?? "",
        lessonId ?? "",
        lessonKey ?? "",
        position ?? "",
      ];

  LastPlayLessonInfo copyWith({
    bool? has,
    bool? isFinished,
    int? lessonId,
    String? lessonKey,
    int? position,
  }) {
    return LastPlayLessonInfo(
      has: has ?? this.has,
      isFinished: isFinished ?? this.isFinished,
      lessonId: lessonId ?? this.lessonId,
      lessonKey: lessonKey ?? this.lessonKey,
      position: position ?? this.position,
    );
  }
}
