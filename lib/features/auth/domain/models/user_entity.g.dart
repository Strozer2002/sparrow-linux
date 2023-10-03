// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      address: json['address'] as String,
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      positions: (json['positions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      nft: json['nft'] as Map<String, dynamic>?,
      portfolio:
          PortfolioEntity.fromJson(json['portfolio'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'address': instance.address,
      'transactions': instance.transactions,
      'positions': instance.positions,
      'nft': instance.nft,
      'portfolio': instance.portfolio,
    };
