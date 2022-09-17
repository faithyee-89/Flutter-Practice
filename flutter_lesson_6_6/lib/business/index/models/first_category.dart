import 'package:equatable/equatable.dart';

class FirstCategory extends Equatable {
  final String? code;
  final int? id;
  final String? title;

  const FirstCategory({
    this.code,
    this.id,
    this.title,
  });

  factory FirstCategory.fromJson(Map<String, dynamic> json) {
    return FirstCategory(
      code: json['code'] as String,
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'id': id,
      'title': title,
    };
  }

  FirstCategory copyWith({
    String? code,
    int? id,
    String? title,
  }) {
    return FirstCategory(
      code: code ?? this.code,
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [code!, id!, title!];
}
