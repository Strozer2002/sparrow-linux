// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeEntity _$ExchangeEntityFromJson(Map<String, dynamic> json) =>
    ExchangeEntity(
      id: json['id'] as int,
      amountFrom: (json['amount_from'] as num).toDouble(),
      amountInto: (json['amount_into'] as num).toDouble(),
      currencyFrom: json['currency_from'] as String,
      currencyInto: json['currency_into'] as String,
    );

Map<String, dynamic> _$ExchangeEntityToJson(ExchangeEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'currency_from': instance.currencyFrom,
      'currency_into': instance.currencyInto,
      'amount_from': instance.amountFrom,
      'amount_into': instance.amountInto,
    };
