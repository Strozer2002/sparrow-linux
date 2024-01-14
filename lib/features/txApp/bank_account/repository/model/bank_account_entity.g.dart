// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_account_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankAccountEntity _$BankAccountEntityFromJson(Map<String, dynamic> json) =>
    BankAccountEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      currency: json['currency'] as String,
      color: json['color'] as int,
      icon: json['icon'] as int,
      description: json['description'] as String?,
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$BankAccountEntityToJson(BankAccountEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'currency': instance.currency,
      'color': instance.color,
      'icon': instance.icon,
      'description': instance.description,
      'amount': instance.amount,
    };
