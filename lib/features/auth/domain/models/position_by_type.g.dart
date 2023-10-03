// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_by_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PositionByTypeEntity _$PositionByTypeEntityFromJson(
        Map<String, dynamic> json) =>
    PositionByTypeEntity(
      wallet: json['wallet'] as int,
      deposited: json['deposited'] as int,
      borrowed: json['borrowed'] as int,
      locked: json['locked'] as int,
      staked: json['staked'] as int,
    );

Map<String, dynamic> _$PositionByTypeEntityToJson(
        PositionByTypeEntity instance) =>
    <String, dynamic>{
      'wallet': instance.wallet,
      'deposited': instance.deposited,
      'borrowed': instance.borrowed,
      'locked': instance.locked,
      'staked': instance.staked,
    };
