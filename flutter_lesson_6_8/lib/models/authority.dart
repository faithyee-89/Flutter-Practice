import 'package:equatable/equatable.dart';

class Authority extends Equatable {
  final int? authorityType;
  final int? days;
  final bool? hasAuthority;
  final String? userType;

  const Authority({
    this.authorityType,
    this.days,
    this.hasAuthority,
    this.userType,
  });

  factory Authority.fromJson(Map<String, dynamic> json) => Authority(
        authorityType: json['authority_type'] as int,
        days: json['days'] as int,
        hasAuthority: json['has_authority'] as bool,
        userType: json['user_type'] as String,
      );

  Map<String, dynamic> toJson() => {
        'authority_type': authorityType,
        'days': days,
        'has_authority': hasAuthority,
        'user_type': userType,
      };

  Authority copyWith({
    int? authorityType,
    int? days,
    bool? hasAuthority,
    String? userType,
  }) {
    return Authority(
      authorityType: authorityType ?? this.authorityType,
      days: days ?? this.days,
      hasAuthority: hasAuthority ?? this.hasAuthority,
      userType: userType ?? this.userType,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      authorityType!,
      days!,
      hasAuthority!,
      userType!,
    ];
  }
}
