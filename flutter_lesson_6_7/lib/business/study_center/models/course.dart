/*
 * @Ro: 『Road endless its long and far, I will seek up and down.』
 * @Descripttion: 
 * @Author: Ro
 * @Date: 2021-06-18 17:19:39
 */
import 'package:equatable/equatable.dart';

import 'first_category.dart';

class Course extends Equatable {
  final dynamic brief;
  final int commentCount;
  final double costPrice;
  final FirstCategory firstCategory;
  final int id;
  final String imgUrl;
  final bool isDistribution;
  final int isFree;
  final int isLive;
  final bool isPt;
  final int lessonsPlayedTime;
  final String name;
  final double nowPrice;
  final double progress;

  const Course({
    this.brief,
    this.commentCount,
    this.costPrice,
    this.firstCategory,
    this.id,
    this.imgUrl,
    this.isDistribution,
    this.isFree,
    this.isLive,
    this.isPt,
    this.lessonsPlayedTime,
    this.name,
    this.nowPrice,
    this.progress,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      brief: json['brief'],
      commentCount: json['comment_count'] as int,
      costPrice: json['cost_price'].toDouble(),
      firstCategory: json['first_category'] == null
          ? null
          : FirstCategory.fromJson(
              json['first_category'] as Map<String, dynamic>),
      id: json['id'] as int,
      imgUrl: json['img_url'] as String,
      isDistribution: json['is_distribution'] as bool,
      isFree: json['is_free'] as int,
      isLive: json['is_live'] as int,
      isPt: json['is_pt'] as bool,
      lessonsPlayedTime: json['lessons_played_time'] as int,
      name: json['name'] as String,
      nowPrice: json['now_price'].toDouble(),
      progress: json['progress'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brief': brief,
      'comment_count': commentCount,
      'cost_price': costPrice,
      'first_category': firstCategory?.toJson(),
      'id': id,
      'img_url': imgUrl,
      'is_distribution': isDistribution,
      'is_free': isFree,
      'is_live': isLive,
      'is_pt': isPt,
      'lessons_played_time': lessonsPlayedTime,
      'name': name,
      'now_price': nowPrice,
      'progress': progress,
    };
  }

  Course copyWith({
    dynamic brief,
    int commentCount,
    double costPrice,
    FirstCategory firstCategory,
    int id,
    String imgUrl,
    bool isDistribution,
    int isFree,
    int isLive,
    bool isPt,
    int lessonsPlayedTime,
    String name,
    double nowPrice,
    double progress,
  }) {
    return Course(
      brief: brief ?? this.brief,
      commentCount: commentCount ?? this.commentCount,
      costPrice: costPrice ?? this.costPrice,
      firstCategory: firstCategory ?? this.firstCategory,
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      isDistribution: isDistribution ?? this.isDistribution,
      isFree: isFree ?? this.isFree,
      isLive: isLive ?? this.isLive,
      isPt: isPt ?? this.isPt,
      lessonsPlayedTime: lessonsPlayedTime ?? this.lessonsPlayedTime,
      name: name ?? this.name,
      nowPrice: nowPrice ?? this.nowPrice,
      progress: progress ?? this.progress,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      brief,
      commentCount,
      costPrice,
      firstCategory,
      id,
      imgUrl,
      isDistribution,
      isFree,
      isLive,
      isPt,
      lessonsPlayedTime,
      name,
      nowPrice,
      progress,
    ];
  }
}
