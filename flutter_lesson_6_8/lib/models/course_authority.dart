import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_authority.g.dart';

@JsonSerializable()
class CourseAuthority extends Equatable {
    const CourseAuthority({
              this.getMethod,
        this.cancelTime,
        this.days,
        this.isTrue,
        this.type,

    });
  @JsonKey(name: "get_method")
  final int? getMethod;

  @JsonKey(name: "cancel_time")
  final DateTime? cancelTime;

  final int? days;

  @JsonKey(name: "is_true")
  final int? isTrue;

  final String? type;

  
  factory CourseAuthority.fromJson(Map<String,dynamic> json) => _$CourseAuthorityFromJson(json);
  Map<String, dynamic> toJson() => _$CourseAuthorityToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
                getMethod ?? "",
        cancelTime ?? "",
        days ?? "",
        isTrue ?? "",
        type ?? "",

    ];

  CourseAuthority copyWith({
              int? getMethod,
        DateTime? cancelTime,
        int? days,
        int? isTrue,
        String? type,

    }){

     return CourseAuthority(
               getMethod: getMethod ?? this.getMethod,
        cancelTime: cancelTime ?? this.cancelTime,
        days: days ?? this.days,
        isTrue: isTrue ?? this.isTrue,
        type: type ?? this.type,

     );
  }
}