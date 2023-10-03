// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_by_chain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PositionByChainEntity _$PositionByChainEntityFromJson(
        Map<String, dynamic> json) =>
    PositionByChainEntity(
      arbitrum: json['arbitrum'] as int,
      aurora: json['aurora'] as int,
      avalanche: json['avalanche'] as int,
      binanceSmartChain: json['binance-smart-chain'] as int,
      ethereum: json['ethereum'] as int,
      fantom: json['fantom'] as int,
      loopring: json['loopring'] as int,
      optimism: json['optimism'] as int,
      polygon: json['polygon'] as int,
      solana: json['solana'] as int,
      xdai: json['xdai'] as int,
    );

Map<String, dynamic> _$PositionByChainEntityToJson(
        PositionByChainEntity instance) =>
    <String, dynamic>{
      'arbitrum': instance.arbitrum,
      'aurora': instance.aurora,
      'avalanche': instance.avalanche,
      'binance-smart-chain': instance.binanceSmartChain,
      'ethereum': instance.ethereum,
      'fantom': instance.fantom,
      'loopring': instance.loopring,
      'optimism': instance.optimism,
      'polygon': instance.polygon,
      'solana': instance.solana,
      'xdai': instance.xdai,
    };
