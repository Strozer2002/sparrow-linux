import 'package:hive/hive.dart';

part 'position_by_type.g.dart';

@HiveType(typeId: 3)
class PositionByType {
  @HiveField(0)
  int wallet;

  @HiveField(1)
  int deposited;

  @HiveField(2)
  int borrowed;

  @HiveField(3)
  int locked;

  @HiveField(4)
  int staked;

  PositionByType({
    required this.wallet,
    required this.deposited,
    required this.borrowed,
    required this.locked,
    required this.staked,
  });
}
