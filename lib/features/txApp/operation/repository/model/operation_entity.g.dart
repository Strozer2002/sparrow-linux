// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationEntity _$OperationEntityFromJson(Map<String, dynamic> json) =>
    OperationEntity(
      id: json['id'] as int,
      date: DateTime.parse(json['date'] as String),
      bankAccount: json['bank_account'] as int,
      amount: (json['amount'] as num).toDouble(),
      categoryType: json['category'] as String,
    );

Map<String, dynamic> _$OperationEntityToJson(OperationEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'category': instance.categoryType,
      'bank_account': instance.bankAccount,
      'amount': instance.amount,
    };
