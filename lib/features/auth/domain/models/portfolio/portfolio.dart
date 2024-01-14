// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_source/dto/dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'portfolio.g.dart';

@JsonSerializable(createFactory: true)
class PortfolioEntity implements DTO {
  @JsonKey(name: "total_value")
  final int? totalValue;
  @JsonKey(name: "absolute_change_24h")
  final int? absoluteChange;
  @JsonKey(name: "relative_change_24h")
  final int? relativeChange;

  const PortfolioEntity({
    required this.totalValue,
    required this.absoluteChange,
    required this.relativeChange,
  });

  factory PortfolioEntity.fromJson(Map<String, dynamic> json) =>
      _$PortfolioEntityFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PortfolioEntityToJson(this);
}
