// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_source/dto/dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attributes.g.dart';

@JsonSerializable()
class AttributesEntity implements DTO {
  @JsonKey(name: 'positions_distribution_by_type')
  final String positionByType;

  @JsonKey(name: 'positions_distribution_by_chain')
  final String positionByChain;

  final String total;

  final String changes;

  const AttributesEntity({
    required this.positionByType,
    required this.positionByChain,
    required this.total,
    required this.changes,
  });

  factory AttributesEntity.fromJson(Map<String, dynamic> json) =>
      _$AttributesEntityFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AttributesEntityToJson(this);
}
