// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryEntity _$CategoryEntityFromJson(Map<String, dynamic> json) =>
    CategoryEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      currency: json['currency'] as String,
      color: json['color'] as int,
      icon: json['icon'] as int,
      description: json['description'] as String?,
      amount: (json['amount'] as num).toDouble(),
      categoryType: json['category_type'] as String,
    );

Map<String, dynamic> _$CategoryEntityToJson(CategoryEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'currency': instance.currency,
      'category_type': instance.categoryType,
      'color': instance.color,
      'icon': instance.icon,
      'description': instance.description,
      'amount': instance.amount,
    };
