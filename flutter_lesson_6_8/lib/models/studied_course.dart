import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import "course.dart";
part 'studied_course.g.dart';

@JsonSerializable()
class StudiedCourse extends Equatable {
    const StudiedCourse({
              this.course,
        this.courseType,
        this.currentPrice,
        this.id,
        this.lessonsCount,
        this.lessonsPlayedTime,
        this.commentCount,
        this.originalPrice,
        this.progress,
        this.name,
        this.imgUrl,
        this.getMethod,
        this.leftExpiryDays,
        this.cancelTime,
        this.productId,
        this.productType,

    });
  final Course? course;

  @JsonKey(name: "course_type")
  final int? courseType;

  @JsonKey(name: "current_price")
  final double? currentPrice;

  final int? id;

  @JsonKey(name: "lessons_count")
  final int? lessonsCount;

  @JsonKey(name: "lessons_played_time")
  final int? lessonsPlayedTime;

  @JsonKey(name: "comment_count")
  final int? commentCount;

  @JsonKey(name: "original_price")
  final double? originalPrice;

  final double? progress;

  final String? name;

  @JsonKey(name: "img_url")
  final String? imgUrl;

  @JsonKey(name: "get_method")
  final int? getMethod;

  @JsonKey(name: "left_expiry_days")
  final int? leftExpiryDays;

  @JsonKey(name: "cancel_time")
  final DateTime? cancelTime;

  @JsonKey(name: "product_id")
  final int? productId;

  @JsonKey(name: "product_type")
  final int? productType;

  
  factory StudiedCourse.fromJson(Map<String,dynamic> json) => _$StudiedCourseFromJson(json);
  Map<String, dynamic> toJson() => _$StudiedCourseToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
                course ?? "",
        courseType ?? "",
        currentPrice ?? "",
        id ?? "",
        lessonsCount ?? "",
        lessonsPlayedTime ?? "",
        commentCount ?? "",
        originalPrice ?? "",
        progress ?? "",
        name ?? "",
        imgUrl ?? "",
        getMethod ?? "",
        leftExpiryDays ?? "",
        cancelTime ?? "",
        productId ?? "",
        productType ?? "",

    ];

  StudiedCourse copyWith({
              Course? course,
        int? courseType,
        double? currentPrice,
        int? id,
        int? lessonsCount,
        int? lessonsPlayedTime,
        int? commentCount,
        double? originalPrice,
        double? progress,
        String? name,
        String? imgUrl,
        int? getMethod,
        int? leftExpiryDays,
        DateTime? cancelTime,
        int? productId,
        int? productType,

    }){

     return StudiedCourse(
               course: course ?? this.course,
        courseType: courseType ?? this.courseType,
        currentPrice: currentPrice ?? this.currentPrice,
        id: id ?? this.id,
        lessonsCount: lessonsCount ?? this.lessonsCount,
        lessonsPlayedTime: lessonsPlayedTime ?? this.lessonsPlayedTime,
        commentCount: commentCount ?? this.commentCount,
        originalPrice: originalPrice ?? this.originalPrice,
        progress: progress ?? this.progress,
        name: name ?? this.name,
        imgUrl: imgUrl ?? this.imgUrl,
        getMethod: getMethod ?? this.getMethod,
        leftExpiryDays: leftExpiryDays ?? this.leftExpiryDays,
        cancelTime: cancelTime ?? this.cancelTime,
        productId: productId ?? this.productId,
        productType: productType ?? this.productType,

     );
  }
}