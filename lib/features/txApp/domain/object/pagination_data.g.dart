// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationData _$PaginationDataFromJson(Map<String, dynamic> json) =>
    PaginationData(
      total: json['total'] as int,
      perPage: json['per_page'] as int,
    );

Map<String, dynamic> _$PaginationDataToJson(PaginationData instance) =>
    <String, dynamic>{
      'total': instance.total,
      'per_page': instance.perPage,
    };
