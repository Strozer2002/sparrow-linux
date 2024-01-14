// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PositionEntity _$PositionEntityFromJson(Map<String, dynamic> json) =>
    PositionEntity(
      positions: (json['positions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      aggregationInProgress: json['aggregation_in_progress'] as bool,
    );

Map<String, dynamic> _$PositionEntityToJson(PositionEntity instance) =>
    <String, dynamic>{
      'positions': instance.positions,
      'aggregation_in_progress': instance.aggregationInProgress,
    };
