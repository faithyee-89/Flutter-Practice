import 'package:equatable/equatable.dart';

class TeacherCourse extends Equatable {
  final double? costPrice;
  final int? id;
  final String? imgUrl;
  final int? lessonsPlayedTime;
  final String? name;
  final double? nowPrice;
  final int? score;

  const TeacherCourse({
    this.costPrice,
    this.id,
    this.imgUrl,
    this.lessonsPlayedTime,
    this.name,
    this.nowPrice,
    this.score,
  });

  factory TeacherCourse.fromJson(Map<String, dynamic> json) {
    return TeacherCourse(
      costPrice: json['cost_price'] as double,
      id: json['id'] as int,
      imgUrl: json['img_url'] as String,
      lessonsPlayedTime: json['lessons_played_time'] as int,
      name: json['name'] as String,
      nowPrice: json['now_price'] as double,
      score: json['score'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cost_price': costPrice,
      'id': id,
      'img_url': imgUrl,
      'lessons_played_time': lessonsPlayedTime,
      'name': name,
      'now_price': nowPrice,
      'score': score,
    };
  }

  TeacherCourse copyWith({
    double? costPrice,
    int? id,
    String? imgUrl,
    int? lessonsPlayedTime,
    String? name,
    double? nowPrice,
    int? score,
  }) {
    return TeacherCourse(
      costPrice: costPrice ?? this.costPrice,
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      lessonsPlayedTime: lessonsPlayedTime ?? this.lessonsPlayedTime,
      name: name ?? this.name,
      nowPrice: nowPrice ?? this.nowPrice,
      score: score ?? this.score,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      costPrice!,
      id!,
      imgUrl!,
      lessonsPlayedTime!,
      name!,
      nowPrice!,
      score!,
    ];
  }
}
