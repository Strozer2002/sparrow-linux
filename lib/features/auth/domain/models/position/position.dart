import 'package:data_source/dto/dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'position.g.dart';

@JsonSerializable(createFactory: true)
class PositionEntity implements DTO {
  final List<String>? positions;

  @JsonKey(name: "aggregation_in_progress")
  final bool aggregationInProgress;

  const PositionEntity({
    required this.positions,
    required this.aggregationInProgress,
  });

  factory PositionEntity.fromJson(Map<String, dynamic> json) =>
      _$PositionEntityFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PositionEntityToJson(this);
}
