// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_swap_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataSwapEntity _$DataSwapEntityFromJson(Map<String, dynamic> json) =>
    DataSwapEntity(
      tx: TxEntity.fromJson(json['tx'] as Map<String, dynamic>),
      toAmount: json['toAmount'] as String,
    );

Map<String, dynamic> _$DataSwapEntityToJson(DataSwapEntity instance) =>
    <String, dynamic>{
      'tx': instance.tx,
      'toAmount': instance.toAmount,
    };
