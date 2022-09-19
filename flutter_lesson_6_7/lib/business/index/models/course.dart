import 'package:equatable/equatable.dart';

import 'first_category.dart';

class Course extends Equatable {
  final String brief;
  final int commentCount;
  final double costPrice;
  final int expiryDay;
  final int finishedLessonsCount;
  final FirstCategory firstCategory;
  final int id;
  final String imgUrl;
  final int isFree;
  final int isLive;
  final bool isPt;
  final bool isShareCard;
  final int lessonsCount;
  final int lessonsPlayedTime;
  final String name;
  final double nowPrice;

  const Course({
    this.brief,
    this.commentCount,
    this.costPrice,
    this.expiryDay,
    this.finishedLessonsCount,
    this.firstCategory,
    this.id,
    this.imgUrl,
    this.isFree,
    this.isLive,
    this.isPt,
    this.isShareCard,
    this.lessonsCount,
    this.lessonsPlayedTime,
    this.name,
    this.nowPrice,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      brief: json['brief'] as String,
      commentCount: json['comment_count'] as int,
      costPrice: json['cost_price'] as double,
      expiryDay: json['expiry_day'] as int,
      finishedLessonsCount: json['finished_lessons_count'] as int,
      firstCategory: json['first_category'] == null
          ? null
          : FirstCategory.fromJson(
              json['first_category'] as Map<String, dynamic>),
      id: json['id'] as int,
      imgUrl: json['img_url'] as String,
      isFree: json['is_free'] as int,
      isLive: json['is_live'] as int,
      isPt: json['is_pt'] as bool,
      isShareCard: json['is_share_card'] as bool ?? false,
      lessonsCount: json['lessons_count'] as int,
      lessonsPlayedTime: json['lessons_played_time'] as int,
      name: json['name'] as String,
      nowPrice: json['now_price'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brief': brief,
      'comment_count': commentCount,
      'cost_price': costPrice,
      'expiry_day': expiryDay,
      'finished_lessons_count': finishedLessonsCount,
      'first_category': firstCategory?.toJson(),
      'id': id,
      'img_url': imgUrl,
      'is_free': isFree,
      'is_live': isLive,
      'is_pt': isPt,
      'is_share_card': isShareCard,
      'lessons_count': lessonsCount,
      'lessons_played_time': lessonsPlayedTime,
      'name': name,
      'now_price': nowPrice,
    };
  }

  Course copyWith({
    String brief,
    int commentCount,
    int costPrice,
    int expiryDay,
    int finishedLessonsCount,
    FirstCategory firstCategory,
    int id,
    String imgUrl,
    int isFree,
    int isLive,
    bool isPt,
    bool isShareCard,
    int lessonsCount,
    int lessonsPlayedTime,
    String name,
    int nowPrice,
  }) {
    return Course(
      brief: brief ?? this.brief,
      commentCount: commentCount ?? this.commentCount,
      costPrice: costPrice ?? this.costPrice,
      expiryDay: expiryDay ?? this.expiryDay,
      finishedLessonsCount: finishedLessonsCount ?? this.finishedLessonsCount,
      firstCategory: firstCategory ?? this.firstCategory,
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      isFree: isFree ?? this.isFree,
      isLive: isLive ?? this.isLive,
      isPt: isPt ?? this.isPt,
      isShareCard: isShareCard ?? this.isShareCard,
      lessonsCount: lessonsCount ?? this.lessonsCount,
      lessonsPlayedTime: lessonsPlayedTime ?? this.lessonsPlayedTime,
      name: name ?? this.name,
      nowPrice: nowPrice ?? this.nowPrice,
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
      expiryDay,
      finishedLessonsCount,
      firstCategory,
      id,
      imgUrl,
      isFree,
      isLive,
      isPt,
      isShareCard,
      lessonsCount,
      lessonsPlayedTime,
      name,
      nowPrice,
    ];
  }
}
