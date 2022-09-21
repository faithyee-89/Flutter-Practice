// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'studied_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudiedCourse _$StudiedCourseFromJson(Map<String, dynamic> json) =>
    StudiedCourse(
      course: json['course'] == null
          ? null
          : Course.fromJson(json['course'] as Map<String, dynamic>),
      courseType: json['course_type'] as int?,
      currentPrice: (json['current_price'] as num?)?.toDouble(),
      id: json['id'] as int?,
      lessonsCount: json['lessons_count'] as int?,
      lessonsPlayedTime: json['lessons_played_time'] as int?,
      commentCount: json['comment_count'] as int?,
      originalPrice: (json['original_price'] as num?)?.toDouble(),
      progress: (json['progress'] as num?)?.toDouble(),
      name: json['name'] as String?,
      imgUrl: json['img_url'] as String?,
      getMethod: json['get_method'] as int?,
      leftExpiryDays: json['left_expiry_days'] as int?,
      cancelTime: json['cancel_time'] == null
          ? null
          : DateTime.parse(json['cancel_time'] as String),
      productId: json['product_id'] as int?,
      productType: json['product_type'] as int?,
    );

Map<String, dynamic> _$StudiedCourseToJson(StudiedCourse instance) =>
    <String, dynamic>{
      'course': instance.course,
      'course_type': instance.courseType,
      'current_price': instance.currentPrice,
      'id': instance.id,
      'lessons_count': instance.lessonsCount,
      'lessons_played_time': instance.lessonsPlayedTime,
      'comment_count': instance.commentCount,
      'original_price': instance.originalPrice,
      'progress': instance.progress,
      'name': instance.name,
      'img_url': instance.imgUrl,
      'get_method': instance.getMethod,
      'left_expiry_days': instance.leftExpiryDays,
      'cancel_time': instance.cancelTime?.toIso8601String(),
      'product_id': instance.productId,
      'product_type': instance.productType,
    };
