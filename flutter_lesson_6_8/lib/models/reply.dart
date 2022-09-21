import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import "user.dart";
part 'reply.g.dart';

@JsonSerializable()
class Reply extends Equatable {
    const Reply({
              this.createdTime,
        this.id,
        this.replyMsg,
        this.user,

    });
  @JsonKey(name: "created_time")
  final DateTime? createdTime;

  final int? id;

  @JsonKey(name: "reply_msg")
  final String? replyMsg;

  final User? user;

  
  factory Reply.fromJson(Map<String,dynamic> json) => _$ReplyFromJson(json);
  Map<String, dynamic> toJson() => _$ReplyToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
                createdTime ?? "",
        id ?? "",
        replyMsg ?? "",
        user ?? "",

    ];

  Reply copyWith({
              DateTime? createdTime,
        int? id,
        String? replyMsg,
        User? user,

    }){

     return Reply(
               createdTime: createdTime ?? this.createdTime,
        id: id ?? this.id,
        replyMsg: replyMsg ?? this.replyMsg,
        user: user ?? this.user,

     );
  }
}