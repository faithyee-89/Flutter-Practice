import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'user.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class User extends Equatable {
  const User(
      {required this.id,
      required this.isBindPhone,
      this.logoUrl,
      this.username,
      this.isTeacher});

  final int id;
  @JsonKey(name: "is_bind_phone")
  final bool isBindPhone;
  @JsonKey(name: "logo_url")
  final String? logoUrl;
  final String? username;
  @JsonKey(name: "is_teacher")
  final bool? isTeacher;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object> get props => [id, isBindPhone, logoUrl ?? "", username ?? ""];

  static const empty =
      User(id: 0, isBindPhone: false, logoUrl: '', username: '');
}

@JsonSerializable()
class LoginInfo {
  final User user;
  final String token;

  LoginInfo(this.user, this.token);

  factory LoginInfo.fromJson(Map<String, dynamic> json) =>
      _$LoginInfoFromJson(json);
  Map<String, dynamic> toJson() => _$LoginInfoToJson(this);
}
