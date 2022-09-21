// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageModule _$PageModuleFromJson(Map<String, dynamic> json) => PageModule(
      createdTime: json['created_time'] == null
          ? null
          : DateTime.parse(json['created_time'] as String),
      id: json['id'] as int?,
      isShowMore: json['is_show_more'] as int?,
      layout: json['layout'] as int?,
      moreRedirectUrl: json['more_redirect_url'] as String?,
      scroll: json['scroll'] as int?,
      subTitle: json['sub_title'] as String?,
      title: json['title'] as String?,
      type: json['type'] as int?,
      components: json['components'] as List<dynamic>?,
    );

Map<String, dynamic> _$PageModuleToJson(PageModule instance) =>
    <String, dynamic>{
      'created_time': instance.createdTime?.toIso8601String(),
      'id': instance.id,
      'is_show_more': instance.isShowMore,
      'layout': instance.layout,
      'more_redirect_url': instance.moreRedirectUrl,
      'scroll': instance.scroll,
      'sub_title': instance.subTitle,
      'title': instance.title,
      'type': instance.type,
      'components': instance.components,
    };
