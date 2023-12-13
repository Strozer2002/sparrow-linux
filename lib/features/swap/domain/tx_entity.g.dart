// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tx_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TxEntity _$TxEntityFromJson(Map<String, dynamic> json) => TxEntity(
      data: json['data'] as String,
      from: json['from'] as String,
      gas: json['gas'] as int,
      gasPrice: json['gasPrice'] as String,
      to: json['to'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$TxEntityToJson(TxEntity instance) => <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'data': instance.data,
      'value': instance.value,
      'gas': instance.gas,
      'gasPrice': instance.gasPrice,
    };
