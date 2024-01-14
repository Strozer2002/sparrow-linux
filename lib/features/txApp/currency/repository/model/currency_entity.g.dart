// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyEntity _$CurrencyEntityFromJson(Map<String, dynamic> json) =>
    CurrencyEntity(
      name: json['name'] as String,
      symbol: json['symbol'] as String,
    );

Map<String, dynamic> _$CurrencyEntityToJson(CurrencyEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'symbol': instance.symbol,
    };
