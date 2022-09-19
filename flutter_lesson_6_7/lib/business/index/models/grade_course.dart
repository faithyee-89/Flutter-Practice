import 'package:equatable/equatable.dart';

class GradeCourse extends Equatable {
  final String h5site;
  final int id;
  final String imgUrl;
  final String name;
  final String website;

  const GradeCourse({
    this.h5site,
    this.id,
    this.imgUrl,
    this.name,
    this.website,
  });

  factory GradeCourse.fromJson(Map<String, dynamic> json) {
    return GradeCourse(
      h5site: json['h5site'] as String,
      id: json['id'] as int,
      imgUrl: json['img_url'] as String,
      name: json['name'] as String,
      website: json['website'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'h5site': h5site,
      'id': id,
      'img_url': imgUrl,
      'name': name,
      'website': website,
    };
  }

  GradeCourse copyWith({
    String h5site,
    int id,
    String imgUrl,
    String name,
    String website,
  }) {
    return GradeCourse(
      h5site: h5site ?? this.h5site,
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      name: name ?? this.name,
      website: website ?? this.website,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [h5site, id, imgUrl, name, website];
}
