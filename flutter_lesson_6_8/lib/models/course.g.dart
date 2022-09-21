// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      brief: json['brief'] as String?,
      canBuy: json['can_buy'] as int?,
      canUseCoupon: json['can_use_coupon'] as int?,
      classDifficulty: json['class_difficulty'] as int?,
      commentCount: json['comment_count'] as int?,
      costPrice: (json['cost_price'] as num?)?.toDouble(),
      courseType: json['course_type'] as int?,
      createdTime: json['created_time'] == null
          ? null
          : DateTime.parse(json['created_time'] as String),
      desc: json['desc'] as String?,
      discountInfo: json['discount_info'] as Map<String, dynamic>?,
      expiryDay: json['expiry_day'] as int?,
      finishedLessonsCount: json['finished_lessons_count'] as int?,
      firstCategory: json['first_category'] == null
          ? null
          : Category.fromJson(json['first_category'] as Map<String, dynamic>),
      fitTo: json['fit_to'] as String?,
      goal: json['goal'] as String?,
      h5site: json['h5site'] as String?,
      hasAuthority: json['has_authority'] as bool?,
      id: json['id'] as int?,
      imgUrl: json['img_url'] as String?,
      isDiscount: json['is_discount'] as bool?,
      isDistribution: json['is_distribution'] as bool?,
      isFree: json['is_free'] as int?,
      isLive: json['is_live'] as int?,
      isPt: json['is_pt'] as bool?,
      isShareCard: json['is_share_card'] as bool?,
      lessonsCount: json['lessons_count'] as int?,
      lessonsFinishedCount: json['lessons_finished_count'] as int?,
      lessonsPlayedTime: json['lessons_played_time'] as int?,
      lessonsTime: json['lessons_time'] as int?,
      name: json['name'] as String?,
      nowPrice: (json['now_price'] as num?)?.toDouble(),
      preTech: json['pre_tech'] as String?,
      qrImgUrl: json['qr_img_url'] as String?,
      recommendCount: json['recommend_count'] as int?,
      teacher: json['teacher'] == null
          ? null
          : Teacher.fromJson(json['teacher'] as Map<String, dynamic>),
      website: json['website'] as String?,
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'brief': instance.brief,
      'can_buy': instance.canBuy,
      'can_use_coupon': instance.canUseCoupon,
      'class_difficulty': instance.classDifficulty,
      'comment_count': instance.commentCount,
      'cost_price': instance.costPrice,
      'course_type': instance.courseType,
      'created_time': instance.createdTime?.toIso8601String(),
      'desc': instance.desc,
      'discount_info': instance.discountInfo,
      'expiry_day': instance.expiryDay,
      'finished_lessons_count': instance.finishedLessonsCount,
      'first_category': instance.firstCategory,
      'fit_to': instance.fitTo,
      'goal': instance.goal,
      'h5site': instance.h5site,
      'has_authority': instance.hasAuthority,
      'id': instance.id,
      'img_url': instance.imgUrl,
      'is_discount': instance.isDiscount,
      'is_distribution': instance.isDistribution,
      'is_free': instance.isFree,
      'is_live': instance.isLive,
      'is_pt': instance.isPt,
      'is_share_card': instance.isShareCard,
      'lessons_count': instance.lessonsCount,
      'lessons_finished_count': instance.lessonsFinishedCount,
      'lessons_played_time': instance.lessonsPlayedTime,
      'lessons_time': instance.lessonsTime,
      'name': instance.name,
      'now_price': instance.nowPrice,
      'pre_tech': instance.preTech,
      'qr_img_url': instance.qrImgUrl,
      'recommend_count': instance.recommendCount,
      'teacher': instance.teacher,
      'website': instance.website,
    };
