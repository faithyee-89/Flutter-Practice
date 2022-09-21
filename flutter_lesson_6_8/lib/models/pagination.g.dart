// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination<T> _$PaginationFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    Pagination<T>(
      page: json['page'] as int,
      size: json['size'] as int,
      datas: fromJsonT(json['datas']),
      totalPage: json['total_page'] as int,
    );

Map<String, dynamic> _$PaginationToJson<T>(
  Pagination<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'total_page': instance.totalPage,
      'datas': toJsonT(instance.datas),
    };
