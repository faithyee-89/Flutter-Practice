import 'package:equatable/equatable.dart';

class StudyInfo extends Equatable {
  final int? rank;
  final double? todayStudyTime;
  final double? totalStudyTime;

  const StudyInfo({
    this.rank = 0,
    this.todayStudyTime = 0,
    this.totalStudyTime = 0,
  });

  factory StudyInfo.fromJson(Map<String, dynamic> json) {
    return StudyInfo(
      rank: json['rank'] as int,
      todayStudyTime: json['today_study_time']?.toDouble(),
      totalStudyTime: json['total_study_time']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'today_study_time': todayStudyTime,
      'total_study_time': totalStudyTime,
    };
  }

  StudyInfo copyWith({
    int? rank,
    double? todayStudyTime,
    double? totalStudyTime,
  }) {
    return StudyInfo(
      rank: rank ?? this.rank,
      todayStudyTime: todayStudyTime ?? this.todayStudyTime,
      totalStudyTime: totalStudyTime ?? this.totalStudyTime,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [rank!, todayStudyTime!, totalStudyTime!];
}
