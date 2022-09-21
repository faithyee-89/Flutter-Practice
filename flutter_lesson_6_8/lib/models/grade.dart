import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import "course.dart";
part 'grade.g.dart';

@JsonSerializable()
class Grade extends Equatable {
    const Grade({
              this.applyDeadlineTime,
        this.buttonDesc,
        this.course,
        this.createdTime,
        this.currentPrice,
        this.id,
        this.isApplyStop,
        this.learningMode,
        this.number,
        this.originalPrice,
        this.startClassTime,
        this.status,
        this.studentCount,
        this.studentLimit,
        this.studyExpiryDay,
        this.title,

    });
  @JsonKey(name: "apply_deadline_time")
  final DateTime? applyDeadlineTime;

  @JsonKey(name: "button_desc")
  final String? buttonDesc;

  final Course? course;

  @JsonKey(name: "created_time")
  final DateTime? createdTime;

  @JsonKey(name: "current_price")
  final double? currentPrice;

  final int? id;

  @JsonKey(name: "is_apply_stop")
  final int? isApplyStop;

  @JsonKey(name: "learning_mode")
  final int? learningMode;

  final int? number;

  @JsonKey(name: "original_price")
  final double? originalPrice;

  @JsonKey(name: "start_class_time")
  final DateTime? startClassTime;

  final int? status;

  @JsonKey(name: "student_count")
  final int? studentCount;

  @JsonKey(name: "student_limit")
  final int? studentLimit;

  @JsonKey(name: "study_expiry_day")
  final int? studyExpiryDay;

  final String? title;

  
  factory Grade.fromJson(Map<String,dynamic> json) => _$GradeFromJson(json);
  Map<String, dynamic> toJson() => _$GradeToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
                applyDeadlineTime ?? "",
        buttonDesc ?? "",
        course ?? "",
        createdTime ?? "",
        currentPrice ?? "",
        id ?? "",
        isApplyStop ?? "",
        learningMode ?? "",
        number ?? "",
        originalPrice ?? "",
        startClassTime ?? "",
        status ?? "",
        studentCount ?? "",
        studentLimit ?? "",
        studyExpiryDay ?? "",
        title ?? "",

    ];

  Grade copyWith({
              DateTime? applyDeadlineTime,
        String? buttonDesc,
        Course? course,
        DateTime? createdTime,
        double? currentPrice,
        int? id,
        int? isApplyStop,
        int? learningMode,
        int? number,
        double? originalPrice,
        DateTime? startClassTime,
        int? status,
        int? studentCount,
        int? studentLimit,
        int? studyExpiryDay,
        String? title,

    }){

     return Grade(
               applyDeadlineTime: applyDeadlineTime ?? this.applyDeadlineTime,
        buttonDesc: buttonDesc ?? this.buttonDesc,
        course: course ?? this.course,
        createdTime: createdTime ?? this.createdTime,
        currentPrice: currentPrice ?? this.currentPrice,
        id: id ?? this.id,
        isApplyStop: isApplyStop ?? this.isApplyStop,
        learningMode: learningMode ?? this.learningMode,
        number: number ?? this.number,
        originalPrice: originalPrice ?? this.originalPrice,
        startClassTime: startClassTime ?? this.startClassTime,
        status: status ?? this.status,
        studentCount: studentCount ?? this.studentCount,
        studentLimit: studentLimit ?? this.studentLimit,
        studyExpiryDay: studyExpiryDay ?? this.studyExpiryDay,
        title: title ?? this.title,

     );
  }
}