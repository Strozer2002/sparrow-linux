// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListResponseBody<T> _$ListResponseBodyFromJson<T extends DTO>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ListResponseBody<T>(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)?.map(fromJsonT).toList(),
      success: json['success'] as bool?,
      errors: (json['errors'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      pagination: json['pagination'] == null
          ? null
          : PaginationData.fromJson(json['pagination'] as Map<String, dynamic>),
    );
