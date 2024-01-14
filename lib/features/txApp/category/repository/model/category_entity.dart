// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_source/dto/dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_entity.g.dart';

@JsonSerializable(createFactory: true)
class CategoryEntity implements DTO {
  final int id;
  final String name;
  final String currency;
  @JsonKey(name: 'category_type')
  final String categoryType;
  final int color;
  final int icon;
  final String? description;
  final double amount;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.currency,
    required this.color,
    required this.icon,
    this.description,
    required this.amount,
    required this.categoryType,
  });

  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CategoryEntityToJson(this);
}
