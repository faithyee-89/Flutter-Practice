import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String? code;
  final int? id;
  final String? title;

  const Category({
    this.code,
    this.id,
    this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
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

  Category copyWith({
    String? code,
    int? id,
    String? title,
  }) {
    return Category(
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
