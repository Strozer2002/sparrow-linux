import 'package:hive/hive.dart';

part 'portfolio.g.dart';

@HiveType(typeId: 11)
class Portfolio {
  @HiveField(0)
  int? totalValue;

  @HiveField(1)
  int? absoluteChange;

  @HiveField(2)
  int? relativeChange;

  Portfolio({
    required this.totalValue,
    required this.absoluteChange,
    required this.relativeChange,
  });
}
