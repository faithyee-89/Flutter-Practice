import 'package:equatable/equatable.dart';

class Module extends Equatable {
  final String createdTime;
  final String dataUrl;
  final int id;
  final int isShowMore;
  final int layout;
  final dynamic moreRedirectUrl;
  final int scroll;
  final dynamic subTitle;
  final String title;
  final int type;
  final List<dynamic> components;

  const Module({
    this.createdTime,
    this.dataUrl,
    this.id,
    this.isShowMore,
    this.layout,
    this.moreRedirectUrl,
    this.scroll,
    this.subTitle,
    this.title,
    this.type,
    this.components,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      createdTime: json['created_time'] as String,
      dataUrl: json['data_url'] as String,
      id: json['id'] as int,
      isShowMore: json['is_show_more'] as int,
      layout: json['layout'] as int,
      moreRedirectUrl: json['more_redirect_url'],
      scroll: json['scroll'] as int,
      subTitle: json['sub_title'],
      title: json['title'] as String,
      type: json['type'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_time': createdTime,
      'data_url': dataUrl,
      'id': id,
      'is_show_more': isShowMore,
      'layout': layout,
      'more_redirect_url': moreRedirectUrl,
      'scroll': scroll,
      'sub_title': subTitle,
      'title': title,
      'type': type,
      'components': components,
    };
  }

  Module copyWith({
    String createdTime,
    String dataUrl,
    int id,
    int isShowMore,
    int layout,
    dynamic moreRedirectUrl,
    int scroll,
    dynamic subTitle,
    String title,
    int type,
    List<dynamic> components,
  }) {
    return Module(
      createdTime: createdTime ?? this.createdTime,
      dataUrl: dataUrl ?? this.dataUrl,
      id: id ?? this.id,
      isShowMore: isShowMore ?? this.isShowMore,
      layout: layout ?? this.layout,
      moreRedirectUrl: moreRedirectUrl ?? this.moreRedirectUrl,
      scroll: scroll ?? this.scroll,
      subTitle: subTitle ?? this.subTitle,
      title: title ?? this.title,
      type: type ?? this.type,
      components: components ?? this.components,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      createdTime,
      dataUrl,
      id,
      isShowMore,
      layout,
      moreRedirectUrl,
      scroll,
      subTitle,
      title,
      type,
      components,
    ];
  }
}
