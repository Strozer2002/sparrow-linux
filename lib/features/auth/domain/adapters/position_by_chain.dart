import 'package:hive/hive.dart';

part 'position_by_chain.g.dart';

@HiveType(typeId: 4)
class PositionByChain {
  @HiveField(0)
  int arbitrum;

  @HiveField(1)
  int aurora;

  @HiveField(2)
  int avalanche;

  @HiveField(3)
  int binanceSmartChain;

  @HiveField(4)
  int ethereum;

  @HiveField(5)
  int fantom;

  @HiveField(6)
  int loopring;

  @HiveField(7)
  int optimism;

  @HiveField(8)
  int polygon;

  @HiveField(9)
  int solana;

  @HiveField(10)
  int xdai;

  PositionByChain({
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
}
