import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import "lesson.dart";
import "teacher.dart";
part 'chapter.g.dart';

@JsonSerializable()
class Chapter extends Equatable {
    const Chapter({
              this.beginTime,
        this.brief,
        this.coverUrl,
        this.createdTime,
        this.endTime,
        this.id,
        this.isOpen,
        this.lessons,
        this.rank,
        this.teacher,
        this.title,

    });
  @JsonKey(name: "begin_time")
  final DateTime? beginTime;

  final String? brief;

  @JsonKey(name: "cover_url")
  final String? coverUrl;

  @JsonKey(name: "created_time")
  final DateTime? createdTime;

  @JsonKey(name: "end_time")
  final DateTime? endTime;

  final int? id;

  @JsonKey(name: "is_open")
  final int? isOpen;

  final List<Lesson>? lessons;

  final int? rank;

  final Teacher? teacher;

  final String? title;

  
  factory Chapter.fromJson(Map<String,dynamic> json) => _$ChapterFromJson(json);
  Map<String, dynamic> toJson() => _$ChapterToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
                beginTime ?? "",
        brief ?? "",
        coverUrl ?? "",
        createdTime ?? "",
        endTime ?? "",
        id ?? "",
        isOpen ?? "",
        lessons ?? "",
        rank ?? "",
        teacher ?? "",
        title ?? "",

    ];

  Chapter copyWith({
              DateTime? beginTime,
        String? brief,
        String? coverUrl,
        DateTime? createdTime,
        DateTime? endTime,
        int? id,
        int? isOpen,
        List<Lesson>? lessons,
        int? rank,
        Teacher? teacher,
        String? title,

    }){

     return Chapter(
               beginTime: beginTime ?? this.beginTime,
        brief: brief ?? this.brief,
        coverUrl: coverUrl ?? this.coverUrl,
        createdTime: createdTime ?? this.createdTime,
        endTime: endTime ?? this.endTime,
        id: id ?? this.id,
        isOpen: isOpen ?? this.isOpen,
        lessons: lessons ?? this.lessons,
        rank: rank ?? this.rank,
        teacher: teacher ?? this.teacher,
        title: title ?? this.title,

     );
  }
}