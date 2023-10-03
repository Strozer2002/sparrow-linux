// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_source/dto/dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'position_by_chain.g.dart';

@JsonSerializable()
class PositionByChainEntity implements DTO {
  final int arbitrum;

  final int aurora;

  final int avalanche;

  @JsonKey(name: "binance-smart-chain")
  final int binanceSmartChain;

  final int ethereum;

  final int fantom;

  final int loopring;

  final int optimism;

  final int polygon;

  final int solana;

  final int xdai;

  const PositionByChainEntity({
    required this.arbitrum,
    required this.aurora,
    required this.avalanche,
    required this.binanceSmartChain,
    required this.ethereum,
    required this.fantom,
    required this.loopring,
    required this.optimism,
    required this.polygon,
    required this.solana,
    required this.xdai,
  });

  factory PositionByChainEntity.fromJson(Map<String, dynamic> json) =>
      _$PositionByChainEntityFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PositionByChainEntityToJson(this);
}
