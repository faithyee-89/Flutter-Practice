import 'package:equatable/equatable.dart';

import 'course.dart';

class BoughtCourse extends Equatable {
  final String cancelTime;
  final Course course;
  final String createdTime;
  final int id;
  final bool isExpired;
  final String orderTime;
  final int productId;
  final int productType;

  const BoughtCourse({
    this.cancelTime,
    this.course,
    this.createdTime,
    this.id,
    this.isExpired,
    this.orderTime,
    this.productId,
    this.productType,
  });

  factory BoughtCourse.fromJson(Map<String, dynamic> json) {
    return BoughtCourse(
      cancelTime: json['cancel_time'] as String,
      course: json['course'] == null
          ? null
          : Course.fromJson(json['course'] as Map<String, dynamic>),
      createdTime: json['created_time'] as String,
      id: json['id'] as int,
      isExpired: json['is_expired'] as bool,
      orderTime: json['order_time'] as String,
      productId: json['product_id'] as int,
      productType: json['product_type'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cancel_time': cancelTime,
      'course': course?.toJson(),
      'created_time': createdTime,
      'id': id,
      'is_expired': isExpired,
      'order_time': orderTime,
      'product_id': productId,
      'product_type': productType,
    };
  }

  BoughtCourse copyWith({
    String cancelTime,
    Course course,
    String createdTime,
    int id,
    bool isExpired,
    String orderTime,
    int productId,
    int productType,
  }) {
    return BoughtCourse(
      cancelTime: cancelTime ?? this.cancelTime,
      course: course ?? this.course,
      createdTime: createdTime ?? this.createdTime,
      id: id ?? this.id,
      isExpired: isExpired ?? this.isExpired,
      orderTime: orderTime ?? this.orderTime,
      productId: productId ?? this.productId,
      productType: productType ?? this.productType,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      cancelTime,
      course,
      createdTime,
      id,
      isExpired,
      orderTime,
      productId,
      productType,
    ];
  }
}
