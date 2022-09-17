import 'package:equatable/equatable.dart';

import 'grade_course.dart';

class Grade extends Equatable {
  final String? applyDeadlineTime;
  final dynamic balancePaymentTime;
  final dynamic buttonDesc;
  final GradeCourse? course;
  final String? createdTime;
  final double? currentPrice;
  final String? graduateTime;
  final int? id;
  final int? isApplyStop;
  final dynamic learningMode;
  final int? lessonsCount;
  final int? lessonsTime;
  final int? number;
  final double? originalPrice;
  final String? startClassTime;
  final int? status;
  final dynamic stopUseDownPaymentTime;
  final int? studentCount;
  final int? studentLimit;
  final int? studyExpiryDay;
  final String? teacherIds;
  final String? title;

  const Grade({
    this.applyDeadlineTime,
    this.balancePaymentTime,
    this.buttonDesc,
    this.course,
    this.createdTime,
    this.currentPrice,
    this.graduateTime,
    this.id,
    this.isApplyStop,
    this.learningMode,
    this.lessonsCount,
    this.lessonsTime,
    this.number,
    this.originalPrice,
    this.startClassTime,
    this.status,
    this.stopUseDownPaymentTime,
    this.studentCount,
    this.studentLimit,
    this.studyExpiryDay,
    this.teacherIds,
    this.title,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      applyDeadlineTime: json['apply_deadline_time'] as String,
      balancePaymentTime: json['balance_payment_time'],
      buttonDesc: json['button_desc'],
      course: json['course'] == null
          ? null
          : GradeCourse.fromJson(json['course'] as Map<String, dynamic>),
      createdTime: json['created_time'] as String,
      currentPrice: json['current_price'] as double,
      graduateTime: json['graduate_time'] as String,
      id: json['id'] as int,
      isApplyStop: json['is_apply_stop'] as int,
      learningMode: json['learning_mode'],
      lessonsCount: json['lessons_count'] as int,
      lessonsTime: json['lessons_time'] as int,
      number: json['number'] as int,
      originalPrice: json['original_price'] as double,
      startClassTime: json['start_class_time'] as String,
      status: json['status'] as int,
      stopUseDownPaymentTime: json['stop_use_down_payment_time'],
      studentCount: json['student_count'] as int,
      studentLimit: json['student_limit'] as int,
      studyExpiryDay: json['study_expiry_day'] as int,
      teacherIds: json['teacher_ids'] as String,
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'apply_deadline_time': applyDeadlineTime,
      'balance_payment_time': balancePaymentTime,
      'button_desc': buttonDesc,
      'course': course?.toJson(),
      'created_time': createdTime,
      'current_price': currentPrice,
      'graduate_time': graduateTime,
      'id': id,
      'is_apply_stop': isApplyStop,
      'learning_mode': learningMode,
      'lessons_count': lessonsCount,
      'lessons_time': lessonsTime,
      'number': number,
      'original_price': originalPrice,
      'start_class_time': startClassTime,
      'status': status,
      'stop_use_down_payment_time': stopUseDownPaymentTime,
      'student_count': studentCount,
      'student_limit': studentLimit,
      'study_expiry_day': studyExpiryDay,
      'teacher_ids': teacherIds,
      'title': title,
    };
  }

  Grade copyWith({
    String? applyDeadlineTime,
    dynamic balancePaymentTime,
    dynamic buttonDesc,
    GradeCourse? course,
    String? createdTime,
    double? currentPrice,
    String? graduateTime,
    int? id,
    int? isApplyStop,
    dynamic learningMode,
    int? lessonsCount,
    int? lessonsTime,
    int? number,
    double? originalPrice,
    String? startClassTime,
    int? status,
    dynamic stopUseDownPaymentTime,
    int? studentCount,
    int? studentLimit,
    int? studyExpiryDay,
    String? teacherIds,
    String? title,
  }) {
    return Grade(
      applyDeadlineTime: applyDeadlineTime ?? this.applyDeadlineTime,
      balancePaymentTime: balancePaymentTime ?? this.balancePaymentTime,
      buttonDesc: buttonDesc ?? this.buttonDesc,
      course: course ?? this.course,
      createdTime: createdTime ?? this.createdTime,
      currentPrice: currentPrice ?? this.currentPrice,
      graduateTime: graduateTime ?? this.graduateTime,
      id: id ?? this.id,
      isApplyStop: isApplyStop ?? this.isApplyStop,
      learningMode: learningMode ?? this.learningMode,
      lessonsCount: lessonsCount ?? this.lessonsCount,
      lessonsTime: lessonsTime ?? this.lessonsTime,
      number: number ?? this.number,
      originalPrice: originalPrice ?? this.originalPrice,
      startClassTime: startClassTime ?? this.startClassTime,
      status: status ?? this.status,
      stopUseDownPaymentTime:
          stopUseDownPaymentTime ?? this.stopUseDownPaymentTime,
      studentCount: studentCount ?? this.studentCount,
      studentLimit: studentLimit ?? this.studentLimit,
      studyExpiryDay: studyExpiryDay ?? this.studyExpiryDay,
      teacherIds: teacherIds ?? this.teacherIds,
      title: title ?? this.title,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      applyDeadlineTime!,
      balancePaymentTime,
      buttonDesc,
      course!,
      createdTime!,
      currentPrice!,
      graduateTime!,
      id!,
      isApplyStop!,
      learningMode,
      lessonsCount!,
      lessonsTime!,
      number!,
      originalPrice!,
      startClassTime!,
      status!,
      stopUseDownPaymentTime,
      studentCount!,
      studentLimit!,
      studyExpiryDay!,
      teacherIds!,
      title!,
    ];
  }
}
