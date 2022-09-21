import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import "reply.dart";
import "user.dart";
part 'comment.g.dart';

@JsonSerializable()
class Comment extends Equatable {
    const Comment({
              this.comment,
        this.createdTime,
        this.id,
        this.isEssence,
        this.replys,
        this.resId,
        this.resType,
        this.score,
        this.user,

    });
  final String? comment;

  @JsonKey(name: "created_time")
  final DateTime? createdTime;

  final int? id;

  @JsonKey(name: "is_essence")
  final int? isEssence;

  final List<Reply>? replys;

  @JsonKey(name: "res_id")
  final int? resId;

  @JsonKey(name: "res_type")
  final int? resType;

  final int? score;

  final User? user;

  
  factory Comment.fromJson(Map<String,dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
                comment ?? "",
        createdTime ?? "",
        id ?? "",
        isEssence ?? "",
        replys ?? "",
        resId ?? "",
        resType ?? "",
        score ?? "",
        user ?? "",

    ];

  Comment copyWith({
              String? comment,
        DateTime? createdTime,
        int? id,
        int? isEssence,
        List<Reply>? replys,
        int? resId,
        int? resType,
        int? score,
        User? user,

    }){

     return Comment(
               comment: comment ?? this.comment,
        createdTime: createdTime ?? this.createdTime,
        id: id ?? this.id,
        isEssence: isEssence ?? this.isEssence,
        replys: replys ?? this.replys,
        resId: resId ?? this.resId,
        resType: resType ?? this.resType,
        score: score ?? this.score,
        user: user ?? this.user,

     );
  }
}