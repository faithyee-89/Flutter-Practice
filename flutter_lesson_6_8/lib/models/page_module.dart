import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'page_module.g.dart';

@JsonSerializable()
class PageModule extends Equatable {
    const PageModule({
              this.createdTime,
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
  @JsonKey(name: "created_time")
  final DateTime? createdTime;

  final int? id;

  @JsonKey(name: "is_show_more")
  final int? isShowMore;

  final int? layout;

  @JsonKey(name: "more_redirect_url")
  final String? moreRedirectUrl;

  final int? scroll;

  @JsonKey(name: "sub_title")
  final String? subTitle;

  final String? title;

  final int? type;

  final List? components;

  
  factory PageModule.fromJson(Map<String,dynamic> json) => _$PageModuleFromJson(json);
  Map<String, dynamic> toJson() => _$PageModuleToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
                createdTime ?? "",
        id ?? "",
        isShowMore ?? "",
        layout ?? "",
        moreRedirectUrl ?? "",
        scroll ?? "",
        subTitle ?? "",
        title ?? "",
        type ?? "",
        components ?? "",

    ];

  PageModule copyWith({
              DateTime? createdTime,
        int? id,
        int? isShowMore,
        int? layout,
        String? moreRedirectUrl,
        int? scroll,
        String? subTitle,
        String? title,
        int? type,
        List? components,

    }){

     return PageModule(
               createdTime: createdTime ?? this.createdTime,
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
}