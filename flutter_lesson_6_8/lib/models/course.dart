import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import "category.dart";
import "teacher.dart";
part 'course.g.dart';

@JsonSerializable()
class Course extends Equatable {
    const Course({
              this.brief,
        this.canBuy,
        this.canUseCoupon,
        this.classDifficulty,
        this.commentCount,
        this.costPrice,
        this.courseType,
        this.createdTime,
        this.desc,
        this.discountInfo,
        this.expiryDay,
        this.finishedLessonsCount,
        this.firstCategory,
        this.fitTo,
        this.goal,
        this.h5site,
        this.hasAuthority,
        this.id,
        this.imgUrl,
        this.isDiscount,
        this.isDistribution,
        this.isFree,
        this.isLive,
        this.isPt,
        this.isShareCard,
        this.lessonsCount,
        this.lessonsFinishedCount,
        this.lessonsPlayedTime,
        this.lessonsTime,
        this.name,
        this.nowPrice,
        this.preTech,
        this.qrImgUrl,
        this.recommendCount,
        this.teacher,
        this.website,

    });
  final String? brief;

  @JsonKey(name: "can_buy")
  final int? canBuy;

  @JsonKey(name: "can_use_coupon")
  final int? canUseCoupon;

  @JsonKey(name: "class_difficulty")
  final int? classDifficulty;

  @JsonKey(name: "comment_count")
  final int? commentCount;

  @JsonKey(name: "cost_price")
  final double? costPrice;

  @JsonKey(name: "course_type")
  final int? courseType;

  @JsonKey(name: "created_time")
  final DateTime? createdTime;

  final String? desc;

  @JsonKey(name: "discount_info")
  final Map<String,dynamic>? discountInfo;

  @JsonKey(name: "expiry_day")
  final int? expiryDay;

  @JsonKey(name: "finished_lessons_count")
  final int? finishedLessonsCount;

  @JsonKey(name: "first_category")
  final Category? firstCategory;

  @JsonKey(name: "fit_to")
  final String? fitTo;

  final String? goal;

  final String? h5site;

  @JsonKey(name: "has_authority")
  final bool? hasAuthority;

  final int? id;

  @JsonKey(name: "img_url")
  final String? imgUrl;

  @JsonKey(name: "is_discount")
  final bool? isDiscount;

  @JsonKey(name: "is_distribution")
  final bool? isDistribution;

  @JsonKey(name: "is_free")
  final int? isFree;

  @JsonKey(name: "is_live")
  final int? isLive;

  @JsonKey(name: "is_pt")
  final bool? isPt;

  @JsonKey(name: "is_share_card")
  final bool? isShareCard;

  @JsonKey(name: "lessons_count")
  final int? lessonsCount;

  @JsonKey(name: "lessons_finished_count")
  final int? lessonsFinishedCount;

  @JsonKey(name: "lessons_played_time")
  final int? lessonsPlayedTime;

  @JsonKey(name: "lessons_time")
  final int? lessonsTime;

  final String? name;

  @JsonKey(name: "now_price")
  final double? nowPrice;

  @JsonKey(name: "pre_tech")
  final String? preTech;

  @JsonKey(name: "qr_img_url")
  final String? qrImgUrl;

  @JsonKey(name: "recommend_count")
  final int? recommendCount;

  final Teacher? teacher;

  final String? website;

  
  factory Course.fromJson(Map<String,dynamic> json) => _$CourseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
                brief ?? "",
        canBuy ?? "",
        canUseCoupon ?? "",
        classDifficulty ?? "",
        commentCount ?? "",
        costPrice ?? "",
        courseType ?? "",
        createdTime ?? "",
        desc ?? "",
        discountInfo ?? "",
        expiryDay ?? "",
        finishedLessonsCount ?? "",
        firstCategory ?? "",
        fitTo ?? "",
        goal ?? "",
        h5site ?? "",
        hasAuthority ?? "",
        id ?? "",
        imgUrl ?? "",
        isDiscount ?? "",
        isDistribution ?? "",
        isFree ?? "",
        isLive ?? "",
        isPt ?? "",
        isShareCard ?? "",
        lessonsCount ?? "",
        lessonsFinishedCount ?? "",
        lessonsPlayedTime ?? "",
        lessonsTime ?? "",
        name ?? "",
        nowPrice ?? "",
        preTech ?? "",
        qrImgUrl ?? "",
        recommendCount ?? "",
        teacher ?? "",
        website ?? "",

    ];

  Course copyWith({
              String? brief,
        int? canBuy,
        int? canUseCoupon,
        int? classDifficulty,
        int? commentCount,
        double? costPrice,
        int? courseType,
        DateTime? createdTime,
        String? desc,
        Map<String,dynamic>? discountInfo,
        int? expiryDay,
        int? finishedLessonsCount,
        Category? firstCategory,
        String? fitTo,
        String? goal,
        String? h5site,
        bool? hasAuthority,
        int? id,
        String? imgUrl,
        bool? isDiscount,
        bool? isDistribution,
        int? isFree,
        int? isLive,
        bool? isPt,
        bool? isShareCard,
        int? lessonsCount,
        int? lessonsFinishedCount,
        int? lessonsPlayedTime,
        int? lessonsTime,
        String? name,
        double? nowPrice,
        String? preTech,
        String? qrImgUrl,
        int? recommendCount,
        Teacher? teacher,
        String? website,

    }){

     return Course(
               brief: brief ?? this.brief,
        canBuy: canBuy ?? this.canBuy,
        canUseCoupon: canUseCoupon ?? this.canUseCoupon,
        classDifficulty: classDifficulty ?? this.classDifficulty,
        commentCount: commentCount ?? this.commentCount,
        costPrice: costPrice ?? this.costPrice,
        courseType: courseType ?? this.courseType,
        createdTime: createdTime ?? this.createdTime,
        desc: desc ?? this.desc,
        discountInfo: discountInfo ?? this.discountInfo,
        expiryDay: expiryDay ?? this.expiryDay,
        finishedLessonsCount: finishedLessonsCount ?? this.finishedLessonsCount,
        firstCategory: firstCategory ?? this.firstCategory,
        fitTo: fitTo ?? this.fitTo,
        goal: goal ?? this.goal,
        h5site: h5site ?? this.h5site,
        hasAuthority: hasAuthority ?? this.hasAuthority,
        id: id ?? this.id,
        imgUrl: imgUrl ?? this.imgUrl,
        isDiscount: isDiscount ?? this.isDiscount,
        isDistribution: isDistribution ?? this.isDistribution,
        isFree: isFree ?? this.isFree,
        isLive: isLive ?? this.isLive,
        isPt: isPt ?? this.isPt,
        isShareCard: isShareCard ?? this.isShareCard,
        lessonsCount: lessonsCount ?? this.lessonsCount,
        lessonsFinishedCount: lessonsFinishedCount ?? this.lessonsFinishedCount,
        lessonsPlayedTime: lessonsPlayedTime ?? this.lessonsPlayedTime,
        lessonsTime: lessonsTime ?? this.lessonsTime,
        name: name ?? this.name,
        nowPrice: nowPrice ?? this.nowPrice,
        preTech: preTech ?? this.preTech,
        qrImgUrl: qrImgUrl ?? this.qrImgUrl,
        recommendCount: recommendCount ?? this.recommendCount,
        teacher: teacher ?? this.teacher,
        website: website ?? this.website,

     );
  }
}