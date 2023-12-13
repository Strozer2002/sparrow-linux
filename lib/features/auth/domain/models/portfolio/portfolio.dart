// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_source/dto/dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rabby/features/auth/domain/models/portfolio/attributes.dart';

part 'portfolio.g.dart';

@JsonSerializable(createFactory: true)
class PortfolioEntity implements DTO {
  final String type;

  final String id;

  final AttributesEntity attributes;

  const PortfolioEntity({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory PortfolioEntity.fromJson(Map<String, dynamic> json) =>
      _$PortfolioEntityFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PortfolioEntityToJson(this);
}
