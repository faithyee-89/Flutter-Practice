import 'package:equatable/equatable.dart';

class AdBanner extends Equatable {
  final String? bgColor;
  final String? clientUrl;
  final int? id;
  final String? imgUrl;
  final bool? isBlank;
  final String? name;
  final int? orderNum;
  final String? redirectUrl;

  const AdBanner({
    this.bgColor,
    this.clientUrl,
    this.id,
    this.imgUrl,
    this.isBlank,
    this.name,
    this.orderNum,
    this.redirectUrl,
  });

  factory AdBanner.fromJson(Map<String, dynamic> json) {
    return AdBanner(
      bgColor: json['bg_color'],
      clientUrl: json['client_url'],
      id: json['id'] as int,
      imgUrl: json['img_url'] as String,
      isBlank: json['is_blank'] as bool,
      name: json['name'],
      orderNum: json['order_num'] as int,
      redirectUrl: json['redirect_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bg_color': bgColor,
      'client_url': clientUrl,
      'id': id,
      'img_url': imgUrl,
      'is_blank': isBlank,
      'name': name,
      'order_num': orderNum,
      'redirect_url': redirectUrl,
    };
  }

  AdBanner copyWith({
    String? bgColor,
    String? clientUrl,
    int? id,
    String? imgUrl,
    bool? isBlank,
    String? name,
    int? orderNum,
    String? redirectUrl,
  }) {
    return AdBanner(
      bgColor: bgColor ?? this.bgColor,
      clientUrl: clientUrl ?? this.clientUrl,
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      isBlank: isBlank ?? this.isBlank,
      name: name ?? this.name,
      orderNum: orderNum ?? this.orderNum,
      redirectUrl: redirectUrl ?? this.redirectUrl,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      bgColor ?? "",
      clientUrl ?? "",
      id ?? "",
      imgUrl ?? "",
      isBlank ?? "",
      name ?? "",
      orderNum ?? "",
      redirectUrl ?? "",
    ];
  }
}
